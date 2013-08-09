#import "NSString+Format.h"

@implementation NSString (Format)

+(NSString *)stringWithByteSize:(long)size
{
    NSString *sizeTypeW = @"bytes";
	
	double result = size;
	if(size < 1){
		result = 0;
	}else{
		
		if (result > 1024){
			//Kilobytes
			result = result / 1024;
			
			sizeTypeW = @"KB";
		}
		
		if (result > 1024){
			//Megabytes
			result = result / 1024;
			
			sizeTypeW = @"MB";
		}
		
		if (result > 1024){
			//Gigabytes
			result = result / 1024;
			
			sizeTypeW = @"GB";
		}
		
	}
	
	return [NSString stringWithFormat:@"%.2f %@", result, sizeTypeW];
}

@end
