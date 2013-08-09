#import "NSArray+Shuffle.h"

@implementation NSArray (Shuffle)

- (NSArray *)arrayWithShuffle
{
	NSMutableArray *shuffled = [self mutableCopy];
    NSUInteger count = [self count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger nElements = count - i;
        NSInteger n = (arc4random() % nElements) + i;
        [shuffled exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
	
	return shuffled;
}

@end
