#import <Kiwi/Kiwi.h>
#import "SOZOColorCube.h"


SPEC_BEGIN(SOZOColorCubeSpec)

describe(@"SOZOColorCube", ^{
    __block SOZOColorCube *sut;
    beforeEach(^{
        sut = [SOZOColorCube new];
    });
    describe(@"-addColor:", ^{
        context(@"when the parameter is nil", ^{
            it(@"raises", ^{
                [[theBlock(^{
                    [sut addColor:nil];
                }) should] raise];
            });
        });
        context(@"when the parameter is a UIColor", ^{
            beforeEach(^{
                [sut addColor:[UIColor blueColor]];
            });
            it(@"adds it to its colors array", ^{
                [[sut.colors should] equal:@[[UIColor blueColor]]];
            });
        });
    });
    describe(@"-meanColor", ^{
        context(@"when the cube contains no colors", ^{
            it(@"returns nil", ^{
                [[[sut meanColor] should] beNil];
            });
        });
        context(@"when the cube contains one color", ^{
            beforeEach(^{
                [sut addColor:[UIColor redColor]];
            });
            it(@"returns that color", ^{
                CGFloat red;
                [[sut meanColor] getRed:&red green:NULL blue:NULL alpha:NULL];
                [[theValue(red) should] equal:1 withDelta:0.1];
            });
        });
        context(@"when the cube contains several colors", ^{
            beforeEach(^{
                [sut addColor:[UIColor redColor]];
                [sut addColor:[UIColor greenColor]];
                [sut addColor:[UIColor blueColor]];
            });
            it(@"returns a color representing the average of those colors", ^{
                CGFloat red, green, blue;
                [[sut meanColor] getRed:&red green:&green blue:&blue alpha:NULL];
                [[theValue(red) should] equal:0.333f withDelta:0.001];
                [[theValue(green) should] equal:0.333f withDelta:0.001];
                [[theValue(blue) should] equal:0.333f withDelta:0.001];
            });
        });
    });
});

SPEC_END
