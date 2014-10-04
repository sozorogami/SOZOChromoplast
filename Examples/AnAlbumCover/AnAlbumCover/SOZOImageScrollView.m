#import "SOZOImageScrollView.h"
#import "UIView+SOZOAutoLayoutHelpers.h"


#pragma mark - Main Implementation

@interface SOZOImageScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) CGFloat border;

@property (nonatomic, strong) UIView *firstImageView;
@property (nonatomic, strong) UIView *lastImageView;

@end

@implementation SOZOImageScrollView

#pragma mark - Object Lifecycle

- (instancetype)initWithImages:(NSArray *)images {
    self = [[super init] forAutolayout];
    if (self) {
        [self configure];
        [self configureContentView];
        [self addImageViewsToContentView:[self imageViewsFromImages:images]];
        [self setFirstAndLastImageView];
        [self setLayoutForImageViews];
        [self setVisibleAreaToImageViewSize];
    }
    return self;
}

#pragma mark - Public Interface

- (UIImage *)presentedImage {
    for (UIImageView *view in self.contentView.subviews) {
        if (view.frame.origin.x >= self.bounds.origin.x) {
            return view.image;
        }
    }
    return nil;
}

#pragma mark - Private Methods

- (void)configure {
    [self setBorder:15.f];
    [self setDelegate:self];
    [self setVisibleIndex:0];
    [self setShowsHorizontalScrollIndicator:NO];
    [self setShowsVerticalScrollIndicator:NO];
    [self setBackgroundColor:[UIColor brownColor]];
    [self setPagingEnabled:YES];
}

- (void)configureContentView {
    self.contentView = [[UIView new] forAutolayout];
    [self addSubview:self.contentView];
    [self pinSubviewToAllInteriorSides:self.contentView];
}

- (void)addImageViewsToContentView:(NSArray *)imageViews {
    for (UIView *imageView in imageViews) {
        [self.contentView addSubview:imageView];
    }
}

- (NSArray *)imageViewsFromImages:(NSArray *)images {
    NSMutableArray *imageViews = [NSMutableArray new];
    UIImageView *imageView;
    for (UIImage *image in images) {
        imageView = [[[UIImageView alloc] initWithImage:image] forAutolayout];
        [imageView constrainToSize:CGSizeMake(200.f, 200.f)];
        [imageViews addObject:imageView];
    }
    return imageViews;
}

- (void)setFirstAndLastImageView {
    self.firstImageView = [self.contentView.subviews firstObject];
    self.lastImageView = [self.contentView.subviews lastObject];
}

- (void)setLayoutForImageViews {
    UIView *previousView;
    for (UIView *view in self.contentView.subviews) {
        if (view == self.firstImageView) {
            [self.contentView pinSubview:view toLeftSideWithPadding:self.border];
        } else {
            [self.contentView attachSubview:view toRightSideOfSubview:previousView withPadding:self.border*2];
        }
        if (view == self.lastImageView) {
            [self.contentView pinSubview:view toRightSideWithPadding:self.border];
        }
        [self.contentView pinSubview:view toTopAndBottomWithPadding:self.border];
        previousView = view;
    }
}

- (void)setVisibleAreaToImageViewSize {
    UIView *view = self.contentView.subviews[0];
    [self setEqualWidthsWithView:view withPadding:self.border*2];
    [self setEqualHeightsWithView:view withPadding:self.border*2];
}

- (void)updateVisibleIndex {
    self.visibleIndex = self.contentOffset.x * [self.contentView.subviews count] / self.contentSize.width;
}

#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger previousIndex = self.visibleIndex;
    [self updateVisibleIndex];
    if (previousIndex != self.visibleIndex) {
        [self.updateDelegate imageScrollViewDidChangePresentedIndex:self];
    }
}

@end
