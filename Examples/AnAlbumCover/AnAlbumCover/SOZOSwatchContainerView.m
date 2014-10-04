#import "SOZOSwatchContainerView.h"
#import "UIView+SOZOAutoLayoutHelpers.h"
#import <SOZOChromoplast/UIColor+SOZOCompatibility.h>

typedef void(^SOZORemoveSubviewsCompletionBock)(void);

@interface SOZOSwatchContainerView ()

@property (nonatomic, strong) NSMutableArray *swatchViews;
@property (nonatomic, strong) NSMutableArray *swatchViewSizeConstraints;

@end

@implementation SOZOSwatchContainerView

- (instancetype)init {
    self = [[super init] forAutolayout];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        NSMutableArray *whites = [NSMutableArray new];
        for (int i = 0; i < 10; i++) {
            [whites addObject:[UIColor whiteColor]];
        }
        self.colors = whites;
        [self displayNewSwatchViews];
    }
    return self;
}

#pragma mark - Public Interface

- (void)setColors:(NSArray *)colors {
    NSParameterAssert([colors count] > 0);
    if ([colors count] < 1) {
        return;
    }
    if ([colors count] > 10) {
        NSMutableArray *subarray = [colors mutableCopy];
        colors = [subarray subarrayWithRange:NSMakeRange(0, 10)];
    }
    _colors = colors;
    [self setUpSwatchViews];
}

#pragma mark - Private Methods

- (void)setUpSwatchViews {
    [self removeAllSubviewsAnimatedWithComplete:^{
        [self displayNewSwatchViews];
    }];
}

- (void)removeAllSubviewsAnimatedWithComplete:(SOZORemoveSubviewsCompletionBock)block {
    __block NSInteger subviewsRemaining = [self.subviews count];
    __block float delay = 0.f;
    [self removeConstraints:self.swatchViewSizeConstraints];
    for (UIView *subview in self.subviews) {
        [subview removeAllConstraints];
        [subview constrainToSize:CGSizeMake(0.f, 0.f)];
        delay += 0.075f;
        [self startTwinklyAnimationWithSubview:subview delay:delay completion:^(BOOL finished) {
                [subview removeFromSuperview];
                subviewsRemaining--;
                if (subviewsRemaining == 0) {
                    if (block) {
                        block();
                    }
                }
        }];
    }
}

- (void)displayNewSwatchViews {
    [self initializeNewSwatches];
    [self drawBorderAroundFirstSwatch];
    [self layOutSwatchesWithZeroSize];
    [self animateSwatchesToFullSize];
}

- (void)initializeNewSwatches {
    self.swatchViews = [NSMutableArray new];
    for (UIColor *color in self.colors) {
        UIView *swatch = [[UIView new] forAutolayout];
        [swatch setBackgroundColor:color];
        [self.swatchViews addObject:swatch];
    }
}

- (void)drawBorderAroundFirstSwatch {
    UIView *firstView = self.swatchViews[0];
    UIColor *borderColor = [[UIColor blackColor] sozo_isCompatibleWithColor:self.colors[0]] ? [UIColor blackColor] : [UIColor whiteColor];
    firstView.layer.borderColor = [borderColor CGColor];
    firstView.layer.borderWidth = 2.f;
}

- (void)layOutSwatchesWithZeroSize {
    for (int i = 0; i < [self.swatchViews count]; i++) {
        UIView *swatch = self.swatchViews[i];
        [swatch constrainToSize:CGSizeMake(0, 0)];
        [self addSubview:swatch];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:swatch attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:swatch attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:(2.f*i + 1) / [self.colors count] constant:0]];
    }
    [self layoutIfNeeded];
}

- (void)animateSwatchesToFullSize {
    [self removeConstraints:self.swatchViewSizeConstraints];
    [self setUpSwatchViewSizeConstraints];

    //    Strange crash when -addConstraints: used instead.
    //    [self addConstraints:self.swatchViewSizeConstraints];
    for (NSLayoutConstraint *constraint in self.swatchViewSizeConstraints) {
        [self addConstraint:constraint];
    }
    [self doExplodeyAnimation];
}

- (void)setUpSwatchViewSizeConstraints {
    self.swatchViewSizeConstraints = [NSMutableArray new];
    NSInteger viewsRemaining = [self.swatchViews count];
    for (UIView *swatchView in self.swatchViews) {
        [swatchView removeAllConstraints];
        [swatchView constrainToSquare];

        // (1) Prevent overlap.
        [self.swatchViewSizeConstraints addObject:[self maxHeightConstraintForSwatchView:swatchView]];

        NSLayoutConstraint *swatchViewWidthConstraint;
        if (swatchView == self.swatchViews[0]) {
            // (2) As close to container width as possible without violating (1).
            swatchViewWidthConstraint = [self widthEqualToContainerConstraintForSwatchView:swatchView];
        } else {
            // (3) Proportionally smaller than (2) as you go down.
            swatchViewWidthConstraint = [self proportionalWidthConstraintForSwatchView:swatchView numberFromBottom:viewsRemaining];
        }
        [self.swatchViewSizeConstraints addObject:swatchViewWidthConstraint];
        viewsRemaining--;
    }
}

- (NSLayoutConstraint *)maxHeightConstraintForSwatchView:(UIView *)swatchView {
    NSLayoutConstraint *swatchViewHeightConstraint = [NSLayoutConstraint constraintWithItem:swatchView
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationLessThanOrEqual
                                                                             toItem:self
                                                                          attribute:NSLayoutAttributeHeight
                                                                         multiplier:1 / (float) [self.swatchViews count]
                                                                           constant:0];
    [swatchViewHeightConstraint setPriority:UILayoutPriorityDefaultHigh];
    return swatchViewHeightConstraint;
}

- (NSLayoutConstraint *)widthEqualToContainerConstraintForSwatchView:(UIView *)swatchView {
    NSLayoutConstraint *swatchViewWidthConstraint = [NSLayoutConstraint constraintWithItem:swatchView
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:self
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:1
                                                                                  constant:0];
    [swatchViewWidthConstraint setPriority:UILayoutPriorityDefaultLow];
    return swatchViewWidthConstraint;
}

- (NSLayoutConstraint *)proportionalWidthConstraintForSwatchView:(UIView *)swatchView
                                                numberFromBottom:(NSInteger)number {
    return  [NSLayoutConstraint constraintWithItem:swatchView
                                         attribute:NSLayoutAttributeWidth
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:self.swatchViews[0]
                                         attribute:NSLayoutAttributeWidth
                                        multiplier:number / (float) [self.colors count]
                                          constant:0];

}

#pragma mark - Animations

- (void)startTwinklyAnimationWithSubview:(UIView *)subview delay:(float)delay completion:(void (^)(BOOL finished))completion {
    [UIView animateWithDuration:0.75f
                          delay:delay
         usingSpringWithDamping:0.2f
          initialSpringVelocity:0.f
                        options:0
                     animations:^{
                         [subview layoutIfNeeded];
                     }
                     completion:completion];
}

- (void)doExplodeyAnimation {
    [UIView animateWithDuration:0.5f delay:0.f usingSpringWithDamping:0.35f initialSpringVelocity:0.f options:0 animations:^{
        [self layoutIfNeeded];
    } completion:nil];
}

@end
