#import "_LIPCity.h"

@interface LIPCity : _LIPCity {}

// Custom logic goes here.
+(instancetype)cityWithName:(NSString *)name
                    context:(NSManagedObjectContext*)context;

@end
