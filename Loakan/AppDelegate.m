//
//  AppDelegate.m
//  Loakan
//
//  Created by Laura Iglesias Piña on 4/3/15.
//  Copyright (c) 2015 lip. All rights reserved.
//

#import "AppDelegate.h"

@import Parse;

#import "LIPCitiesTableViewController.h"
#import "LIPTutorialViewController.h"

#define REVMOB_ID @"551eb5df5c0247ed0743f8fe"

#define APPLICATION_ID 	@"7QqqkqS9Y4UCQW6xuHNXxbDSV7V4F1V7Lvfz7aTj"
#define CLIENT_KEY 		@"9NVLTMN6rxYxsRDjEvJye1op0nm5mNY7dHOUvFUa"

@interface AppDelegate ()

@end



@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //Antes de nada, cambiamos el aspecto
    [self customizeAppearance];
    
    // *** REVMOB
    [RevMobAds startSessionWithAppID:REVMOB_ID andDelegate:self];
    
    // *** PARSE
    // Registra la aplicación con nuestra app registrada en Parse
    [Parse setApplicationId:APPLICATION_ID clientKey:CLIENT_KEY];
    // Envía una notificación a Parse para indicar que hemos abierto la aplicación en el simulador.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    LIPCitiesTableViewController *citiesTVC = [[LIPCitiesTableViewController alloc] init];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:citiesTVC];
    
    
    PFObject *miMercado = [PFObject objectWithClassName:@"Mercados"];
    PFObject *myMarket = [PFObject objectWithClassName:@"Markets"];
    
    NSString *name = @"Mercado de Motores";
    //NSString *web = @"http://www.coolcraftmarket.com";
    NSString *face = @"https://www.facebook.com/mercadodemotores";
    NSString *tw = @"https://twitter.com/mercadodmotores";
    //NSString *insta = @"https://instagram.com/corner_label/";
    NSString *dire = @"Museo del Ferrocarril, Paseo de las Delicias, 61, Madrid";

    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:40.398725 longitude:-3.691637];
    NSString *city = @"Madrid";
    
    
    
    [miMercado setObject:name forKey:@"name"];
    [miMercado setObject:@"La estación más bonita de Madrid llena de trenes, muebles de segunda mano, ropa añeja de grandes firmas, diseño de ahora, comida, música y risas." forKey:@"info"];
    [miMercado setObject:@"Variable. Consulta web." forKey:@"timetable"];
    //[miMercado setObject:web forKey:@"web"];
    [miMercado setObject:face forKey:@"facebook"];
    [miMercado setObject:tw forKey:@"twitter"];
    //[miMercado setObject:insta forKey:@"instagram"];
    [miMercado setObject:dire forKey:@"address"];
    [miMercado setObject:city forKey:@"city"];
    [miMercado setObject:geoPoint forKey:@"location"];

    
     [myMarket setObject:name forKey:@"name"];
     [myMarket setObject:@"The most beautiful station in Madrid, full of trains, second hand furniture, vintage clothes of large firms, design, food, music and laughter." forKey:@"info"];
     [myMarket setObject:@"Variable. Check web." forKey:@"timetable"];
     //[myMarket setObject:web forKey:@"web"];
     [myMarket setObject:face forKey:@"facebook"];
     [myMarket setObject:tw forKey:@"twitter"];
     //[myMarket setObject:insta forKey:@"instagram"];
     [myMarket setObject:dire forKey:@"address"];
     [myMarket setObject:city forKey:@"city"];
     [myMarket setObject:geoPoint forKey:@"location"];
    
    
    
    
     //[miMercado save];
     //[myMarket save];
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - REVMOB
-(void)revmobSessionIsStarted {
    NSLog(@"[RevMob Sample App] Session is started.");
}

- (void)revmobSessionNotStartedWithError:(NSError *)error {
    NSLog(@"[RevMob Sample App] Session failed to start: %@", error);
}

- (void)revmobAdDidFailWithError:(NSError *)error {
}


#pragma mark - Utils

-(void)customizeAppearance{
    
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:133.0/255
                                                                  green:197.0/255
                                                                   blue:187.0/255
                                                                  alpha:1]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName:[UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1],
                                                           NSFontAttributeName:
                                                               [UIFont fontWithName:@"CaviarDreams-Bold" size:18 ]}];    
}

@end
