#import "UIImage+SOZOResize.h"

const float MAX_PIXELS = 10000.f;

@implementation UIImage (SOZOResize)

- (UIImage *)downsizeIfNeeded {
    if (self.size.width * self.size.height < MAX_PIXELS) {
        return self;
    }
    float resizeRatio = sqrtf(MAX_PIXELS / (self.size.width * self.size.height));
    CGSize newSize = CGSizeMake(self.size.width * resizeRatio,
                                self.size.height * resizeRatio);
    UIGraphicsBeginImageContextWithOptions(newSize, YES, 1.0);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
