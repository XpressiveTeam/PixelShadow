#import "NSImage+Pixel.h"

@implementation NSImage (Pixel)

- (void)enumPixels:(PixelBlock)block
{
	int w = self.size.width;
	int h = self.size.height;
	
	for (int y = 0; y < h; y++) {
		for (int x = 0; x < w; x++) {
			block(x, y);
		}
	}
	
}

- (void)enumPixelColors:(PixelColorBlock)block
{
	NSBitmapImageRep *raw_img = [NSBitmapImageRep imageRepWithData:[self TIFFRepresentation]];
	
	[self enumPixels:^(int x, int y) {
		NSColor *color = [raw_img colorAtX:x y:y];
		block(x, y, color);
	}];
}

- (NSImage *)imageWithScale:(NSSize)scale
{
	NSRect rect = NSZeroRect;
	NSRect new_rect = NSZeroRect;
	rect.size = [self size];
	new_rect.size.width = (int)(rect.size.width * scale.width);
	new_rect.size.height = (int)(rect.size.height * scale.height);
	
	NSImage *newImage = [[NSImage alloc] initWithSize:new_rect.size];
	
	[newImage lockFocus];
	[NSGraphicsContext saveGraphicsState];
	[[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
	[self drawInRect:new_rect
			 fromRect:NSZeroRect
			operation:NSCompositeSourceOver
			 fraction:1.0];
	[NSGraphicsContext restoreGraphicsState];
	[newImage unlockFocus];
	
	return newImage;
}

@end
