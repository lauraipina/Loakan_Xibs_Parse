//
//  LIPInfoViewController.m
//  Loakan
//
//  Created by Laura Iglesias Piña on 25/2/15.
//  Copyright (c) 2015 lip. All rights reserved.
//

#import "LIPInfoViewController.h"
#import "LIPTutorialViewController.h"

@interface LIPInfoViewController ()

@end

@implementation LIPInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Información Legal";
    
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:250.0/255
                                                                          green:250.0/255
                                                                           blue:250.0/255
                                                                          alpha:1]];
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
    
    
    // *** BOTON TUTORIAL
    // Crear un botón, con un target y un action en la parte DERECHA
    UIButton *tutorialBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tutorialBtn setFrame:CGRectMake(10.0f, 10.0f, 30.0f, 30.0f)];
    [tutorialBtn addTarget:self action:@selector(displayTutorial) forControlEvents:UIControlEventTouchUpInside];
    [tutorialBtn setImage:[UIImage imageNamed:@"IconTutorialDesactive"] forState:UIControlStateNormal];
    [tutorialBtn setImage:[UIImage imageNamed:@"IconTutorialActive"] forState:UIControlStateHighlighted];
    UIBarButtonItem *tutorialItem = [[UIBarButtonItem alloc] initWithCustomView:tutorialBtn];
    
    // lo añadimos a la barra de navegación
    self.navigationItem.rightBarButtonItem = tutorialItem;
    
    
    self.scrollView.contentSize = CGSizeMake(320, 980);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) popBack:(id)sender
{
    // do your custom handler code here
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) displayTutorial{
    // Instanciamos el tutorial
    LIPTutorialViewController *tutorialVC = [[LIPTutorialViewController alloc] init];
    
    tutorialVC.modalPresentationStyle = UIModalPresentationFullScreen;
    
    // Le ponemos un retardo de 0.5seg para evitar este error:
    // Unbalanced calls to begin/end appearance transitions for <UINavigationController: 0xa98e050>
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds *   NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.parentViewController presentViewController:tutorialVC animated:NO completion:nil];
    });

}
@end
