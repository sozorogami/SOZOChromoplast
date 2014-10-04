#import "UIView+SOZOAutoLayoutHelpers.h"

@implementation UIView (SOZOAutoLayoutHelpers)

- (instancetype)forAutolayout {
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    return self;
}

- (void)pinSubviewToAllInteriorSides:(UIView *)subview {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:subview
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:subview
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:subview
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:subview
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1
                                                      constant:0]];
}

- (void)pinSubview:(UIView *)view toTopAndBottomWithPadding:(CGFloat)padding {
    [self pinSubview:view toTopWithPadding:padding];
    [self pinSubview:view toBottomWithPadding:padding];
}

- (void)pinSubview:(UIView *)view toTopWithPadding:(CGFloat)padding {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.f
                                                      constant:padding]];
}

- (void)pinSubview:(UIView *)view toBottomWithPadding:(CGFloat)padding {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.f
                                                      constant:-padding]];
}

- (void)pinSubview:(UIView *)view toLeftSideWithPadding:(CGFloat)padding {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1.f
                                                      constant:padding]];
}

- (void)pinSubview:(UIView *)view toRightSideWithPadding:(CGFloat)padding {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1
                                                      constant:-padding]];
}

- (void)attachSubview:(UIView *)view1 toRightSideOfSubview:(UIView *)view2 withPadding:(CGFloat)padding {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view1
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view2
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1.f
                                                      constant:padding]];
}

- (void)attachSubview:(UIView *)view1 toBottomOfSubview:(UIView *)view2 withPadding:(CGFloat)padding {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view1
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view2
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.f
                                                      constant:padding]];
}

- (void)setEqualWidthsWithView:(UIView *)view withPadding:(CGFloat)padding {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.f
                                                      constant:padding]];
}

- (void)setEqualHeightsWithView:(UIView *)view withPadding:(CGFloat)padding {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:1.f
                                                      constant:padding]];
}

- (void)constrainToSize:(CGSize)size {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:0
                                                      constant:size.height]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:0
                                                      constant:size.width]];
}

- (void)evenlyDistributeViewsVerticallyInside:(NSArray *)views {
    NSInteger viewNumber = 0;
    for (UIView *view in views) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:(2.f*viewNumber + 1) / [views count] constant:0]];
        viewNumber++;
    }
}

- (void)leftAlignViewsInside:(NSArray *)views withPadding:(CGFloat)padding {
    for (UIView *view in views) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeft
                                                        multiplier:1
                                                          constant:padding]];
    }
}

- (void)centerSubviewHorizontallyInside:(UIView *)subview {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:subview
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1
                                                      constant:0]];
}

- (void)removeAllConstraints {
    [self removeConstraints:[self constraints]];
}

- (void)constrainToSquare {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1
                                                      constant:0]];
}

@end
