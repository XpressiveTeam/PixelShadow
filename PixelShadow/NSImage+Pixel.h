#import <Cocoa/Cocoa.h>

typedef void (^PixelBlock)(int x, int y);
typedef void (^PixelColorBlock)(int x, int y, NSColor *color);

@interface NSImage (Pixel)

- (void)enumPixels:(PixelBlock)block;
- (void)enumPixelColors:(PixelColorBlock)block;
- (NSImage *)imageWithScale:(NSSize)scale;
@end
