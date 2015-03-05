//
//  LIPMarketsCollectionViewController.m
//  Loakan
//
//  Created by Laura Iglesias Piña on 18/2/15.
//  Copyright (c) 2015 lip. All rights reserved.
//

#import "LIPMarketsCollectionViewController.h"
#import "LIPMarketCollectionViewCell.h"
#import "LIPMarketViewController.h"
#import "LIPMarket.h"
#import "LIPLocation.h"
#import "LIPPhotoContainer.h"
#import "LIPFormViewController.h"
#import "GHContextMenuView.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import <MessageUI/MessageUI.h>


static NSString *cellId = @"MarketCellId";


@interface LIPMarketsCollectionViewController () <UIGestureRecognizerDelegate, GHContextOverlayViewDataSource, GHContextOverlayViewDelegate, MFMailComposeViewControllerDelegate>

@end



@implementation LIPMarketsCollectionViewController



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  View Lifecicle
-(void) viewDidLoad{
    
    // Inicializamos el menu y le asignamos como delegado
    GHContextMenuView* overlay = [[GHContextMenuView alloc] init];
    overlay.dataSource = self;
    overlay.delegate = self;
    
    // Instanciamos el toque largo y lo añadimos al collectionView
    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:overlay action:@selector(longPressDetected:)];
    
    [self.collectionView addGestureRecognizer:longPressRecognizer];
    
}

-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self registerCell];
    
    self.detailViewControllerClassName = NSStringFromClass([LIPMarketViewController class]);
    
    self.collectionView.backgroundColor = [UIColor colorWithRed:232/255.0
                    green:232/255.0
                     blue:232/255.0
                    alpha:1];
    
    if(self.isDisplayFavorite == YES){
        //Si venimos desde el Botón Favoritos de la tabla de ciudades
        self.title = @"Mis Favoritos";
        
    }else{
        //Si venimos desde una ciudad de la tabla
        self.title = @"Mercadillos";
        
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

#pragma mark - cell registration
-(void) registerCell{
    
    UINib *nib = [UINib nibWithNibName:@"LIPMarketCollectionViewCell"
                                bundle:nil];
    
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:cellId];
}

#pragma mark - Data Source
-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // Obtener el objeto
    LIPMarket *market = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Obtener la celda
    LIPMarketCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    // Configurar la celda
    //[cell observeNote:note];
    cell.backgroundColor = [UIColor colorWithRed:133.0/255
                                           green:197.0/255
                                            blue:187.0/255
                                           alpha:1];
    cell.titleLabel.text = market.name;
    
    UIImage *img;
    if (market.photo.image == nil) {
        img = [UIImage imageNamed:@"ImgNoDisponible"];
    }else{
        img = market.photo.image;
    }
    cell.imgLabel.image = img;
   
    // Devolverla
    return cell;
}

#pragma mark <UICollectionViewDelegate>

//Pincho sobre una celda del CollectionView
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // Obtener el objeto
    LIPMarket *market = [self.fetchedResultsController objectAtIndexPath:indexPath];

    // Crear el controlador
    LIPMarketViewController *marketVC = [[LIPMarketViewController alloc] initWithModel:market];
    
    // Hacer un push
    [self.navigationController pushViewController:marketVC animated:YES];
    
}
/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

#pragma mark - Actions
-(void)addFleaMarket:(id) sender{
    
    // Creamos una instancia de LIPFormViewController
    LIPFormViewController *formVC = [[LIPFormViewController alloc]init];
    
    // Hacemos un push
    [self.navigationController pushViewController:formVC animated:YES];
}

