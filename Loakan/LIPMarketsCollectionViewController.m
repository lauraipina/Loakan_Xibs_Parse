//
//  LIPMarketsCollectionViewController.m
//  Loakan
//
//  Created by Laura Iglesias Piña on 18/2/15.
//  Copyright (c) 2015 lip. All rights reserved.
//
#import <Parse/Parse.h>
#import <Parse/PFQuery.h>
#import <ParseUI/PFCollectionViewCell.h>
#import <ParseUI/PFImageView.h>
#import "LIPMarketsCollectionViewController.h"
#import "LIPMarketViewController.h"
#import "LIPFormViewController.h"
#import "LIPMarketParse.h"
#import "GHContextMenuView.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import <MessageUI/MessageUI.h>
#import "LIPFavoritesViewController.h"

@interface LIPMarketsCollectionViewController () <UIGestureRecognizerDelegate, GHContextOverlayViewDataSource, GHContextOverlayViewDelegate, MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) LIPFavoritesViewController *favoritesVC;

@end



@implementation LIPMarketsCollectionViewController

#pragma mark - Init
-(instancetype)initWithClassName:(NSString *)className
                            city:(NSString *)aCity{
    
    if(self == [super initWithClassName:className]){
        _className = className;
        _city = aCity;
    }
    
    self.pullToRefreshEnabled = YES;
    self.paginationEnabled = NO;
    
    return self;
    
}


-(instancetype)initWithClassName:(NSString *)className
                  arrayFavorites:(NSArray *)myFavoriteMarkets{
    
    
    if(self == [super initWithClassName:className]){
        _className = className;
        _favoriteMarkets = myFavoriteMarkets;
    }
    
    self.pullToRefreshEnabled = YES;
    self.paginationEnabled = NO;
    
    return self;
}


#pragma mark - Cycle life

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Creo el layout del CollectionViewController
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 10.0f;
    //layout.minimumInteritemSpacing = 5.0f;
    layout.itemSize = CGSizeMake(145, 150);
    
    // Inicializamos el menu y le asignamos como delegado
    GHContextMenuView* overlay = [[GHContextMenuView alloc] init];
    overlay.dataSource = self;
    overlay.delegate = self;
    
    // Instanciamos el toque largo y lo añadimos al collectionView
    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:overlay action:@selector(longPressDetected:)];
    
    [self.collectionView addGestureRecognizer:longPressRecognizer];
    
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    CGSize result = [[UIScreen mainScreen] bounds].size;
    if(result.height == 480 || result.height == 568)
    {
        // iPhone 4 o 5
        layout.minimumLineSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    else if(result.height == 667)
    {
        // iPhone 6
        layout.minimumLineSpacing = 30;
        layout.sectionInset = UIEdgeInsetsMake(30, 30, 30, 30);
    }
    else if(result.height == 736)
    {
        // iPhone 6 plus
        layout.minimumLineSpacing = 40;
        layout.sectionInset = UIEdgeInsetsMake(40, 40, 40, 40);
    }
    
    layout.itemSize = CGSizeMake(145, 150);
}

-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];

    self.collectionView.backgroundColor = [UIColor colorWithRed:232/255.0
                                                          green:232/255.0
                                                           blue:232/255.0
                                                          alpha:1];
    
    if(self.isDisplayFavorite == YES){
        //Si venimos desde el Botón Favoritos de la tabla de ciudades
        NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
        if([language isEqualToString:@"es"]) {
            self.title = @"Mis Favoritos";
        } else{
            self.title = @"My Favorites";
        }
        
    }else{
        //Si venimos desde una ciudad de la tabla
        NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
        if([language isEqualToString:@"es"]) {
            self.title = @"Mercadillos";
        }else{
            self.title = @"Flea Markets";
        }
        
        // *** BOTON FORMULARIO
        // Crear un botón, con un target y un action en la parte DERECHA
        UIButton *formularioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [formularioBtn setFrame:CGRectMake(10.0f, 10.0f, 25.0f, 25.0f)];
        [formularioBtn addTarget:self action:@selector(addFleaMarket:) forControlEvents:UIControlEventTouchUpInside];
        [formularioBtn setImage:[UIImage imageNamed:@"AddDesactive"] forState:UIControlStateNormal];
        [formularioBtn setImage:[UIImage imageNamed:@"AddActive"] forState:UIControlStateHighlighted];
        UIBarButtonItem *favoriteItem = [[UIBarButtonItem alloc] initWithCustomView:formularioBtn];
        
        // lo añadimos a la barra de navegación
        self.navigationItem.rightBarButtonItem = favoriteItem;
        
    }
    
    // *** BOTON BACK
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"BackDesactive"];
    UIImage *backBtnImageHighlighted = [UIImage imageNamed:@"BackActive"];
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
    [backBtn setBackgroundImage:backBtnImageHighlighted forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(popBack:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 18, 20);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn] ;
    self.navigationItem.leftBarButtonItem = backButton;
}

