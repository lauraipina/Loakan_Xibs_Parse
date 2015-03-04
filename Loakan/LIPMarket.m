#import "LIPMarket.h"
#import "LIPPhotoContainer.h"

@interface LIPMarket ()

// Private interface goes here.

@end

@implementation LIPMarket

// Custom logic goes here.
//En SQLite (Core Data) los datos se guardan en String pero es más facil tratarlos en NSURL, UIImage, etc... para eso personalizamos los GETTERS/SETTERS

//WEB
-(NSURL *)webURL {
    
    //Crear URL desde NSString
    return [NSURL URLWithString:self.web];
}

- (void)setWebURL:(NSURL *)webURL {
    
    NSError *error = nil;
    //Convertir URL en NSString
    self.web = [NSString stringWithContentsOfURL:webURL
                                        encoding:NSUTF8StringEncoding
                                           error:&error];
}

//FACEBOOK
-(NSURL *)facebookURL {
    
    //Crear URL desde NSString
    return [NSURL URLWithString:self.facebook];
}

- (void)setFacebookURL:(NSURL *)facebookURL {
    
    NSError *error = nil;
    //Convertir URL en NSString
    self.web = [NSString stringWithContentsOfURL:facebookURL
                                        encoding:NSUTF8StringEncoding
                                           error:&error];
}


//TWITTER
-(NSURL *)twitterURL {
    
    //Crear URL desde NSString
    return [NSURL URLWithString:self.twitter];
}

- (void)setTwitterURL:(NSURL *)twitterURL {
    
    NSError *error = nil;
    //Convertir URL en NSString
    self.web = [NSString stringWithContentsOfURL:twitterURL
                                        encoding:NSUTF8StringEncoding
                                           error:&error];
}


//INSTAGRAM
-(NSURL *)instagramURL {
    
    //Crear URL desde NSString
    return [NSURL URLWithString:self.instagram];
}

- (void)setInstagramURL:(NSURL *)instagramURL {
    
    NSError *error = nil;
    //Convertir URL en NSString
    self.web = [NSString stringWithContentsOfURL:instagramURL
                                        encoding:NSUTF8StringEncoding
                                           error:&error];
}


//INICIALIZADOR
+(instancetype) marketWithName:(NSString *) aName
                          info:(NSString *) anInfo
                     timetable:(NSString *) aTimetable
                           web:(NSString *) aUrl
                       twitter:(NSString *) aTwitter
                      facebook:(NSString *) aFacebook
                     instagram:(NSString *) aInstagram
                       context:(NSManagedObjectContext *)context{
    
    LIPMarket *market = [self insertInManagedObjectContext:context];
    
    market.name = aName;
    market.info = anInfo;
    market.timetable = aTimetable;
    market.web = aUrl;
    market.twitter = aTwitter;
    market.facebook = aFacebook;
    market.instagram = aInstagram;
    market.photo = [LIPPhotoContainer insertInManagedObjectContext:context];
    
    return market;
    
}

@end
