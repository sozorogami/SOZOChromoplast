#import "UIColor+SOZOIntensity.h"

@implementation UIColor (SOZOIntensity)

- (float)intensity {
    CGFloat r, g, b;
    [self getRed:&r green:&g blue:&b alpha:NULL];
    return r + g + b;
}

@end