#pragma mark - Parse Data

- (PFQuery *)queryForCollection {
    
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    if(self.isDisplayFavorite == YES){
        //Si venimos desde el Botón Favoritos de la tabla de ciudades
        //self.title = @"Mis Favoritos";
        [query whereKey:@"name" containedIn:self.favoriteMarkets];
        
    }else{
        //Si venimos desde una ciudad de la tabla
        //self.title = @"Mercadillos";
        [query whereKey:@"city" equalTo:self.city];
    }
    
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByAscending:@"name"];
    
    return query;
}

#pragma mark - PFCollectionView
- (PFCollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
                                  object:(PFObject *)object {
    PFCollectionViewCell *cell = [super collectionView:collectionView cellForItemAtIndexPath:indexPath object:object];
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:object[@"name"]
                                                                              attributes:@{
                                                                                           NSFontAttributeName:[UIFont fontWithName:@"CaviarDreams-Bold" size:14 ],
                                                                                           NSForegroundColorAttributeName:[UIColor colorWithRed:85.0/255.0 green:85.0/255.0 blue:85.0/255.0 alpha:1]
                                                                                           }];
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.attributedText = title;
    
    cell.imageView.file = object[@"photo"];
    // Si la imagen no se carga, cargar una por defecto
    if (cell.imageView.image == nil) {
        cell.imageView.image = [UIImage imageNamed:@"ImgNoDisponible"];
    }
    [cell.imageView loadInBackground];
    
    cell.contentView.layer.borderWidth = 5.0f;
    cell.contentView.layer.borderColor = [UIColor colorWithRed:133.0/255
                                                         green:197.0/255
                                                          blue:187.0/255
                                                         alpha:1].CGColor;
    cell.contentView.layer.backgroundColor = [UIColor colorWithRed:133.0/255
                                                             green:197.0/255
                                                              blue:187.0/255
                                                             alpha:1].CGColor;
    return cell;
}
#pragma mark <UICollectionViewDelegate>
//Pincho sobre una celda del CollectionView
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // Obtener el objeto
    PFObject *marketSelected = [self.objects objectAtIndex:indexPath.row];
    
    // Creamos el objeto MarketParse y lo enviamos al controlador LIPMarketViewController
    LIPMarketParse *market = [[LIPMarketParse alloc] init];
    market.name = [marketSelected objectForKey:@"name"];
    market.info = [marketSelected objectForKey:@"info"];
    market.imageFile = [marketSelected objectForKey:@"photo"];
    market.timeTable = [marketSelected objectForKey:@"timetable"];
    market.address = [marketSelected objectForKey:@"address"];
    market.location = [marketSelected objectForKey:@"location"];
    market.webURL = [NSURL URLWithString:[marketSelected objectForKey:@"web"]];
    market.facebookURL = [NSURL URLWithString:[marketSelected objectForKey:@"facebook"]];
    market.twitterURL = [NSURL URLWithString:[marketSelected objectForKey:@"twitter"]];
    market.instagramURL = [NSURL URLWithString:[marketSelected objectForKey:@"instagram"]];
    market.isFavorite = [marketSelected objectForKey:@"favorite"];
    
    // Crear el controlador
    LIPMarketViewController *controller = [[LIPMarketViewController alloc] initWithClassName:self.className market:market];
    if(self.isDisplayFavorite == YES){
        controller.isDisplayFavorite = YES;
        controller.favoriteMarkets = self.favoriteMarkets;
    }
    // Hacer un push
    [self.navigationController pushViewController:controller animated:YES];

}

#pragma mark - Actions
-(void)addFleaMarket:(id) sender{
    
    // Creamos una instancia de LIPFormViewController
    LIPFormViewController *formVC = [[LIPFormViewController alloc]init];
    
    // Hacemos un push
    [self.navigationController pushViewController:formVC animated:YES];
}

- (void) popBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - GHMenu methods

