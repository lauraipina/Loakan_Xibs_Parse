//
//  LIPMarketViewController.m
//  Loakan
//
//  Created by Laura Iglesias Piña on 18/2/15.
//  Copyright (c) 2015 lip. All rights reserved.
//

#import "LIPMarketViewController.h"
#import "LIPMarket.h"
#import "LIPLocation.h"
#import "LIPPhotoContainer.h"
#import "LIPWebViewController.h"
#import "LIPLocationViewController.h"

@interface LIPMarketViewController ()

@end

@implementation LIPMarketViewController


#pragma mark - Init
-(id) initWithModel:(id) model{
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = model;
        self.title = self.model.name;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
    
    //volcamos los valores del modelo a la pantalla
    if(self.model.photo.image == nil){
        self.imgMarket.image = [UIImage imageNamed:@"ImgNoDisponible"];
    } else{
        self.imgMarket.image = self.model.photo.image;    
    }
    self.addressMarket.text = self.model.address.address;
    self.infoMarket.text = self.model.info;
    self.timetableMarket.text = self.model.timetable;
    
    //ocultamos los botones de redes sociales que no tengan url
    if(self.model.webURL == nil){
        self.webMarket.hidden = YES;
    }
    if(self.model.facebookURL == nil){
        self.facebookMarket.hidden = YES;
    }
    if(self.model.twitterURL == nil){
        self.twitterMarket.hidden = YES;
    }
    if(self.model.instagramURL == nil){
        self.instagramMarket.hidden = YES;
    }
    
    
    if(self.model.favoriteValue == NO){
        
        UIImage *buttonImage = [UIImage imageNamed:@"IconFavoriteDesactive"];
        [self.iconFavorite setBackgroundImage:buttonImage forState:UIControlStateNormal];
        
    } else {
        
        UIImage *buttonImage = [UIImage imageNamed:@"IconFavoriteActive"];
        [self.iconFavorite setBackgroundImage:buttonImage forState:UIControlStateNormal];
    }

    
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:250.0/255
                                                                          green:250.0/255
                                                                           blue:250.0/255
                                                                          alpha:1]];
    self.navigationItem.backBarButtonItem.title = @"";
    
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)favoriteBtn:(id)sender {
    
    if(self.model.favoriteValue == NO){
        
        // Si está desactivado y lo pulsamos, queremos que se guarde como favorito
        // Cambiar el icono a ACTIVADO
        UIImage *buttonImage = [UIImage imageNamed:@"IconFavoriteActive"];
        [self.iconFavorite setBackgroundImage:buttonImage forState:UIControlStateNormal];
        
        //Cambiamos el valor boolean
        self.model.favoriteValue = YES;
        
        //Tenemos autoguardado en AppDelegate --> por eso no guardamos
        
    } else {
        
        // Si está activado y lo pulsamos, queremos que se desactive
        // Cambiar el icono a DESACTIVADO
        UIImage *buttonImage = [UIImage imageNamed:@"IconFavoriteDesactive"];
        [self.iconFavorite setBackgroundImage:buttonImage forState:UIControlStateNormal];
        
        
        //Cambiamos el valor boolean
        self.model.favoriteValue = NO;
        
        //Tenemos autoguardado en AppDelegate --> por eso no guardamos
    }
    
    
}

- (IBAction)displayWeb:(id)sender {
    
    //Creamos una instancia de WebViewController
    LIPWebViewController *webVC = [[LIPWebViewController alloc]
                                   initWithUrl:self.model.webURL];
    
    //Hacemos un push (añadimos un MVC al NavigationController)
    //No sabemos si estamos en un NavigationController, pero si no estamos,
    //el mensaje "pushViewController" devolverá un nil y no pasará nada
    [self.navigationController pushViewController:webVC animated:YES];
}

- (IBAction)displayFacebook:(id)sender {
    //Creamos una instancia de WebViewController
    LIPWebViewController *faceVC = [[LIPWebViewController alloc]
                                   initWithUrl:self.model.facebookURL];
    
    //Hacemos un push (añadimos un MVC al NavigationController)
    [self.navigationController pushViewController:faceVC animated:YES];

}

- (IBAction)displayTwitter:(id)sender {
    
    //Creamos una instancia de WebViewController
    LIPWebViewController *twVC = [[LIPWebViewController alloc]
                                   initWithUrl:self.model.twitterURL];
    
    //Hacemos un push (añadimos un MVC al NavigationController)
    [self.navigationController pushViewController:twVC animated:YES];

}

- (IBAction)displayInstagram:(id)sender {
    
    //Creamos una instancia de WebViewController
    LIPWebViewController *instaVC = [[LIPWebViewController alloc]
                                         initWithUrl:self.model.instagramURL];
    
    //Hacemos un push (añadimos un MVC al NavigationController)
    [self.navigationController pushViewController:instaVC animated:YES];
 

}

- (IBAction)locationBtn:(id)sender {
    
     //Creamos una instancia de LocationViewController (latitudeValue, longitudValue)
     LIPLocationViewController *locationVC = [[LIPLocationViewController alloc]
                                              initWithModel:self.model
                                                latitude:self.model.address.latitudeValue
                                              longitude:self.model.address.longitudeValue];
     
     //Hacemos un push (añadimos un MVC al NavigationController)
     [self.navigationController pushViewController:locationVC animated:YES];
    
}

- (void) popBack:(id)sender
{
    // do your custom handler code here
    [self.navigationController popViewControllerAnimated:YES];
}

@end
