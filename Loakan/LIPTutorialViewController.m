//
//  LIPTutorialViewController.m
//  Loakan
//
//  Created by Laura Iglesias Piña on 2/3/15.
//  Copyright (c) 2015 lip. All rights reserved.
//

#import "LIPTutorialViewController.h"
#import "LIPCitiesTableViewController.h"

@interface LIPTutorialViewController ()

@end

@implementation LIPTutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Configuramos nuestras paginas
    [self configurePage];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Va por 2 vias : o si clickeamos la bolita o si movemos la imagen
- (IBAction)changePage:(id)sender {
    
    //Obtenemos el frame
    CGRect frame = self.tutorialScrollView.frame;
    
    //Obtenemos su tamaño
    frame.origin.x = frame.size.width * self.tutorialPageControl.currentPage; //Va a ser el tamaño del frame multiplicado por la pagina actual
    frame.origin.y = 0;
    
    //animamos el cambio de imagen
    [self.tutorialScrollView scrollRectToVisible:frame animated:YES];
    
    pageControl_isChangePage = NO;
}

- (IBAction)btnExitTutorial:(id)sender {
    
 [self dismissViewControllerAnimated:YES completion:nil];
}


//Metodo propio de configuracion de la pagina
-(void) configurePage{
    
    //Aqui le digo quien va a ser el delegado... tiene el poder de hacer las cosas
    //ScrollView se le pasa al file owner al delegate
    self.tutorialScrollView.delegate = self;
    
    //Cambiamos el color del fondo
    [self.tutorialScrollView setBackgroundColor:[UIColor whiteColor]];
    
    //Varias configuraciones del scroll
    //si arrastras el dedo, no te deja hasta que acabe la animacion
    [self.tutorialScrollView setCanCancelContentTouches:NO];
    self.tutorialScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.tutorialScrollView.clipsToBounds = YES;
    self.tutorialScrollView.scrollEnabled = YES;
    self.tutorialScrollView.pagingEnabled = YES;
    
    //Variables utiles
    NSUInteger nimages = 0;
    //cx lo tenemos que poner a 30 para que empiece la imagen centrada (no entiendo el porque)
    //CGFloat cx = 30; //desplazamiento horizontal que van a tener las imagenes
    CGFloat cx = 0;
    //FOR raro para aumentar una variable
    for( ; ; nimages++){
        
        //Hay que cortarlo, pq sino sería infinito
        //Le ponemos una condicion: si se han acabado las imagenes, que corte..
        //Le sumamos un 1 pq las imagenes empiezan en 0
        NSString *imageName = nil;
        //NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
        imageName = [NSString stringWithFormat:@"Tutorial_%lu",(nimages +1)];
        /*if([language isEqualToString:@"es"]) {
            imageName = [NSString stringWithFormat:@"image%d.jpg",(nimages +1)];
        } else {
            imageName = [NSString stringWithFormat:@"image_en%d.jpg",(nimages +1)];
        }*/
        
        //Fabricamos una imagen con el objeto UIImage
        UIImage *image = [UIImage imageNamed:imageName];
        
        //si es nulo, salimos del bucle
        if(image == nil){
            
            break;
        }
        
        //Esto lo hacemos para ver otra forma de resolverlo, pero metiendo las imagenes en un Array, sería correcto!!
        
        //Necesitamos un UIImageView
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        //Le decimos el modo de contenido que va a tener
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        //Montamos el rectangulo sucio para indicarle donde montar el UIImageView
        CGRect rect = imageView.frame;
        
        //OJO!!! el tamaño del scrollView tiene que estar en la SCENE con el mismo tamaño de la pantalla --> SINO saldrán las fotos mal montadas!!
        
        //Le indicamos que el RECT tenga la altura del ScrollView
        rect.size.height = [[self tutorialScrollView] bounds].size.height;
        
        //Lo mismo para la anchura
        rect.size.width = [[self tutorialScrollView] bounds].size.width;
        
        rect.origin.x = (self.tutorialScrollView.frame.size.width - [[self view] bounds].size.width) + cx;
        rect.origin.y = (self.tutorialScrollView.frame.size.height - [[self view] bounds].size.height);
        
        // Bajar el origen de altura en iPhone 5
        //if ([[UIScreen mainScreen] bounds].size.height == 568) {
        //    rect.origin.y = rect.origin.y + 70;
        //}
        
        
        //Le volvemos a asignar el rect "configurado" al frame del ImageView
        imageView.frame = rect;
        
        //Le añadimos la imagen al scrollview
        [self.tutorialScrollView addSubview:imageView];
        
        //Para que no se acumulen las imagenes una encima de otra... necesitamos hacer un incremento para que se coloquen una al lado de otra
        cx += self.tutorialScrollView.frame.size.width;
        
    }//FIN FOR
    
    //Numero de bolitas va a coincidir con el numero de imagenes
    self.tutorialPageControl.numberOfPages = nimages;
    
    //Actualizamos el tamaño
    [self.tutorialScrollView setContentSize:CGSizeMake(cx,[self.tutorialScrollView bounds].size.height)];
    
}

//*********** PROTOCOLO Scroll tiene metodos que hay que implementar
#pragma mark - UIScrollViewDelegate

//Se ha hecho un Scroll

//Estamos usando estas propiedades para tocar tanto el componente como el contenido (da warning en .m por eso) --> scrollView cambiamos a _scrollView
-(void) scrollViewDidScroll:(UIScrollView *) _scrollView
{
    
    //Si pageControlEsCambioPagina es TRUE, se sale y no continua
    if(pageControl_isChangePage){
        return;
    }
    
    //No hace esto si estamos en transicion
    
    //Le pedimos el ancho de la pagina por la que vamos
    CGFloat pageWidth = self.tutorialScrollView.frame.size.width;
    
    //Numero de pagina
    //el OFFSET es toda la tira que lleva recorrida
    //El FLOOR redondea
    int page = floor((_scrollView.contentOffset.x - pageWidth /2) / pageWidth) +1;
    
    self.tutorialPageControl.currentPage = page;
    
}

//Cuando se ha parado el Scroll
-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    pageControl_isChangePage = NO;
    
}



@end
