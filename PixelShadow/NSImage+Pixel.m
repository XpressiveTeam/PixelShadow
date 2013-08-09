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

	NSBitmapImageRep *rep = [[NSBitmapImageRep alloc]
							 initWithBitmapDataPlanes:NULL
							 pixelsWide:new_rect.size.width
							 pixelsHigh:new_rect.size.height
							 bitsPerSample:8
							 samplesPerPixel:4
							 hasAlpha:YES
							 isPlanar:NO
							 colorSpaceName:NSCalibratedRGBColorSpace
							 bytesPerRow:0
							 bitsPerPixel:0];
	[rep setSize:new_rect.size];
	
	[NSGraphicsContext saveGraphicsState];
	[NSGraphicsContext setCurrentContext:[NSGraphicsContext graphicsContextWithBitmapImageRep:rep]];
	[self drawInRect:new_rect fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0];
	[NSGraphicsContext restoreGraphicsState];
	
	NSData *data = [rep representationUsingType:NSPNGFileType properties:nil];
	NSImage *newImage = [[NSImage alloc] initWithData:data];
	
	return newImage;
}

@end
