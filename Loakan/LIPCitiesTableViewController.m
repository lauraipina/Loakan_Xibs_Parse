//
//  LIPCitiesTableViewController.m
//  Loakan
//
//  Created by Laura Iglesias Piña on 17/2/15.
//  Copyright (c) 2015 lip. All rights reserved.
//

#import "LIPCitiesTableViewController.h"
#import "LIPCitiesTableViewCell.h"
#import "LIPMarketsCollectionViewController.h"
#import "LIPInfoViewController.h"
#import "LIPTutorialViewController.h"
#import "LIPFavoritesViewController.h"

@interface LIPCitiesTableViewController ()

@end

@implementation LIPCitiesTableViewController

//Customizamos la tabla obtenida del backend en PARSE
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        // Custom the table
        
        // The className to query on
        NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
        if([language isEqualToString:@"es"]) {
            self.parseClassName = @"Ciudades";
        } else {
            self.parseClassName = @"Cities";
        }
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"name";
        
        // The title for this table in the Navigation Controller.
        self.title = @"Ciudades";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        //self.objectsPerPage = 10;
    }
    return self;
}

#pragma mark - View lifecycle
- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.title = @"LOAKAN";

    // Registramos el nib de la celda personalizada
    UINib *nib = [UINib nibWithNibName:@"LIPCitiesTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:[LIPCitiesTableViewCell cellId]];
    
    
    //Elimina las celdas que no se usan y ponemos un color al fondo
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor colorWithRed:241/255.0
                                                     green:241/255.0
                                                      blue:241/255.0
                                                     alpha:1];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //Vamos a cambiar el color de la barra del NavigationController
    
    // *** BOTON FAVORITOS
    // Crear un botón, con un target y un action en la parte DERECHA
    UIButton *favoriteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [favoriteBtn setFrame:CGRectMake(10.0f, 10.0f, 30.0f, 30.0f)];
    [favoriteBtn addTarget:self action:@selector(addFavorite:) forControlEvents:UIControlEventTouchUpInside];
    [favoriteBtn setImage:[UIImage imageNamed:@"IconFavoriteDesactive"] forState:UIControlStateNormal];
    [favoriteBtn setImage:[UIImage imageNamed:@"IconFavoriteActive"] forState:UIControlStateHighlighted];
    UIBarButtonItem *favoriteItem = [[UIBarButtonItem alloc] initWithCustomView:favoriteBtn];
    
    // lo añadimos a la barra de navegación
    self.navigationItem.rightBarButtonItem = favoriteItem;
    
    
    // *** BOTON INFO
    // Crear un botón, con un target y un action en la parte IZQ
    UIButton *infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [infoBtn setFrame:CGRectMake(10.0f, 10.0f, 26.0f, 26.0f)];
    [infoBtn addTarget:self action:@selector(infoMore) forControlEvents:UIControlEventTouchUpInside];
    [infoBtn setImage:[UIImage imageNamed:@"IconInfoDesactive"] forState:UIControlStateNormal];
    [infoBtn setImage:[UIImage imageNamed:@"IconInfoActive"] forState:UIControlStateHighlighted];
    UIBarButtonItem *infoItem = [[UIBarButtonItem alloc] initWithCustomView:infoBtn];
    
    // lo añadimos a la barra de navegación
    self.navigationItem.leftBarButtonItem = infoItem;

    // *** TUTORIAL
    // Se controla si es la primera vez que se entra a la aplicacion
    // y mostramos el TUTORIAL
    // Instanciamos la clase NSUserDefaults
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    BOOL hasSeenTutorial = [preferences boolForKey:@"hasSeenTutorial"];
    
    if(!hasSeenTutorial){
        
        // Es la primera vez
        // Guardamos la preferencia de que ya no es la primera vez
        [preferences setBool:TRUE forKey:@"hasSeenTutorial"];
        
        // Sincronizamos la caché
        [preferences synchronize];
        
        // Instanciamos el tutorial
        LIPTutorialViewController *tutorialVC = [[LIPTutorialViewController alloc] init];
        
        tutorialVC.modalPresentationStyle = UIModalPresentationFullScreen;
        
        // Le ponemos un retardo de 0.5seg para evitar este error:
        // Unbalanced calls to begin/end appearance transitions for <UINavigationController: 0xa98e050>
        double delayInSeconds = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds *   NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self.parentViewController presentViewController:tutorialVC animated:NO completion:nil];
        });
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Parse
// Este método se llama cada vez que los objetos se cargan desde Parse a través de la PFQuery
- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    //NSLog(@"error: %@", [error localizedDescription]);
}

// Este método se llama antes de que un PFQuery se dispara para conseguir más objetos
- (void)objectsWillLoad {
    [super objectsWillLoad];
}


// Override para personalizar qué tipo de consulta a realizar en la clase.
// Por defecto, todos los objetos de la Query serán ordenados por createdAt descendente.
- (PFQuery *)queryForTable {
    
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    // Si no hay objetos cargados en la memoria, miramos a la caché de primera para llenar la tabla
    // Y, posteriormente, hacer una consulta en la red.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByAscending:@"name"];
    
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    
    
    // Creo una celda personalizada
    LIPCitiesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[LIPCitiesTableViewCell cellId] forIndexPath:indexPath];
    
    // La configuro (sincronizo modelo -> vista)
    cell.cityLabel.text = [object objectForKey:@"name"];
    cell.cityLabel.font = [UIFont fontWithName:@"CaviarDreams-Bold" size:18];
    
    
    
    
    
    
    
    
    
    
    
    
    cell.numMarketLabel.text = [object objectForKey:@"markets"];
    cell.numMarketLabel.font = [UIFont fontWithName:@"Caviar Dreams" size:18];
    
    // La devuelvo
    return cell;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [LIPCitiesTableViewCell height];
}

