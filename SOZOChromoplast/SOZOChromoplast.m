#import "SOZOChromoplast.h"
#import "SOZOBitmapDataGenerator.h"
#import "UIImage+SOZOResize.h"
#import "SOZOColorSorter.h"
#import "UIColor+SOZOCompatibility.h"

@interface SOZOChromoplast ()

@property (nonatomic, strong) UIColor *dominantColor;
@property (nonatomic, strong) UIColor *firstHighlight;
@property (nonatomic, strong) UIColor *secondHighlight;
@property (nonatomic, strong) NSArray *colors;

@end

@implementation SOZOChromoplast


- (instancetype)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        NSArray *pixelColors = [SOZOBitmapDataGenerator bitmapDataForImage:[image downsizeIfNeeded]];
        SOZOColorSorter *sorter = [SOZOColorSorter colorSorterWithGranularity:8];
        _colors = [sorter sortColors:pixelColors];
        [self setUpColors];
    }
    return self;
}

- (void)setUpColors {
    NSMutableArray *colors = [_colors mutableCopy];
    _dominantColor = colors[0];
    [colors removeObjectAtIndex:0];
    for (UIColor *color in _colors) {
        if (![color sozo_isCompatibleWithColor:_dominantColor]) {
            [colors removeObject:color];
        }
    }
    _firstHighlight = [colors count] > 0 ? colors[0] : [self defaultFirstHighlight];
    _secondHighlight = [colors count] > 1 ? colors[1] : [self defaultSecondHighlight];
}

- (UIColor *)defaultFirstHighlight {
    return [self.dominantColor brightness] > 0.5 ?
    [[self.dominantColor sozo_darkerShade] sozo_darkerShade] :
    [[self.dominantColor sozo_lighterShade] sozo_lighterShade];
}

- (UIColor *)defaultSecondHighlight {
    return [self.dominantColor brightness] > 0.5 ?
    [self.dominantColor sozo_darkerShade] : [self.dominantColor sozo_lighterShade];
}

@end
