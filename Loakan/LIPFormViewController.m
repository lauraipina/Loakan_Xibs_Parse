//
//  LIPFormViewController.m
//  Loakan
//
//  Created by Laura Iglesias Piña on 23/2/15.
//  Copyright (c) 2015 lip. All rights reserved.
//

#import "LIPFormViewController.h"

@interface LIPFormViewController ()

@end

@implementation LIPFormViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Nuevo Mercadillo";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //Indicamos que se muestren teclados numericos para determinados datos
    //[ self.webTextView:UIKeyboardTypeEmailAddress];
    
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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)sendEmail:(id)sender {
    
    //Valido que se hayan rellenado ciertos campos
    NSString *nameM = [NSString stringWithFormat:@"%@",_nameMarketTextView.text];
    NSString *cityM = [NSString stringWithFormat:@"%@",_cityMarketTextView.text];
    
    //Valida que ciertos campos esten rellenos
    if ([nameM length] == 0 || [cityM length] == 0)
    {
        //Lanzar aquí una alerta avisando que el textfield no tiene texto
        UIAlertController *alert =   [UIAlertController
                                      alertControllerWithTitle:@"Información"
                                      message:@"Debes rellenar el nombre y la ciudad del mercado. Gracias."
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
       
        return;
        
    }
    else
    {
        //Manda email
        NSLog(@"btn enviar - Lanzamos email");
        
        // verificamos si es posible enviar correo desde este dispositivo
        if ([MFMailComposeViewController canSendMail])
        {

            MFMailComposeViewController *emailcontroller = [[MFMailComposeViewController alloc] init];
            
            emailcontroller.mailComposeDelegate = self;
            
            //Controlar que existe la cuenta de email
            if (emailcontroller !=nil)
            {
                
                [emailcontroller setSubject:@"Nuevo Mercadillo"];
                
                NSString *body = [NSString stringWithFormat:@"Me gustaría que añadierais un nuevo mercadillo, cuyo nombre es <b>%@</b>, se realiza en <b>%@</b> y su web o red social es <b>%@</b>. Muchas gracias! ", _nameMarketTextView.text, _cityMarketTextView, _webTextView];
                
                [emailcontroller setMessageBody:body isHTML:YES];
                
                [emailcontroller setToRecipients:@[@"loakan_app@gmail.com"]];
                
                emailcontroller.mailComposeDelegate = self;
                
                [self presentViewController:emailcontroller animated:YES completion:nil];
                
                NSLog(@"btn enviar - email lanzado");
                
            }
            else
            {
                // mostramos una alerta "Revise su configuración de correo electrónico"
                UIAlertController * alert =  [UIAlertController
                                              alertControllerWithTitle:@"Información"
                                              message:@"Revise su configuración de correo electrónico."
                                              preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [alert dismissViewControllerAnimated:YES completion:nil];
                                         
                                     }];
                
                [alert addAction:ok];
                
                [self presentViewController:alert animated:YES completion:nil];
                
                return;
                
                
            }
        }
        else
        {
            // mostramos una alerta si el dispositivo no puede enviar correo
            UIAlertController * alert =  [UIAlertController
                                          alertControllerWithTitle:@"Información"
                                          message:@"Tu dispositivo no puede enviar correos."
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                 }];
            
            [alert addAction:ok];
            
            [self presentViewController:alert animated:YES completion:nil];
            
            return;

        }
    }
}

- (IBAction)cerrarTeclado:(id)sender {
}

#pragma mark - MFMailComposeViewController
//Este metodo cerrará el email cuando se envie o se cancele
- (void)mailComposeController:(MFMailComposeViewController*)emailcontroller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"La operación ha sido cancelada");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"El correo ha sido guardado en la carpeta borradores");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Correo puesto en la cola de envío satisfactoriamente");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"No se ha podido enviar o guardar el correo debido a un error");
            break;
        default:
            break;
    }
    
    // cerramos la ventana modal de envío de correo
    [self dismissViewControllerAnimated:YES completion: nil];
}

- (void) popBack:(id)sender
{
    // do your custom handler code here
    [self.navigationController popViewControllerAnimated:YES];
}

@end
