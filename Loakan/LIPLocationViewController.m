//
//  LIPLocationViewController.m
//  Loakan
//
//  Created by Laura Iglesias Piña on 22/2/15.
//  Copyright (c) 2015 lip. All rights reserved.
//

#import "LIPLocationViewController.h"
#import "LIPCustomAnnotation.h"
#import "LIPMarketParse.h"

@interface LIPLocationViewController ()<MKMapViewDelegate>
@end

@implementation LIPLocationViewController

-(id)initWithModel:(LIPMarketParse *)aModel latitude:(double) aLatitude longitude:(double)aLongitude{
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        _modelParse = aModel;
        _latitude = aLatitude;
        _longitude = aLongitude;
        NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
        if([language isEqualToString:@"es"]) {
            self.title = @"Localización";
        } else {
            self.title = @"Location";
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Ahora nuestro ViewController ya es delegado de nuestro mapa
    [self.mapView setDelegate:self];
    
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
    
}


-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    // Creamos la coordenada perteneciente al mercadillo.
    CLLocationCoordinate2D marketLocation;
    marketLocation.latitude = self.latitude;
    marketLocation.longitude= self.longitude;
    
    // Esto situará el centro del mapa en el mercadillo con la distancia de región que establezcamos.
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(marketLocation, 500, 500);
    
    [self.mapView setRegion:region animated:YES];
    
    NSString *name = self.modelParse.name;
    NSString *address = self.modelParse.address;
   
    LIPCustomAnnotation *annotation = [[LIPCustomAnnotation alloc]initWithTitle: name
                                                                 subtitle: address
                                                            andCoordinate:marketLocation];
    [self.mapView addAnnotation:annotation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)standardMap:(id)sender {
    self.mapView.mapType = MKMapTypeStandard;
}

- (IBAction)satelliteMap:(id)sender {
    self.mapView.mapType = MKMapTypeSatellite;
}

- (IBAction)hybridMap:(id)sender {
    self.mapView.mapType = MKMapTypeHybrid;
}


#pragma mark - MKAnnotationView
//Sobreescribimos el método para poder modificar elementos de la anotación como la imagen.
- (MKAnnotationView *) mapView: (MKMapView *) mapView viewForAnnotation: (id) annotation {
    
    LIPCustomAnnotation *anotacion1 = (LIPCustomAnnotation *)annotation;
    
    // Comprobamos si se trata de la anotación correspondiente al usuario.
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    
    MKAnnotationView *aView = [[MKAnnotationView alloc] initWithAnnotation:anotacion1 reuseIdentifier:@"pinView"];
    
    
    //Creo el nombre de la imagen
    NSString *icoName = @"MarcadorDesactive";
    
    // Configuramos la vista del mapa
    aView.canShowCallout = YES;
    aView.enabled = YES;
    aView.centerOffset = CGPointMake(0, -20);

    aView.draggable = YES;
    
    UIImage *imagen = [UIImage imageNamed:icoName];
    aView.image = imagen;
    
    
    // Establecemos el tamaño óptimo para el Pin
    CGRect frame = aView.frame;
    frame.size.width = 25;
    frame.size.height = 34;
    aView.frame = frame;
    
    return aView;    
}

- (void) popBack:(id)sender
{
    // do your custom handler code here
    [self.navigationController popViewControllerAnimated:YES];
}

@end