-(BOOL) shouldShowMenuAtPoint:(CGPoint)point
{
    NSIndexPath* indexPath = [self.collectionView indexPathForItemAtPoint:point];
    UICollectionViewCell* cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    
    return cell != nil;
}

- (NSInteger) numberOfMenuItems
{
    return 3;
}

-(UIImage*) imageForItemAtIndex:(NSInteger)index
{
    NSString* imageName = nil;
    switch (index) {
        case 0:
            imageName = @"facebook-white";
            break;
        case 1:
            imageName = @"twitter-white";
            break;
        case 2:
            imageName = @"Sobre";
            break;
        default:
            break;
    }
    return [UIImage imageNamed:imageName];
}

- (void) didSelectItemAtIndex:(NSInteger)selectedIndex forMenuAtPoint:(CGPoint)point
{
    // Obtener el objeto
    NSIndexPath* indexPath = [self.collectionView indexPathForItemAtPoint:point];
    
    PFObject *marketSelected = [self.objects objectAtIndex:indexPath.row];
    
    // Obtenemos el nombre del mercado seleccionado
    NSString *nameMarket = [marketSelected objectForKey:@"name"];
    NSString *textSocial;
    NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
    // Asignamos un texto para compartir
    if (nameMarket != nil) {
        
        if([language isEqualToString:@"es"]) {
            textSocial = [NSString stringWithFormat:@"Descubriendo %@ desde la app LOAKAN", [nameMarket capitalizedString]];
        } else {
            textSocial = [NSString stringWithFormat:@"Discovering %@ from the app Loakan", [nameMarket capitalizedString]];
        }
    } else {
        if([language isEqualToString:@"es"]) {
            textSocial = @"Descubriendo mercadillos y pop-up stores con la app LOAKAN";
        } else {
            textSocial = @"Discovering Flea Markets and Pop-up Stores with the app Loakan";
        }
    }
    
    // Obtenemos la url
    NSString *web = [marketSelected objectForKey:@"web"];
    NSURL *webURL = [NSURL URLWithString:web];
    
    // Obtenemos la imagen
    PFImageView *photo = [[PFImageView alloc] init];
    photo.image = [UIImage imageNamed:@"ImgNoDisponible"]; // placeholder image
    photo.file = (PFFile *)[marketSelected objectForKey:@"photo"]; // remote image
    
    [photo loadInBackground];
    
    
    switch (selectedIndex) {
        case 0:
        {
            // FACEBOOK
            // Comprobamos que tengamos configurada una cuenta en el sistema
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
                
                // Obtenemos el view controller para el controlador de twitter.
                SLComposeViewController *facebook = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                
                //[facebook setInitialText:@"Probando Post Facebook"];
                [facebook setInitialText:textSocial];
                
                // En el caso que queramos adjuntar una imagen podemos hacerlo con función addImage.
                //[facebook addImage:[UIImage imageNamed:@"img_flea"]];
                [facebook addImage:photo.image];
                
                // Si queremos asignar una url lo hacaemos con esta función. En iOS 7 se generará una vista previa de la página web si no se le asigna una imagen al tweet.
                //[facebook addURL:[NSURL URLWithString:@"http://google.es"]];
                if (webURL != nil) {
                    [facebook addURL:webURL];
                }else{
                    #warning añadir enlace descarga AppStore cuando esté publicada
                }
                
                // Aqui asignamos un bloque que nos va a decir el estado de envió del tweet.
                facebook.completionHandler = ^(SLComposeViewControllerResult result) {
                    
                    switch (result) {
                        case SLComposeViewControllerResultCancelled: // El post fue cancelado.
                            NSLog(@"Post cancelado :(");
                            break;
                            
                        case SLComposeViewControllerResultDone:
                            // El post se envió correctamente.
                            NSLog(@"Post enviado :)");
                            break;
                    }
                };
                
                // Presentamos el controlador.
                [self presentViewController:facebook
                                   animated:YES
                                 completion:NULL];
            }else{
                //Hay problemas de conexion, muestro mensaje temporal
                [self mensajeError];
            }
        }
            break;
            
        case 1:
            // TWITTER
            // Comprobamos que tengamos configurada una cuenta en el sistema
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
                
                // Obtenemos el view controller para el controlador de twitter.
                SLComposeViewController *twitter = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                
                // Asignamos un texto para compartir
                //[twitter setInitialText:@"Aprendiendo a utilizar las API's de Twitter en #iOS"];
                [twitter setInitialText:textSocial];
                
                // En el caso que queramos adjuntar una imagen podemos hacerlo con función addImage.
                //[twitter addImage:[UIImage imageNamed:@"img_flea"]];
                [twitter addImage:photo.image];
                
                // Si queremos asignar una url lo hacaemos con esta función. En iOS 7 se generará una vista previa de la página web si no se le asigna una imagen al tweet.
                //[twitter addURL:[NSURL URLWithString:@"http://google.es"]];
                if (webURL != nil) {
                    [twitter addURL:webURL];
                }
                // Aqui asignamos un bloque que nos va a decir el estado de envió del tweet.
                twitter.completionHandler = ^(SLComposeViewControllerResult result) {
                    
                    switch (result) {
                        case SLComposeViewControllerResultCancelled:// El tweet fue cancelado.
                            NSLog(@"Tweet cancelado :(");
                            break;
                            
                        case SLComposeViewControllerResultDone:// El tweet se envió correctamente.
                            NSLog(@"Tweet enviado :)");
                            break;
                    }
                };
                
                // Presentamos el controlador.
                [self presentViewController:twitter
                                   animated:YES
                                 completion:NULL];
            }else{
                //Hay problemas de conexion, muestro mensaje temporal
                [self mensajeError];
            }            break;
            
        case 2:
            //EMAIL
        {
            // Email Subject
            NSString *emailTitle = nameMarket;
            NSString *messageBody;
            // Email Content
            if([language isEqualToString:@"es"]) {
                messageBody = @"He encontrado este mercadillo en la aplicación LOAKAN y me apetece ir. ¿Vamos juntos?";
            } else {
                messageBody = @"I found this market with the app Loakan and I want to go. Are we together?";
            }
            // To address
            //NSArray *toRecipents = [NSArray arrayWithObject:@"support@support.com"];
            
            MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
            mc.mailComposeDelegate = self;
            [mc setSubject:emailTitle];
            [mc setMessageBody:messageBody isHTML:NO];
            //[mc setToRecipients:toRecipents];
            
            // Present mail view controller on screen
            [self presentViewController:mc animated:YES completion:NULL];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - MFMailComposeViewController
//Este metodo cerrará el email cuando se envie o se cancele
- (void)mailComposeController:(MFMailComposeViewController*)emailcontroller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"La operación ha sido cancelada");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"El correo ha sido guardado en la carpeta borradores");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Correo puesto en la cola de envío satisfactoriamente");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"No se ha podido enviar o guardar el correo debido a un error");
            break;
        default:
            break;
    }
    
    // cerramos la ventana modal de envío de correo
    [self dismissViewControllerAnimated:YES completion: nil];
}

