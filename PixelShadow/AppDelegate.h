#import <Cocoa/Cocoa.h>
#import "Preview.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>{
	IBOutlet NSScrollView *imageScroller;
	IBOutlet NSImageView *imageWell;
	IBOutlet Preview *preview;
	IBOutlet NSTextField *sizeTextField;
	IBOutlet NSTextField *blurTextField;
	IBOutlet NSTextField *byteTextField;
	IBOutlet NSTextView *resultTextView;
	IBOutlet NSTextField *sizeLabel;
	IBOutlet NSButton *adjustPosButton;
	IBOutlet NSButton *shuffleButton;
	IBOutlet NSButton *outputCSSButton;
	IBOutlet NSButton *executeButton;
	IBOutlet NSProgressIndicator *indicator;
	
	NSImage *loadedImage;
	NSArray *lastResultValues;
}

@property (assign) IBOutlet NSWindow *window;

@end
