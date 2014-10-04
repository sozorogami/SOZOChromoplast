#import <Kiwi/Kiwi.h>
#import "SOZOColorSorter.h"

BOOL equalColors(UIColor *color1, UIColor *color2) {
    float acceptableDelta = 0.0001f;
    CGFloat red1, green1, blue1;
    CGFloat red2, green2, blue2;
    [color1 getRed:&red1 green:&green1 blue:&blue1 alpha:NULL];
    [color2 getRed:&red2 green:&green2 blue:&blue2 alpha:NULL];
    return  fabs(red2 - red1) < acceptableDelta &&
            fabs(green2 - green1) < acceptableDelta &&
            fabs(blue2 - blue1) < acceptableDelta;
}

SPEC_BEGIN(SOZOColorSorterSpec)

describe(@"SOZOColorSorter", ^{
    __block SOZOColorSorter *sut;
    describe(@"-sortColors:", ^{
        beforeEach(^{
            sut = [SOZOColorSorter colorSorterWithGranularity:10];
        });
        context(@"when passed nil", ^{
            it(@"returns nil", ^{
                [[[sut sortColors:nil] should] beNil];
            });
        });
        context(@"when passed an empty array", ^{
            it(@"returns an empty array", ^{
                [[[sut sortColors:@[]] should] equal:@[]];
            });
        });
        context(@"when passed an array containing non-color objects", ^{
            it(@"ignores those objects", ^{
                    [[[sut sortColors:@[@"muave", @"teal", @"mother-of-pearl"]] should] equal:@[]];
            });
        });
        context(@"when passed an array of color objects", ^{
            __block NSArray *colors;
            beforeEach(^{
                colors = @[[UIColor whiteColor],
                           [UIColor whiteColor],
                           [UIColor whiteColor],
                           [UIColor colorWithRed:0.52f green:0.52f blue:0.52f alpha:1.f],
                           [UIColor colorWithRed:0.54f green:0.54f blue:0.54f alpha:1.f],
                           [UIColor colorWithRed:0.75f green:0.f blue:0.f alpha:1.f],
                           [UIColor blackColor]];
            });
            it(@"returns an array of colors", ^{
                [[theValue([[sut sortColors:colors] count]) should] equal:@4];
            });
            describe(@"the array", ^{
                __block NSArray *theArray;
                beforeEach(^{
                    theArray = [sut sortColors:colors];
                });
                it(@"orders the colors by frequency", ^{
                    [[theValue(equalColors([UIColor whiteColor], theArray[0])) should] beYes];
                });
                it(@"averages colors within the same cube of color space into one color", ^{
                    [[theValue(equalColors([UIColor colorWithRed:0.53f green:0.53f blue:0.53f alpha:1.f], theArray[1])) should] beYes];
                });
            });
        });
    });
});

SPEC_END
