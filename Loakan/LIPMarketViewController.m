//
//  LIPMarketViewController.m
//  Loakan
//
//  Created by Laura Iglesias Piña on 18/2/15.
//  Copyright (c) 2015 lip. All rights reserved.
//

#import "LIPMarketViewController.h"
#import "LIPMarketParse.h"
#import "LIPWebViewController.h"
#import "LIPLocationViewController.h"
#import "LIPFavoritesViewController.h"
#import "LIPMarketsCollectionViewController.h"

@interface LIPMarketViewController ()

@property (assign, nonatomic, getter=isFavorite) BOOL favorite;
@property (strong, nonatomic) LIPFavoritesViewController *favoritesVC;
@property (strong, nonatomic) NSUserDefaults *defaults;

@end


@implementation LIPMarketViewController


#pragma mark - Init
- (instancetype)initWithClassName:(NSString *)className
                           market:(LIPMarketParse *)aMarket{
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        _marketParse = aMarket;
        _className = className;
        self.title = self.marketParse.name;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //*** BOTON BACK
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"BackDesactive"];
    UIImage *backBtnImageHighlighted = [UIImage imageNamed:@"BackActive"];
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
    [backBtn setBackgroundImage:backBtnImageHighlighted forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(popBack:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 18, 20);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn] ;
    self.navigationItem.leftBarButtonItem = backButton;
    
    self.scrollView.contentSize = CGSizeMake(320, 520);
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    PFImageView *photo = [[PFImageView alloc] init];
    photo.image = [UIImage imageNamed:@"ImgNoDisponible"]; // placeholder image
    photo.file = self.marketParse.imageFile; // remote image
    self.imgMarket.image = photo.image;
    
    self.infoMarket.text = self.marketParse.info;
    self.addressMarket.text = self.marketParse.address;
    self.timetableMarket.text = self.marketParse.timeTable;
    NSURL *web = self.marketParse.webURL;
    NSURL *facebook = self.marketParse.facebookURL;
    NSURL *twitter = self.marketParse.twitterURL;
    NSURL *instagram = self.marketParse.instagramURL;
    //ocultamos los botones de redes sociales que no tengan url
    if(web == nil){
        self.webMarket.hidden = YES;
    }
    if(facebook == nil){
        self.facebookMarket.hidden = YES;
    }
    if(twitter == nil){
        self.twitterMarket.hidden = YES;
    }
    if(instagram == nil){
        self.instagramMarket.hidden = YES;
    }
    
    
    // Todos los mercados están como FALSE en la BD PARSE
    // habrá que comprobar si se ha marcado para este usuario como FAVORITO
    // en NSUserDefaults
    self.favoritesVC = [[LIPFavoritesViewController alloc] init];
    self.favorite = [self.favoritesVC isFavoriteMarket:self.marketParse.name];
    [self updateFavoriteButtonState];

    
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:250.0/255
                                                                          green:250.0/255
                                                                           blue:250.0/255
                                                                          alpha:1]];
    self.navigationItem.backBarButtonItem.title = @"";
    
}


-(void) dealloc {
    // Se da de baja de su propia notificacion
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}



- (IBAction)favoriteBtn:(id)sender {
    
    NSString *nameMarket = self.marketParse.name;
    self.favorite = ![self isFavorite];

    if (self.favorite) {
        [self.favoritesVC addFavoriteMarket:nameMarket];
    } else {
        [self.favoritesVC removeFavoriteMarket:nameMarket];
    }

    // Modificar el boton Favorito
    [self updateFavoriteButtonState];

}

- (IBAction)displayWeb:(id)sender {
    
    //Creamos una instancia de WebViewController
    LIPWebViewController *webVC = [[LIPWebViewController alloc]
                                   initWithUrl:self.marketParse.webURL
                                    nameMarket:self.marketParse.name];
    
    //Hacemos un push (añadimos un MVC al NavigationController)
    //No sabemos si estamos en un NavigationController, pero si no estamos,
    //el mensaje "pushViewController" devolverá un nil y no pasará nada
    [self.navigationController pushViewController:webVC animated:YES];
}

- (IBAction)displayFacebook:(id)sender {
    //Creamos una instancia de WebViewController
    LIPWebViewController *faceVC = [[LIPWebViewController alloc]
                                   initWithUrl:self.marketParse.facebookURL
                                    nameMarket:self.marketParse.name];
    
    //Hacemos un push (añadimos un MVC al NavigationController)
    [self.navigationController pushViewController:faceVC animated:YES];

}

- (IBAction)displayTwitter:(id)sender {
    
    //Creamos una instancia de WebViewController
    LIPWebViewController *twVC = [[LIPWebViewController alloc]
                                   initWithUrl:self.marketParse.twitterURL
                                    nameMarket:self.marketParse.name];
    
    //Hacemos un push (añadimos un MVC al NavigationController)
    [self.navigationController pushViewController:twVC animated:YES];

}

- (IBAction)displayInstagram:(id)sender {
    
    //Creamos una instancia de WebViewController
    LIPWebViewController *instaVC = [[LIPWebViewController alloc]
                                         initWithUrl:self.marketParse.instagramURL
                                          nameMarket:self.marketParse.name];
    
    //Hacemos un push (añadimos un MVC al NavigationController)
    [self.navigationController pushViewController:instaVC animated:YES];
 

}

- (IBAction)locationBtn:(id)sender {
    
     //Creamos una instancia de LocationViewController (latitudeValue, longitudValue)
     LIPLocationViewController *locationVC = [[LIPLocationViewController alloc]
                                              initWithModel:self.marketParse
                                                latitude:self.marketParse.location.latitude
                                              longitude:self.marketParse.location.longitude];
     
     //Hacemos un push (añadimos un MVC al NavigationController)
     [self.navigationController pushViewController:locationVC animated:YES];
    
}

- (void) popBack:(id)sender
{
    
    // Creamos Notificación para que resto Controladores (que estén suscritos)
    // se enteren del cambio
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    // Se envia Notificación
    [center postNotificationName:NOTIF_MARKET_FAVORITE object:self];
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)updateFavoriteButtonState {
    
    if (self.favorite) {
        // Cambiar el icono a ACTIVADO
        UIImage *buttonImage = [UIImage imageNamed:@"IconFavoriteActive"];
        [self.iconFavorite setBackgroundImage:buttonImage forState:UIControlStateNormal];
        
    } else {
        // Cambiar el icono a DESACTIVADO
        UIImage *buttonImage = [UIImage imageNamed:@"IconFavoriteDesactive"];
        [self.iconFavorite setBackgroundImage:buttonImage forState:UIControlStateNormal];
    }
    
}


@end
