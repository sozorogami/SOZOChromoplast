#import "UIColor+SOZOCompatibility.h"
#import "UIColor+SOZOIntensity.h"

const float kSOZOMinimumIntensityDifference = 0.35f;

@implementation UIColor (SOZOCompatibility)

- (BOOL)sozo_isCompatibleWithColor:(UIColor *)color {
    return fabs([color brightness] - [self brightness]) > kSOZOMinimumIntensityDifference;
}

@end
