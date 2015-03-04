//
//  LIPLocationViewController.h
//  Loakan
//
//  Created by Laura Iglesias Piña on 22/2/15.
//  Copyright (c) 2015 lip. All rights reserved.
//

@import UIKit;
@import MapKit;
@class LIPLocation;
@class LIPMarket;

@interface LIPLocationViewController : UIViewController

@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) LIPMarket *model;

-(id)initWithModel:(LIPMarket *)aModel latitude:(double) aLatitude longitude:(double)aLongitude;

- (IBAction)standardMap:(id)sender;
- (IBAction)satelliteMap:(id)sender;
- (IBAction)hybridMap:(id)sender;



@end
