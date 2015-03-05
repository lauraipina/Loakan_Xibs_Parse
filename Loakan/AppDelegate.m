//
//  AppDelegate.m
//  Loakan
//
//  Created by Laura Iglesias Piña on 4/3/15.
//  Copyright (c) 2015 lip. All rights reserved.
//

#import "AppDelegate.h"

#import "LIPCoreDataStack.h"
#import "LIPCity.h"
#import "LIPCitiesTableViewController.h"
#import "LIPMarket.h"
#import "LIPLocation.h"
#import "LIPPhotoContainer.h"
#import "LIPTutorialViewController.h"

#define AUTO_SAVE YES
#define AUTO_SAVE_DELAY 30



@interface AppDelegate ()

// Creamos la propiedad que va a guardar nuestro Stack dentro de la aplicación.
@property (strong, nonatomic) LIPCoreDataStack *coreDataStack;

@end



@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //Antes de nada, cambiamos el aspecto
    [self customizeAppearance];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    // Creamos la instancia LIPCoreDataStack
    // A partir de esto ya podemos empezar a crear objectos LIPCity, LIPMarket...
    self.coreDataStack = [LIPCoreDataStack coreDataStackWithModelName:@"Model"];
    
    
    // Creamos lista ciudades con sus mercadillos
    [self createListCities];
    
    //Creamos el conjunto de datos
    NSFetchRequest *r = [NSFetchRequest fetchRequestWithEntityName:[LIPCity entityName]];
    //no mas de 15 registros en la tabla
    r.fetchBatchSize = 15;
    //Ordenamos la busqueda
    r.sortDescriptors = @[[NSSortDescriptor
                           sortDescriptorWithKey:LIPCityAttributes.name
                           ascending:YES
                           selector:@selector(caseInsensitiveCompare:)]];
    
    //Creamos el FetchedResultsController
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc]
                                      initWithFetchRequest:r
                                      managedObjectContext:self.coreDataStack.context
                                      sectionNameKeyPath:nil
                                      cacheName:nil];
    
    //Creamos el controlador
    LIPCitiesTableViewController *citiesVC = [[LIPCitiesTableViewController alloc]
                                              initWithFetchedResultsController:fc
                                              style:UITableViewStylePlain];
    
    // Lo metemos en un NavigationController
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:citiesVC];
    
    // Lo asignamos al rootViewController
    self.window.rootViewController = nav;
    
    //Arrancamos el autosave, una vez hecho el NSFetchRequest
    [self autosave];

    
    self.window.backgroundColor = [UIColor whiteColor];
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

#pragma mark - Utils

