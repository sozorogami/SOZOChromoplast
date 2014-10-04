typedef struct {
    CGFloat a, b, c;
} SOZOFloatTriple;

@interface SOZOCubeKeyGenerator : NSObject

+ (instancetype)keyGeneratorWithGranularity:(NSUInteger)numberOfPartitions;

- (NSString *)keyForTriple:(SOZOFloatTriple)triple;

@end
