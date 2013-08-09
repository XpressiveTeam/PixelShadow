#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface Preview : WebView

- (void)applyBoxShadowValue:(NSString *)value;
- (void)setDocumentSize:(NSSize)size;

@end