#pragma mark - TableView Delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];

    PFObject *citySelected = [self.objects objectAtIndex:indexPath.row];
    
    NSString *city = [citySelected objectForKey:@"name"];
    
    // Averiguar cual es la ciudad
    if([city isEqualToString:@"Ibiza"] ||
       [city isEqualToString:@"Berlin"] ||
       [city isEqualToString:@"Amsterdam"] ||
       [city isEqualToString:@"Paris"] ||
       [city isEqualToString:@"Nueva York"] ||
       [city isEqualToString:@"Buenos Aires"])
    {
        
        //Si no hay mercados, muestro un mensaje "Proximamente" temporal
        CGPoint location;
        UILabel *lblComingSoon = [[UILabel alloc] init];
        
        lblComingSoon.text = @"   Próximamente";
        lblComingSoon.backgroundColor = [UIColor colorWithRed:250.0/255.0
                                                        green:250.0/255.0
                                                         blue:250.0/255.0
                                                        alpha:1];
        lblComingSoon.textColor = [UIColor grayColor];
        [lblComingSoon setFrame:CGRectMake(40,60,40,40)];
        lblComingSoon.layer.cornerRadius = 10;
        lblComingSoon.layer.borderWidth = 3.0;
        lblComingSoon.layer.borderColor = [UIColor colorWithRed:133.0/255.0
                                                          green:197.0/255.0
                                                           blue:187.0/255.0
                                                          alpha:1].CGColor;
        lblComingSoon.clipsToBounds = YES;
        
        lblComingSoon.userInteractionEnabled=YES;
        
        [lblComingSoon setHidden:TRUE];
        [lblComingSoon setAlpha:1.0];
        
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480 || result.height == 568)
        {
            // iPhone 4 o 5
            location.x = 110;
        }
        else if(result.height == 667 || result.height == 736)
        {
            // iPhone 6 o 6 plus
            location.x = 150;
        }
        //location.x = 110;
        location.y = 200;
        lblComingSoon.center = location;
        
        // Ocultamos la etiqueta con una animacion
        [lblComingSoon setHidden:FALSE];
        
        [UIView animateWithDuration:4.0 animations:^{
            lblComingSoon.alpha = 0.0;
        }];
        
        CGSize fontSize = [lblComingSoon.text sizeWithAttributes:
                           @{NSFontAttributeName:
                                 [UIFont fontWithName:@"Caviar Dreams" size:18]}];
        
        // Adjustar a la etiqueta la nueva altura
        CGRect newFrame = lblComingSoon.frame;
        newFrame.size.width = fontSize.width + 12;
        lblComingSoon.frame = newFrame;

        // Añadimos la etiqueta a la vista
        [self.view addSubview:lblComingSoon];
        
    }else{
        
        // Creo la selección de datos de esa ciudad
        PFQuery *query;
        
        NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
        if([language isEqualToString:@"es"]) {
            query = [PFQuery queryWithClassName:@"Mercados"];
        } else {
            query = [PFQuery queryWithClassName:@"Markets"];
        }
        
        [query whereKey:@"city" equalTo:city];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            if (error) {
                
                NSLog(@"Error: %@ %@", objects, error);
                
            } else {
                
                __block NSString *nameTable;
                NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
                if([language isEqualToString:@"es"]) {
                    nameTable = @"Mercados";
                } else {
                    nameTable = @"Markets";
                }

                //NSLog(@"Successfully retrieved %lu markets.",(unsigned long)objects.count);
                
                // Creo una instancia de CollectionViewController
                LIPMarketsCollectionViewController *controller = [[LIPMarketsCollectionViewController alloc] initWithClassName:nameTable city:city];
                
                // Lo pusheo
                [self.navigationController pushViewController:controller animated:YES];
                
            }
        }];
    }
}
#pragma mark - Actions
-(void)addFavorite:(id) sender{
    
    // Obtenemos los mercadillos favoritos guardados en NSUserDefault
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *favoriteMarkets = [defaults objectForKey:@"favorites"];
    
    NSString *nameTable;
    NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
    if([language isEqualToString:@"es"]) {
        nameTable = @"Mercados";
    } else {
        nameTable = @"Markets";
    }

    // Creo una instancia de CollectionViewController con el Array obtenido
    LIPMarketsCollectionViewController *controller = [[LIPMarketsCollectionViewController alloc] initWithClassName:nameTable arrayFavorites:favoriteMarkets];
    
    controller.isDisplayFavorite = YES;
    
    // Si hay mercados favoritos, pusheo y creo collectionview
    // Lo pusheo
    [self.navigationController pushViewController:controller animated:YES];
    
}

-(void)infoMore{
    
    // Creo una instancia de InfoViewController
    LIPInfoViewController *info = [[LIPInfoViewController alloc]init];
    // Lo pusheo
    [self.navigationController pushViewController:info
                                         animated:YES];
    
}

@end
