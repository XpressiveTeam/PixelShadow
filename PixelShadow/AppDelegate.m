#import "AppDelegate.h"
#import "NSImage+Pixel.h"
#import "NSColor+CSS.h"
#import "NSArray+Shuffle.h"
#import "NSString+Format.h"
#import "NSWindow+UI.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
}

- (void)openDocument:(id)sender
{
	
	NSOpenPanel *openPanel = [NSOpenPanel openPanel];
	[openPanel setAllowedFileTypes:@[@"png", @"jpg", @"jpeg", @"gif", @"bmp"]];
	
	void (^handler)(NSInteger);
	handler = ^(NSInteger result) {
		if(result == NSFileHandlingPanelOKButton){
			[self loadFile:openPanel.URL];
		}
	};
	[openPanel beginSheetModalForWindow:self.window completionHandler:handler];

}

- (void)loadFile:(NSURL *)fileURL
{
	loadedImage = [[NSImage alloc] initWithContentsOfURL:fileURL];
	imageWell.image = loadedImage;
	
	int w = loadedImage.size.width;
	int h = loadedImage.size.height;
	
	[imageScroller.contentView scrollToPoint:NSZeroPoint];
	[imageWell setFrameSize:NSMakeSize(w, h)];
	
	NSString *sizeString = [NSString stringWithFormat:@"w:%i × h:%i", w, h];
	sizeLabel.stringValue = sizeString;
}

- (void)execute:(id)sender
{
	if ( loadedImage == nil ) {
		[self alertWithTitle:@"No Image To Convert" message:@"Open Image File before Execute."];
		return;
	}
	
	int s = [sizeTextField intValue];
	if( adjustPosButton.state == NSOffState && s > 1 ){
		s = s * 2;
	}
	
	int imageW = loadedImage.size.width;
	int imageH = loadedImage.size.height;
	
	float scale = 1.0f / (double)s;
	
	NSSize scaleSize = NSMakeSize(scale, scale);
	
	if( scaleSize.width * imageW < 1 || scaleSize.height * imageH < 1 ){
		[self alertWithTitle:@"Pixel Size Error" message:@"Pixel Size must be less than Image Width or Height."];
		return;
	}
	
	NSImage *image = [loadedImage imageWithScale:scaleSize];
	
	[self.window lockUI];
	[executeButton setHidden:YES];
	[indicator setHidden:NO];
	[indicator startAnimation:nil];
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		
		NSArray *values = [self createBoxShadowValues:image size:[sizeTextField intValue] blur:[blurTextField intValue]];
		lastResultValues = [values copy];
		
		dispatch_async(dispatch_get_main_queue(), ^{
			
			[self applyResult:values];
			[preview setDocumentSize:NSMakeSize(imageW, imageH)];
			
			[self.window unlockUI];
			[indicator setHidden:YES];
			[indicator stopAnimation:nil];
			[executeButton setHidden:NO];
			
		});
	});
	
}

- (void)applyResult:(NSArray *)values
{
	NSString *value = [values componentsJoinedByString:@","];
	NSString *displayValue;
	
	[preview applyBoxShadowValue:value];
	
	if( outputCSSButton.state == NSOnState ){
		displayValue = [values componentsJoinedByString:@",\n\t"];
		resultTextView.string = [NSString stringWithFormat:@"i {\n\tdisplay:block;\n\twidth:0;\n\theight:0;\n\tbox-shadow:%@;\n}", displayValue];
	}else{
		displayValue = [values componentsJoinedByString:@",\n"];
		resultTextView.string = displayValue;
	}
	
	NSUInteger byteLength = [value lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
	byteTextField.stringValue = [NSString stringWithByteSize:byteLength];
	
}

- (NSArray *)createBoxShadowValues:(NSImage *)image size:(int)size blur:(int)blur
{
	
	int s = size;
	if( adjustPosButton.state == NSOffState && s > 1 ){
		s = size * 2;
	}
	
	NSMutableArray *tmp = [NSMutableArray array];
	if( shuffleButton.state == NSOnState ){
		
		NSMutableArray *colors = [NSMutableArray array];
		[image enumPixelColors:^(int x, int y, NSColor *color) {
			[colors addObject:color];
		}];
		
		colors = [[colors arrayWithShuffle] mutableCopy];
		for (int y = 0; y < image.size.height; y++) {
			for (int x = 0; x < image.size.width; x++) {
				int loc = image.size.width * y + x;
				
				NSColor *color = [colors objectAtIndex:loc];
				if( color.alphaComponent != 0 ){
					NSString *dotValue = [NSString stringWithFormat:@"%ipx %ipx %ipx %ipx %@", x * s, y * s, blur, size, [color cssColorValueRGBA]];
					[tmp addObject:dotValue];
				}
			}
		}
		
		
	}else{
		[image enumPixelColors:^(int x, int y, NSColor *color) {
			if( color.alphaComponent != 0 ){
				NSString *dotValue = [NSString stringWithFormat:@"%ipx %ipx %ipx %ipx %@", x * s, y * s, blur, size, [color cssColorValueRGBA]];
				[tmp addObject:dotValue];
			}
		}];
		
	}
	
	return tmp;
}

- (void)alertWithTitle:(NSString *)title message:(NSString *)message
{
	NSAlert *alert = [NSAlert alertWithMessageText:title 
									 defaultButton:@"OK" 
								   alternateButton:nil 
									   otherButton:nil 
						 informativeTextWithFormat:@"%@", message];
	[alert runModal];
}

@end
