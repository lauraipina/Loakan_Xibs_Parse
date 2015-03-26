//
//  LIPWebViewController.h
//  Loakan
//
//  Created by Laura Iglesias Piña on 20/2/15.
//  Copyright (c) 2015 lip. All rights reserved.
//

@import UIKit;

@interface LIPWebViewController : UIViewController <UIWebViewDelegate>


@property (weak, nonatomic) IBOutlet UIWebView *browser;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

@property (strong, nonatomic) NSURL *type;
@property (strong, nonatomic) NSString *nameMarket;

-(id) initWithUrl: (NSURL *) aTypeWeb nameMarket:(NSString *) aNameMarket;

@end
