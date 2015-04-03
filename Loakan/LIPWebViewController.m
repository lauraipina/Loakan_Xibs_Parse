//
//  LIPWebViewController.m
//  Loakan
//
//  Created by Laura Iglesias Piña on 20/2/15.
//  Copyright (c) 2015 lip. All rights reserved.
//

#import "LIPWebViewController.h"

@interface LIPWebViewController ()

@end


@implementation LIPWebViewController

-(id) initWithUrl: (NSURL *) aTypeWeb
       nameMarket:(NSString *)aNameMarket{
    
    if([super initWithNibName:nil bundle:nil]){
        
        _type = aTypeWeb;
        _nameMarket = aNameMarket;
        
        //Propiedad heredada, por eso usamos el set
        self.title = aNameMarket;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Se crea Banner en RevMob
    [[RevMobAds session] showBanner];
}

//Sirve para mantener sincronizados modelo y vista
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //Carga la web
    [self displayURL: self.type];
        
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate
//Feedback del usuario a través de un spinning
//¿Cuando se sabe cuando ocultarlo y pararlo? se lo comunica el delegado UIWebViewDelegate
-(void) webViewDidFinishLoad:(UIWebView *)webView{
    
    [self.activityView stopAnimating];
    [self.activityView setHidden:YES];
}


#pragma mark - Utils
//Metodo para cargar la web
-(void) displayURL:(NSURL *) aURL{
    
    //Se debe indicar al browser que es el delegado
    self.browser.delegate = self;
    
    //Empieza el spinning
    self.activityView.hidden = NO;
    [self.activityView startAnimating];
    
    //Metodo que hace la petición web y la carga
    [self.browser loadRequest:[NSURLRequest requestWithURL:aURL]];
    
}

- (void) popBack:(id)sender
{
    // Se elimina Banner en RevMob
    [[RevMobAds session] hideBanner];
    
    // do your custom handler code here
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Methods to test RevMob Ads

- (void)fillUserInfo
{
    RevMobAds *revmob = [RevMobAds session];
    
    revmob.userGender = RevMobUserGenderFemale;
    revmob.userAgeRangeMin = 16;
    revmob.userAgeRangeMax = 60;
    revmob.userBirthday = [NSDate dateWithTimeIntervalSince1970:0];
    revmob.userPage = @"twitter.com/revmob";
    revmob.userInterests = @[@"mobile", @"iPhone", @"apps", @"girl", @"market", @"shop", @"diy", @"flea"];
    
}

#pragma mark - RevMobAdsDelegate methods

- (void)revmobSessionIsStarted {
    NSLog(@"[RevMob Sample App] Session started again.");
}

- (void)revmobSessionNotStarted:(NSError *)error {
    NSLog(@"[RevMob Sample App] Session not started again: %@", error);
}

- (void)revmobAdDidReceive {
    NSLog(@"[RevMob Sample App] Ad loaded.");
}

- (void)revmobAdDidFailWithError:(NSError *)error {
    NSLog(@"[RevMob Sample App] Ad failed: %@", error);
}

- (void)revmobAdDisplayed {
    NSLog(@"[RevMob Sample App] Ad displayed.");
}

- (void)revmobUserClosedTheAd {
    NSLog(@"[RevMob Sample App] User clicked in the close button.");
}

- (void)revmobUserClickedInTheAd {
    NSLog(@"[RevMob Sample App] User clicked in the Ad.");
}

- (void)installDidReceive {
    NSLog(@"[RevMob Sample App] Install did receive.");
}

- (void)installDidFail {
    NSLog(@"[RevMob Sample App] Install did fail.");
}

@end
