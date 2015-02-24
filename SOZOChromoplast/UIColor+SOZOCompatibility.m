#import "UIColor+SOZOCompatibility.h"

const float kSOZOMinimumIntensityDifference = 0.35f;

@implementation UIColor (SOZOCompatibility)

- (BOOL)sozo_isCompatibleWithColor:(UIColor *)color {
    return fabs([color brightness] - [self brightness]) > kSOZOMinimumIntensityDifference;
}

- (UIColor *)sozo_darkerShade {
    CGFloat newBrightness = [self brightness] - kSOZOMinimumIntensityDifference;
    if (newBrightness < 0.f) {
        newBrightness = 0.f;
    }
    CGFloat hue, saturation;
    [self getHue:&hue saturation:&saturation brightness:NULL alpha:NULL];
    return [UIColor colorWithHue:hue saturation:saturation brightness:newBrightness alpha:1.f];
}

- (UIColor *)sozo_lighterShade {
    CGFloat newBrightness = [self brightness] + kSOZOMinimumIntensityDifference;
    if (newBrightness > 1.f) {
        newBrightness = 1.f;
    }
    CGFloat hue, saturation;
    [self getHue:&hue saturation:&saturation brightness:NULL alpha:NULL];
    return [UIColor colorWithHue:hue saturation:saturation brightness:newBrightness alpha:1.f];
}

- (float)brightness {
    CGFloat brightness;
    [self getHue:NULL saturation:NULL brightness:&brightness alpha:NULL];
    return brightness;
}

@end
