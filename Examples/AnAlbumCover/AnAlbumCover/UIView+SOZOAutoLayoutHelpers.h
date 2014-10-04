#import <UIKit/UIKit.h>

@interface UIView (SOZOAutoLayoutHelpers)

- (instancetype)forAutolayout;
- (void)pinSubviewToAllInteriorSides:(UIView *)subview;
- (void)pinSubview:(UIView *)view toTopAndBottomWithPadding:(CGFloat)padding;
- (void)pinSubview:(UIView *)view toTopWithPadding:(CGFloat)padding;
- (void)pinSubview:(UIView *)view toBottomWithPadding:(CGFloat)padding;
- (void)pinSubview:(UIView *)view toLeftSideWithPadding:(CGFloat)padding;
- (void)pinSubview:(UIView *)view toRightSideWithPadding:(CGFloat)padding;
- (void)attachSubview:(UIView *)view1 toRightSideOfSubview:(UIView *)view2 withPadding:(CGFloat)padding;
- (void)attachSubview:(UIView *)view1 toBottomOfSubview:(UIView *)view2 withPadding:(CGFloat)padding;
- (void)setEqualWidthsWithView:(UIView *)view withPadding:(CGFloat)padding;
- (void)setEqualHeightsWithView:(UIView *)view withPadding:(CGFloat)padding;
- (void)constrainToSize:(CGSize)size;
- (void)evenlyDistributeViewsVerticallyInside:(NSArray *)views;
- (void)leftAlignViewsInside:(NSArray *)views withPadding:(CGFloat)padding;
- (void)centerSubviewHorizontallyInside:(UIView *)subview;
- (void)removeAllConstraints;
- (void)constrainToSquare;

@end
