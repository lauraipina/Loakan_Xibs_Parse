//
//  LIPFormViewController.h
//  Loakan
//
//  Created by Laura Iglesias Piña on 23/2/15.
//  Copyright (c) 2015 lip. All rights reserved.
//
@import UIKit;
@import MessageUI;

@interface LIPFormViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITextField *nameMarketTextView;

@property (weak, nonatomic) IBOutlet UITextField *cityMarketTextView;

@property (weak, nonatomic) IBOutlet UITextField *webTextView;

- (IBAction)sendEmail:(id)sender;

- (IBAction)cerrarTeclado:(id)sender;


@end
