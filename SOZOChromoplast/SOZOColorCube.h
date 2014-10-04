@interface SOZOColorCube : NSObject

@property (strong, nonatomic, readonly) NSMutableArray *colors;

- (void)addColor:(UIColor *)color;
- (UIColor *)meanColor;

@end
