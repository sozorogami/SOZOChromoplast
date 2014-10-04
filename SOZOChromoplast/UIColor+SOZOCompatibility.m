#import "UIColor+SOZOCompatibility.h"
#import "UIColor+SOZOIntensity.h"

const float kSOZOMinimumIntensityDifference = 1.f;

@implementation UIColor (SOZOCompatibility)

- (BOOL)sozo_isCompatibleWithColor:(UIColor *)color {
    return fabs([color intensity] - [self intensity]) > kSOZOMinimumIntensityDifference;
}

@end
