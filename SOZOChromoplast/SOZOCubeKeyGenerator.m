#import "SOZOCubeKeyGenerator.h"

@interface SOZOCubeKeyGenerator ()

@property (nonatomic, assign) NSInteger granularity;

@end

@implementation SOZOCubeKeyGenerator

+ (instancetype)keyGeneratorWithGranularity:(NSUInteger)numberOfPartitions {
    SOZOCubeKeyGenerator *generator = [SOZOCubeKeyGenerator new];
    generator.granularity = numberOfPartitions;
    return generator;
}

- (NSString *)keyForTriple:(SOZOFloatTriple)triple {
    NSParameterAssert(self.granularity);
    return [NSString stringWithFormat:@"%@-%@-%@", [self paddedStringForValue:triple.a],
                                                   [self paddedStringForValue:triple.b],
                                                   [self paddedStringForValue:triple.c]];
}

- (NSString *)paddedStringForValue:(float)value {
    NSUInteger partitionNumber = floorf(value * self.granularity);
    NSUInteger paddingWidth = [[NSString stringWithFormat:@"%ld", (long)self.granularity] length];
    return [NSString stringWithFormat:@"%0*lu", (int)paddingWidth, (unsigned long)partitionNumber];
}

@end
