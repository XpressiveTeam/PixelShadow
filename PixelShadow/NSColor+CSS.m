#import "NSColor+CSS.h"

@implementation NSColor (CSS)

- (NSString *)cssColorValueRGBA
{
    
    double redFloatValue, greenFloatValue, blueFloatValue, alphaFloatValue;
    int redIntValue, greenIntValue, blueIntValue;
    NSColor *convertedColor = [self colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
	
    
    if(convertedColor) {
        [convertedColor getRed:&redFloatValue green:&greenFloatValue blue:&blueFloatValue alpha:&alphaFloatValue];
        
		redIntValue = redFloatValue*255.99999f;
		greenIntValue = greenFloatValue*255.99999f;
		blueIntValue = blueFloatValue*255.99999f;
		
		if( alphaFloatValue == 1 ){
			return [NSString stringWithFormat:@"#%02x%02x%02x", redIntValue, greenIntValue, blueIntValue];
		}else{
        	return [NSString stringWithFormat:@"rgba(%i,%i,%i,%.2f)", redIntValue, greenIntValue, blueIntValue, alphaFloatValue];
		}
    }
    
    return nil;
}

@end
