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
    NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
    if([language isEqualToString:@"es"]) {
        self.title = @"Información Legal";
    } else {
        self.title = @"Legal Information";
    }
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
    
    
    self.scrollView.contentSize = CGSizeMake(320, 880);
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
    if([language isEqualToString:@"es"]) {
        
        self.lbl1.text = @"Bienvenidos a LOAKAN";
        self.lbl2.text = @"Aviso Legal";
        self.lbl3.text = @"Imágenes & Iconos";
        self.lbl4.text = @"Contacto";
    
        self.txt1.text = @"El objetivo de Loakan es proporcionar una guía de mercadillos de ropa de 2ª mano o artesaneles y pop-up stores a nivel mundial de una forma sencilla y rápida.\n\n Solo tienes que seleccionar una ciudad y se mostrarán los mercadillos más conocidos en ella. ";
        self.txt2.text = @"La información recogida en esta aplicación se ha obtenido de fuentes fiables, pero LOAKAN no garantiza que sea exacta, completa o actualizada. Para ello, es mejor consultar las webs oficiales de los mercadillos.\n\n LOAKAN declina expresamente cualquier responsabilidad por error u omisión en la información contenida.";
        self.txt3.text = @"Las imágenes usadas son de libre derecho o nos las han proporcionado los mercadillos.\n\n El logo y los iconos utilizados han sido diseñados por Laura Iglesias.";
        self.txt4.text = @"Por favor, para cualquier información adicional, sugerencia o propuesta póngase en contacto con:\n\n loakan_app@gmail.com";
        
    } else {
        
        self.lbl1.text = @"Welcome to Loakan";
        self.lbl2.text = @"Legal Advice";
        self.lbl3.text = @"Images & Icons";
        self.lbl4.text = @"Contact";
        
        self.txt1.text = @"The objective of Loakan is to provide a guide to Markets 2nd hand clothing or artesaneles and pop-up stores worldwide simply and quickly.\n\n Just select a city and the most famous markets it is displayed.";
        self.txt2.text = @"The information contained in this application has been obtained from reliable sources, but Loakan not guaranteed to be accurate, complete or current. For this it is best to consult the official sites of the markets.\n\n Loakan expressly disclaims any responsibility for errors or omissions in the information.";
        self.txt3.text = @"Images used are free standing or we have provided the markets.\n\n The logo and icons used are designed by Laura Iglesias.";
        self.txt4.text = @"Please, for any additional information, suggestion or proposal, please contact:\n\nloakan_app@gmail.com";
    }
    
    self.lbl1.font = [UIFont fontWithName:@"CaviarDreams-Bold" size:16];
    self.lbl2.font = [UIFont fontWithName:@"CaviarDreams-Bold" size:16];
    self.lbl3.font = [UIFont fontWithName:@"CaviarDreams-Bold" size:16];
    self.lbl4.font = [UIFont fontWithName:@"CaviarDreams-Bold" size:16];
    
    self.txt1.font = [UIFont fontWithName:@"Caviar Dreams" size:13];
    self.txt2.font = [UIFont fontWithName:@"Caviar Dreams" size:13];
    self.txt3.font = [UIFont fontWithName:@"Caviar Dreams" size:13];
    self.txt4.font = [UIFont fontWithName:@"Caviar Dreams" size:13];
    
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
