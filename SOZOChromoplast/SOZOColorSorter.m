#import "SOZOColorSorter.h"
#import "SOZOCubeKeyGenerator.h"
#import "SOZOColorCube.h"

@interface SOZOColorSorter ()

@property (nonatomic, strong) SOZOCubeKeyGenerator *keyGenerator;

@end

@implementation SOZOColorSorter

+ (instancetype)colorSorterWithGranularity:(NSUInteger)numberOfPartitions {
    SOZOColorSorter *sorter = [SOZOColorSorter new];
    sorter.keyGenerator = [SOZOCubeKeyGenerator keyGeneratorWithGranularity:numberOfPartitions];
    return sorter;
}

- (NSArray *)sortColors:(NSArray *)colors {
    NSParameterAssert(self.keyGenerator);
    if (!colors) {
        return nil;
    }
    NSMutableDictionary *cubes = [NSMutableDictionary new];
    SOZOFloatTriple rgb;
    SOZOColorCube *cube;
    for (UIColor *color in colors) {
        if (![color isKindOfClass:[UIColor class]]) {
            continue;
        }
        [color getRed:&rgb.a green:&rgb.b blue:&rgb.c alpha:NULL];
        NSString *key = [self.keyGenerator keyForTriple:rgb];
        cube = cubes[key];
        if (!cube) {
            cube = [[SOZOColorCube alloc] init];
            cubes[key] = cube;
        }
        [cube addColor:color];
    }

    NSArray *fullCubes = [cubes allValues];
    fullCubes = [fullCubes sortedArrayUsingComparator:^NSComparisonResult(SOZOColorCube *cube1, SOZOColorCube *cube2) {
        NSNumber *count1 = [NSNumber numberWithInteger:[cube1.colors count]];
        NSNumber *count2 = [NSNumber numberWithInteger:[cube2.colors count]];
        return [count2 compare:count1];
    }];

    NSMutableArray *sortedColors = [NSMutableArray new];
    for (SOZOColorCube *cube in fullCubes) {
        [sortedColors addObject:[cube meanColor]];
    }

    return sortedColors;
}

@end
