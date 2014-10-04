#import "SOZOBitmapDataGenerator.h"

@implementation SOZOBitmapDataGenerator

+ (NSArray *)bitmapDataForImage:(UIImage *)image {
    NSMutableArray *array = [NSMutableArray new];
    unsigned char* cArray = [self rawBitmapDataForImage:image];
    NSInteger numberOfPixels = (NSInteger) [image size].width * [image size].height;
    UIColor *color;
    for (int i = 0; i < numberOfPixels * 4; i += 4) {
        color = [UIColor colorWithRed:cArray[i+1]/255.f
                                green:cArray[i+2]/255.f
                                 blue:cArray[i+3]/255.f
                                alpha:cArray[i]/255.f];
        [array addObject:color];
    }
    return array;
}

+ (unsigned char *)rawBitmapDataForImage:(UIImage *)image {
    CGContextRef contextRef = [self ARGBContextWithSize:image.size];
    if (!contextRef) {
        return NULL;
    }

    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextDrawImage(contextRef, rect, image.CGImage);
    unsigned char *data = CGBitmapContextGetData(contextRef);
    CGContextRelease(contextRef);

    return data;
}

+ (CGContextRef)ARGBContextWithSize:(CGSize)size {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    if (!colorSpace) {
        [NSException raise:NSInternalInconsistencyException format:@"Error creating color space."];
    }

    NSInteger bytesPerPixel = 4;
    unsigned long bytesPerRow = size.width * bytesPerPixel;
    unsigned long totalBytes = bytesPerRow * size.height;

    void *bitmapData = malloc(totalBytes);
    if (!bitmapData) {
        [NSException raise:NSInternalInconsistencyException format:@"Memory allocation error."];
    }

    // Cast to silence a type mismatch warning.
    // From the docs: The constants for specifying the alpha channel information are declared
    // with the `CGImageAlphaInfo` type but can be passed to [the bitmapInfo] parameter safely.
    CGBitmapInfo alphaSettings = (CGBitmapInfo) kCGImageAlphaPremultipliedFirst;
    CGContextRef contextRef = CGBitmapContextCreate(bitmapData, size.width, size.height, 8,
                                                    bytesPerRow, colorSpace, alphaSettings);
    if (!contextRef) {
        [NSException raise:NSInternalInconsistencyException format:@"Error creating context."];
    }

    CGColorSpaceRelease(colorSpace);
    return contextRef;
}


@end
