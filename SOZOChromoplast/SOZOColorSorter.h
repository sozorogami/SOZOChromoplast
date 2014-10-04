@interface SOZOColorSorter : NSObject

+ (instancetype)colorSorterWithGranularity:(NSUInteger)numberOfPartitions;

- (NSArray *)sortColors:(NSArray *)colors;

@end