- (void) popBack:(id)sender
{
    // do your custom handler code here
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
    
    

    NSIndexPath* indexPath = [self.collectionView indexPathForItemAtPoint:point];
    
    // Obtener el objeto
    LIPMarket *market = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Asignamos un texto para compartir
    NSString *nameMarket = market.name;
    if (nameMarket != nil) {
        nameMarket = [NSString stringWithFormat:@"Descubriendo %@ desde la app LOAKAN", [nameMarket capitalizedString]];
    } else {
        nameMarket = @"Descubriendo mercadillos con la app LOAKAN";
    }
    
    
    // Obtenemos la imagen
    UIImage *img;
    if (market.photo.image == nil) {
        img = [UIImage imageNamed:@"ImgNoDisponible"];
    }else{
        img = market.photo.image;
    }
    
    switch (selectedIndex) {
        case 0:
            //***FACEBOOK
            // Comprobamos que tengamos configurada una cuenta en el sistema
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
                
                // Obtenemos el view controller para el controlador de twitter.
                SLComposeViewController *facebook = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];

                //[facebook setInitialText:@"Probando Post Facebook"];
                [facebook setInitialText:nameMarket];
                
                // En el caso que queramos adjuntar una imagen podemos hacerlo con función addImage.
                //[facebook addImage:[UIImage imageNamed:@"img_flea"]];
                [facebook addImage:img];
                
                // Si queremos asignar una url lo hacaemos con esta función. En iOS 7 se generará una vista previa de la página web si no se le asigna una imagen al tweet.
                //[facebook addURL:[NSURL URLWithString:@"http://google.es"]];
                if (market.webURL != nil) {
                    [facebook addURL:market.webURL];
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
                        {
                            
                            //Lanzar aquí una alerta avisando que el textfield no tiene texto
                            UIAlertController *alert =   [UIAlertController
                                                          alertControllerWithTitle:@"Información"
                                                          message:@"Su post se ha mandado correctamente."
                                                          preferredStyle:UIAlertControllerStyleAlert];
                            
                            UIAlertAction *ok = [UIAlertAction
                                                 actionWithTitle:@"OK"
                                                 style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction * action)
                                                 {
                                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                                     
                                                 }];
                            
                            [alert addAction:ok];
                            
                            [self presentViewController:alert animated:YES completion:nil];
                        }

                            break;
                    }
                };
                
                // Presentamos el controlador.
                [self presentViewController:facebook
                                   animated:YES
                                 completion:NULL];
            }
            
            break;
            
        case 1:
            //***TWITTER
            // Comprobamos que tengamos configurada una cuenta en el sistema
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
                
                // Obtenemos el view controller para el controlador de twitter.
                SLComposeViewController *twitter = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                
                // Asignamos un texto para compartir
                //[twitter setInitialText:@"Aprendiendo a utilizar las API's de Twitter en #iOS"];
                [twitter setInitialText:nameMarket];
                
                // En el caso que queramos adjuntar una imagen podemos hacerlo con función addImage.
                //[twitter addImage:[UIImage imageNamed:@"img_flea"]];
                [twitter addImage:img];
                
                // Si queremos asignar una url lo hacaemos con esta función. En iOS 7 se generará una vista previa de la página web si no se le asigna una imagen al tweet.
                //[twitter addURL:[NSURL URLWithString:@"http://google.es"]];
                if (market.webURL != nil) {
                    [twitter addURL:market.webURL];
                }
                // Aqui asignamos un bloque que nos va a decir el estado de envió del tweet.
                twitter.completionHandler = ^(SLComposeViewControllerResult result) {
                    
                    switch (result) {
                        case SLComposeViewControllerResultCancelled:
                            // El tweet fue cancelado.
                            NSLog(@"Tweet cancelado :(");
                            break;
                            
                        case SLComposeViewControllerResultDone:
                            // El tweet se envió correctamente.
                            NSLog(@"Tweet enviado :)");
                        {
                            
                            //Lanzar aquí una alerta avisando que el textfield no tiene texto
                            UIAlertController *alert =   [UIAlertController
                                                          alertControllerWithTitle:@"Información"
                                                          message:@"Su tweet se ha mandado correctamente."
                                                          preferredStyle:UIAlertControllerStyleAlert];
                            
                            UIAlertAction *ok = [UIAlertAction
                                                 actionWithTitle:@"OK"
                                                 style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction * action)
                                                 {
                                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                                     
                                                 }];
                            
                            [alert addAction:ok];
                            
                            [self presentViewController:alert animated:YES completion:nil];
                        }

                            break;
                    }
                };
                
                // Presentamos el controlador.
                [self presentViewController:twitter
                                   animated:YES
                                 completion:NULL];
            }
            
            break;
            
        case 2:
            //EMAIL
            {
                // Email Subject
                NSString *emailTitle = market.name;
                // Email Content
                NSString *messageBody = @"He encontrado este mercadillo en la aplicación LOAKAN y me apetece ir. Vamos juntos?";
                // To address
                //NSArray *toRecipents = [NSArray arrayWithObject:@"support@appcoda.com"];
                
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
        {
            
            //Lanzar aquí una alerta avisando que el textfield no tiene texto
            UIAlertController *alert =   [UIAlertController
                                          alertControllerWithTitle:@"Información"
                                          message:@"Su email se ha guardado correctamente."
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            
            [alert addAction:ok];
            
            [self presentViewController:alert animated:YES completion:nil];
        }

            NSLog(@"El correo ha sido guardado en la carpeta borradores");
            break;
        case MFMailComposeResultSent:
        {
            
            //Lanzar aquí una alerta avisando que el textfield no tiene texto
            UIAlertController *alert =   [UIAlertController
                                          alertControllerWithTitle:@"Información"
                                          message:@"Su email se ha mandado correctamente."
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            
            [alert addAction:ok];
            
            [self presentViewController:alert animated:YES completion:nil];
        }

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

@end
