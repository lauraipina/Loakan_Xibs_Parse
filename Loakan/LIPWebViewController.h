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

-(id) initWithUrl: (NSURL *) aTypeWeb;

@end
