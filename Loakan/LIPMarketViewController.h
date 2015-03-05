//
//  LIPMarketViewController.h
//  Loakan
//
//  Created by Laura Iglesias Piña on 18/2/15.
//  Copyright (c) 2015 lip. All rights reserved.
//

@import UIKit;
@import MapKit;

@class LIPMarket;
#import "LIPDetailViewController.h"

@interface LIPMarketViewController : UIViewController <LIPDetailViewController>

@property (strong, nonatomic) LIPMarket *model;

@property (weak, nonatomic) IBOutlet UIImageView *imgMarket;
@property (weak, nonatomic) IBOutlet UITextView *infoMarket;
@property (weak, nonatomic) IBOutlet UILabel *timetableMarket;
@property (weak, nonatomic) IBOutlet UILabel *addressMarket;
@property (weak, nonatomic) IBOutlet UIButton *webMarket;
@property (weak, nonatomic) IBOutlet UIButton *facebookMarket;
@property (weak, nonatomic) IBOutlet UIButton *twitterMarket;
@property (weak, nonatomic) IBOutlet UIButton *instagramMarket;
@property (weak, nonatomic) IBOutlet UIButton *iconFavorite;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)favoriteBtn:(id)sender;

- (IBAction)displayWeb:(id)sender;
- (IBAction)displayFacebook:(id)sender;
- (IBAction)displayTwitter:(id)sender;
- (IBAction)displayInstagram:(id)sender;

- (IBAction)locationBtn:(id)sender;


@end
