#import "Preview.h"

@implementation Preview

- (void)awakeFromNib
{
	NSString *indexPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
	[self setMainFrameURL:indexPath];
	
	[self setDrawsBackground:NO];
}

- (void)applyBoxShadowValue:(NSString *)value
{
	DOMCSSStyleDeclaration *pixelStyleDeclaration = [[self pixelSelectorRule] style];
	
	[pixelStyleDeclaration setProperty:@"box-shadow" value:value priority:@""];
}

- (void)setDocumentSize:(NSSize)size
{
	DOMCSSStyleDeclaration *bodyStyleDeclaration = [[self bodySelectorRule] style];
	
	[bodyStyleDeclaration setProperty:@"width" value:[NSString stringWithFormat:@"%gpx", size.width] priority:@""];
	[bodyStyleDeclaration setProperty:@"height" value:[NSString stringWithFormat:@"%gpx", size.height] priority:@""];
	
	NSScrollView *mainScrollView = [self mainScrollView];
    [mainScrollView setVerticalScrollElasticity:NSScrollElasticityNone]; 
    [mainScrollView setHorizontalScrollElasticity:NSScrollElasticityNone];

}

#pragma mark - DOM

- (DOMHTMLDocument *)doc
{
	return (DOMHTMLDocument *)self.mainFrame.DOMDocument;
}

- (DOMCSSStyleSheet *)indexStyleSheet
{
	DOMHTMLDocument *doc = [self doc];
	return (DOMCSSStyleSheet *)[doc.styleSheets item:0];
}

- (DOMCSSStyleRule *)bodySelectorRule
{
	return [self findSelectorRuleByName:@"body"];
}

- (DOMCSSStyleRule *)pixelSelectorRule
{
	return [self findSelectorRuleByName:@"i"];
}

- (DOMCSSStyleRule *)findSelectorRuleByName:(NSString *)selectorName
{
	DOMCSSStyleSheet *styleSheet = [self indexStyleSheet];
	DOMCSSRuleList *rules = [styleSheet rules];
	
	for (int i = 0; i < rules.length; i++) {
		DOMCSSRule *rule = [rules item:i];
		if( rule.type == DOM_STYLE_RULE ){
			NSString *selector = [(DOMCSSStyleRule *)rule selectorText];
			if( [selector isEqualToString:selectorName] ){
				return (DOMCSSStyleRule *)rule;
			}
		}
	}
	
	return nil;

}

- (NSScrollView *)mainScrollView {
    return [[[[self mainFrame] frameView] documentView] enclosingScrollView];
}


@end