-(void)mensajeError{
    //Si no hay conexion con redes sociales, muestro un mensaje temporal
    CGPoint location;
    UILabel *lblComingSoon = [[UILabel alloc] init];
    
    NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
    if([language isEqualToString:@"es"]) {
        lblComingSoon.text = @"  Problemas de conexión...";
    } else {
        lblComingSoon.text = @"  Problems connecting...";
    }
    lblComingSoon.backgroundColor = [UIColor colorWithRed:250.0/255.0
                                                    green:250.0/255.0
                                                     blue:250.0/255.0
                                                    alpha:1];
    lblComingSoon.textColor = [UIColor grayColor];
    [lblComingSoon setFrame:CGRectMake(0,50,0,40)];
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
        location.x = 60;
    }
    else if(result.height == 667 || result.height == 736)
    {
        // iPhone 6 o 6 plus
        location.x = 100;
    }
    //location.x = 100;
    location.y = 340;
    lblComingSoon.center = location;
    
    // Ocultamos la etiqueta con una animacion
    [lblComingSoon setHidden:FALSE];
    
    [UIView animateWithDuration:4.0 animations:^{
        lblComingSoon.alpha = 0.0;
    }];
    
    CGSize fontSize = [lblComingSoon.text sizeWithAttributes:
                       @{NSFontAttributeName:
                             [UIFont fontWithName:@"Caviar Dreams" size:14]}];
    
    // Adjustar a la etiqueta la nueva altura
    CGRect newFrame = lblComingSoon.frame;
    newFrame.size.width = fontSize.width+50;
    lblComingSoon.frame = newFrame;
    
    // Añadimos la etiqueta a la vista
    [self.view addSubview:lblComingSoon];
    
}

- (void)favoriteWasCreated:(NSNotification *)note {
    [self loadObjects];
}


@end
