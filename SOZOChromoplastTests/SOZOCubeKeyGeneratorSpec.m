#import <Kiwi/Kiwi.h>
#import "SOZOCubeKeyGenerator.h"


SPEC_BEGIN(SOZOCubeKeyGeneratorSpec)

describe(@"SOZOCubeKeyGenerator", ^{
    __block SOZOCubeKeyGenerator *sut;
    __block SOZOFloatTriple testTriple;
    beforeEach(^{
        sut = [SOZOCubeKeyGenerator new];
        testTriple.a = 0.f;
        testTriple.b = 0.5f;
        testTriple.c = 1.0f;
    });
    describe(@"-keyForTriple:", ^{
        context(@"when granularity is not set", ^{
            it(@"raises", ^{
                [[theBlock(^{
                    [sut keyForTriple:testTriple];
                }) should] raise];
            });
        });
        context(@"when granularity is set", ^{
            beforeEach(^{
                sut = [SOZOCubeKeyGenerator keyGeneratorWithGranularity:10];
            });
            it(@"returns a key with three zero-padded values, representing which partitions the input fall into", ^{
                NSString *key = [sut keyForTriple:testTriple];
                [[key should] equal:@"00-05-10"];
            });
        });
    });
});

SPEC_END