- (void)createListCities {
    
    [self.coreDataStack zapAllData];
    
    
    // Ciudades
    // *** MADRID
    LIPCity *madrid = [LIPCity cityWithName:@"Madrid"
                                    context:self.coreDataStack.context];
    LIPMarket *rastro = [LIPMarket marketWithName:@"El Rastro"
                                             info:@"El Rastro de Madrid es un mercado al aire libre, originalmente de objetos de segunda mano, que se monta todas las mañanas de domingos y festivos en un barrio castizo del centro histórico de la capital de España."
                                        timetable:@"Domingos y festivos de 9:00 a 15:00"
                                              web:@"http://www.elrastro.org"
                                          twitter:nil
                                         facebook:nil
                                        instagram:nil
                                          context:self.coreDataStack.context];
    
    LIPLocation *locRastro = [LIPLocation locationWithAddress:@"Calle Ribera de Curtidores, s/n, 28005 Madrid"
                                                     latitude:40.409109
                                                    longitude:-3.707162
                                                      context:self.coreDataStack.context];
    
    UIImage *rastroImage = [UIImage imageNamed:@"img_rastro"];
    LIPPhotoContainer *photoRastro = [LIPPhotoContainer photoWithImage:rastroImage
                                                               context:self.coreDataStack.context];
    
    rastro.city = madrid;
    locRastro.market = rastro;
    photoRastro.markets = rastro;
    
    LIPMarket *nomada = [LIPMarket marketWithName:@"Nomada Market"
                                             info:@"Convertido en fenómeno social y cultural, Nómada Market es más que una feria, ha crecido e incorporado actividades paralelas como talleres, cine, exposiciones, espacios de lectura y gastronomía."
                                        timetable:@"Consultar fechas en la web."
                                              web:@"http://www.nomadamarket.com"
                                          twitter:@"https://twitter.com/nomadamarket"
                                         facebook:@"https://www.facebook.com/marketnomada"
                                        instagram:@"http://instagram.com/nomada_market"
                                          context:self.coreDataStack.context];
    LIPLocation *locNomada = [LIPLocation locationWithAddress:@"Estación de Chamartín, Ático, 28036 Madrid"
                                                     latitude:40.471240
                                                    longitude:-3.682930
                                                      context:self.coreDataStack.context];
    
    UIImage *nomadaImage = [UIImage imageNamed:@"img_nomada"];
    LIPPhotoContainer *photoNomada = [LIPPhotoContainer photoWithImage:nomadaImage
                                                               context:self.coreDataStack.context];
    
    nomada.city = madrid;
    locNomada.market = nomada;
    photoNomada.markets = nomada;
    
    
    LIPMarket *vaqueria = [LIPMarket marketWithName:@"La Vaquería"
                                               info:@"Es un espacio de concepto novedoso que pretende convertirse en el hogar permanentemente efímero de las tan de moda ‘pop up stores‘, un lugar que semanalmente irá mutando."
                                          timetable:@"Consultar fechas en la web."
                                                web:@"http://pop-up.lavaqueria.biz"
                                            twitter:@"https://twitter.com/VAQUERIA16"
                                           facebook:@"https://www.facebook.com/popup.vaqueria"
                                          instagram:@"https://instagram.com/vaqueria16/"
                                            context:self.coreDataStack.context];
    LIPLocation *locVaqueria = [LIPLocation locationWithAddress:@"Calle San Joaquin 16 28004 Madrid"
                                                       latitude:40.424427
                                                      longitude:-3.701779
                                                        context:self.coreDataStack.context];
    
    UIImage *vaqueriaImage = [UIImage imageNamed:@"img_vaqueria"];
    LIPPhotoContainer *photoVaqueria = [LIPPhotoContainer photoWithImage:vaqueriaImage
                                                                 context:self.coreDataStack.context];
    
    vaqueria.city = madrid;
    locVaqueria.market = vaqueria;
    photoVaqueria.markets = vaqueria;
    
    
    // *** BARCELONA
    LIPCity *barna = [LIPCity cityWithName:@"Barcelona"
                                   context:self.coreDataStack.context];
    LIPMarket *flea = [LIPMarket marketWithName:@"Flea Market"
                                           info:@"El Flea Market Barcelona es un mercadillo mensual donde la gente vende y intercambia productos de segunda mano, tales como ropa, accesorios, libros y música en buen estado a precios razonables."
                                      timetable:@"2º domingo de cada mes de 11h a 19h"
                                            web:@"http://www.fleamarketbcn.com/?lang=es"
                                        twitter:@"https://twitter.com/fleamarketbcn"
                                       facebook:@"https://www.facebook.com/fleamarketbcn"
                                      instagram:@"http://instagram.com/fleamarketbcn"
                                        context:self.coreDataStack.context];
    
    LIPLocation *locFlea = [LIPLocation locationWithAddress:@"Plaça de Blanquerna, 08001 Barcelona"
                                                   latitude:41.375505
                                                  longitude:2.174860
                                                    context:self.coreDataStack.context];
    
    UIImage *fleaImage = [UIImage imageNamed:@"img_flea.x"];
    LIPPhotoContainer *photoFlea = [LIPPhotoContainer photoWithImage:fleaImage
                                                             context:self.coreDataStack.context];
    
    flea.city = barna;
    locFlea.market = flea;
    photoFlea.markets = flea;
    
    // *** IBIZA
    LIPCity *ibiza = [LIPCity cityWithName:@"Ibiza"
                                   context:self.coreDataStack.context];
    
    // *** BERLIN
    //LIPCity *berlin = [LIPCity cityWithName:@"Berlin" context:self.coreDataStack.context];
    
    
    // *** LONDRES
    LIPCity *londres = [LIPCity cityWithName:@"Londres"
                                     context:self.coreDataStack.context];
    
    // *** PARIS
    LIPCity *paris = [LIPCity cityWithName:@"Paris"
                                   context:self.coreDataStack.context];
    
    // *** NUEVA YORK
    LIPCity *ny = [LIPCity cityWithName:@"Nueva York"
                                context:self.coreDataStack.context];
    
    // *** AMSTERDAM
    //LIPCity *amsterdam = [LIPCity cityWithName:@"Amsterdam" context:self.coreDataStack.context];
    
    // *** BUENOS AIRES
    //LIPCity *baires = [LIPCity cityWithName:@"Buenos Aires" context:self.coreDataStack.context];
    
    // *** BALI
    //LIPCity *bali = [LIPCity cityWithName:@"Bali" context:self.coreDataStack.context];
    
    // *** HONG KONG
    //LIPCity *hongKong = [LIPCity cityWithName:@"Hong Kong" context:self.coreDataStack.context];
    
    // *** SINGAPUR
    //LIPCity *singapur = [LIPCity cityWithName:@"Singapur" context:self.coreDataStack.context];
    
    
    //Se guarda en la BD SIN ORDEN
    [self.coreDataStack saveWithErrorBlock:^(NSError *error) {
        NSLog(@"Error al guardar en AppDelegate%@", error);
    }];
}



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
-(void)autosave{
    
    if (AUTO_SAVE) {
        //NSLog(@"Autoguardando....");
        
        [self.coreDataStack saveWithErrorBlock:^(NSError *error) {
            NSLog(@"Error al auto-guardar %s \n\n %@", __func__, error);
        }];
        
        [self performSelector:@selector(autosave)
                   withObject:nil afterDelay:AUTO_SAVE_DELAY];
    }
}


@end
