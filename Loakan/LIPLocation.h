#import "_LIPLocation.h"

@interface LIPLocation : _LIPLocation {}

// Custom logic goes here.
+(instancetype) locationWithAddress:(NSString *) aAddress
                           latitude:(double) aLatitude
                          longitude:(double) aLongitude
                            context:(NSManagedObjectContext *)context;

@end
