#import "NSWindow+UI.h"

@implementation NSWindow (UI)

- (void)lockUI
{
	for (id view in [self.contentView subviews]) {
		if( [view isKindOfClass:[NSControl class]] ){
			[view setEnabled:NO];
		}
	}
}

- (void)unlockUI
{
	for (id view in [self.contentView subviews]) {
		if( [view isKindOfClass:[NSControl class]] ){
			[view setEnabled:YES];
		}
	}
}

@end
