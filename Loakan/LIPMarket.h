#import "_LIPMarket.h"

@interface LIPMarket : _LIPMarket {}

// Custom logic goes here.
@property (nonatomic, strong) NSURL *webURL;
@property (nonatomic, strong) NSURL *facebookURL;
@property (nonatomic, strong) NSURL *twitterURL;
@property (nonatomic, strong) NSURL *instagramURL;

+(instancetype) marketWithName:(NSString *) aName
                          info:(NSString *) anInfo
                     timetable:(NSString *) aTimetable
                           web:(NSString *) aUrl
                       twitter:(NSString *) aTwitter
                      facebook:(NSString *) aFacebook
                     instagram:(NSString *) aInstagram
                       context:(NSManagedObjectContext *)context;

@end
