#import "UIColor+SOZOCompatibility.h"

/**
 A chromoplast is initialized with a @p UIImage, which it analyzes
 to generate a color layout that goes nicely with that image.
 */
@interface SOZOChromoplast : NSObject

/**
 The color appearing most frequently in the image.
 */
@property (nonatomic, strong, readonly) UIColor *dominantColor;

/**
 The first of two colors selected from the image so as not to
 conflict with the dominant color.
 */
@property (nonatomic, strong, readonly) UIColor *firstHighlight;

/**
 The second of two colors selected from the image so as not to
 conflict with the dominant color.
 */
@property (nonatomic, strong, readonly) UIColor *secondHighlight;

/**
 An array of colors in the image, in order of prominence.
 */
@property (nonatomic, strong, readonly) NSArray *colors;

/**
 Designated initializer.
 @param image The image to analyze.
 @return A new instance of a chromoplast.
 */
- (instancetype)initWithImage:(UIImage *)image;

@end