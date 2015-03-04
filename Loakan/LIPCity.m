#import "LIPCity.h"

@interface LIPCity ()

// Private interface goes here.

@end

@implementation LIPCity

// Custom logic goes here.
+(instancetype)cityWithName:(NSString *)name
                    context:(NSManagedObjectContext*)context{
    
    // Asignamos valores a las propiedades
    LIPCity *city = [self insertInManagedObjectContext:context];
    
    city.name = name;
    
    return  city;
    
}

@end
