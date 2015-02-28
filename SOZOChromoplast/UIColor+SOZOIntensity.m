#import "UIColor+SOZOIntensity.h"

@implementation UIColor (SOZOIntensity)

- (float)brightness {
    CGFloat brightness;
    [self getHue:NULL saturation:NULL brightness:&brightness alpha:NULL];
    return brightness;
}

@end
