#import "SOZOColorCube.h"

@interface SOZOColorCube ()

@property (strong, nonatomic) NSMutableArray *colors;

@end

@implementation SOZOColorCube

- (instancetype)init {
    self = [super init];
    if (self) {
        _colors = [NSMutableArray new];
    }
    return self;
}

- (void)addColor:(UIColor *)color {
    NSParameterAssert(color);
    [self.colors addObject:color];
}

- (UIColor *)meanColor {
    NSInteger colorCount = [self.colors count];
    if (colorCount == 0) {
        return nil;
    }
    CGFloat total_r = 0.f, total_g = 0.f, total_b = 0.f;
    CGFloat color_r, color_g, color_b;
    for (UIColor *color in self.colors) {
        [color getRed:&color_r green:&color_g blue:&color_b alpha:NULL];
        total_r += color_r;
        total_g += color_g;
        total_b += color_b;
    }
    return [UIColor colorWithRed:total_r / colorCount
                           green:total_g / colorCount
                            blue:total_b / colorCount
                           alpha:1.0f];
}

@end
