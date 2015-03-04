#import "LIPLocation.h"

@interface LIPLocation ()

// Private interface goes here.

@end

@implementation LIPLocation

// Custom logic goes here.
+(instancetype) locationWithAddress:(NSString *) anAddress
                           latitude:(double) aLatitude
                          longitude:(double) aLongitude
                            context:(NSManagedObjectContext *)context{
    
    LIPLocation *location = [self insertInManagedObjectContext:context];
    
    location.address = anAddress;
    location.latitudeValue = aLatitude;
    location.longitudeValue = aLongitude;
    
    return location;
}

@end
