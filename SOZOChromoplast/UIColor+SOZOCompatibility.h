@interface UIColor (SOZOCompatibility)

/**
 Returns a boolean value that indicates whether the receiver and a given
 color are compatible. More specifically, this ensures that text in one
 color is visible when displayed on the other. You can use this to determine
 if elements in your layout whose colors aren't set via chromoplast - the status
 bar, for example - work with the chromoplast colors.
 @param color The color to test.
 @return @p YES if the colors are compatible, @p NO otherwise.
 */
- (BOOL)sozo_isCompatibleWithColor:(UIColor *)color;
- (UIColor *)sozo_darkerShade;
- (UIColor *)sozo_lighterShade;
- (float)brightness;

@end
