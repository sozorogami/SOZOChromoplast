#import <UIKit/UIKit.h>

@class SOZOImageScrollView;
@protocol SOZOImageScrollViewDelegate <NSObject>

- (void)imageScrollViewDidChangePresentedIndex:(SOZOImageScrollView *)imageScrollView;

@end

@interface SOZOImageScrollView : UIScrollView

@property (nonatomic, assign) NSInteger visibleIndex;
@property (nonatomic, weak) NSObject <SOZOImageScrollViewDelegate> *updateDelegate;
- (instancetype)initWithImages:(NSArray *)images;
- (UIImage *)presentedImage;

@end