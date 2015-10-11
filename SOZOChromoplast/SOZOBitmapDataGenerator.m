#import "SOZOBitmapDataGenerator.h"

@implementation SOZOBitmapDataGenerator

+ (NSArray *)bitmapDataForImage:(UIImage *)image {
    NSMutableArray *array = [NSMutableArray new];
    CGSize imageSize = image.size;
    CGContextRef context = [self ARGBContextWithSize:imageSize];
    unsigned char* cArray = [self rawBitmapDataForImage:image inContext:context];

    NSInteger numberOfPixels = (NSInteger) imageSize.width * imageSize.height;
    UIColor *color;
    for (int i = 0; i < numberOfPixels * 4; i += 4) {
        color = [UIColor colorWithRed:cArray[i+1]/255.f
                                green:cArray[i+2]/255.f
                                 blue:cArray[i+3]/255.f
                                alpha:cArray[i]/255.f];
        [array addObject:color];
    }

    CGContextRelease(context);
    return array;
}

+ (unsigned char *)rawBitmapDataForImage:(UIImage *)image inContext:(CGContextRef)context {
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextDrawImage(context, rect, image.CGImage);
    unsigned char *data = CGBitmapContextGetData(context);

    return data;
}

+ (CGContextRef)ARGBContextWithSize:(CGSize)size {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    if (!colorSpace) {
        [NSException raise:NSInternalInconsistencyException format:@"Error creating color space."];
    }

    // Cast to silence a type mismatch warning.
    // From the docs: The constants for specifying the alpha channel information are declared
    // with the `CGImageAlphaInfo` type but can be passed to [the bitmapInfo] parameter safely.
    CGBitmapInfo alphaSettings = (CGBitmapInfo) kCGImageAlphaPremultipliedFirst;
    CGContextRef contextRef = CGBitmapContextCreate(NULL, size.width, size.height, 8,
                                                    0, colorSpace, alphaSettings);
    if (!contextRef) {
        [NSException raise:NSInternalInconsistencyException format:@"Error creating context."];
    }

    CGColorSpaceRelease(colorSpace);
    return contextRef;
}


@end
