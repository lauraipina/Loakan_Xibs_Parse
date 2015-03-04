#import "LIPPhotoContainer.h"

@interface LIPPhotoContainer ()

// Private interface goes here.

@end

@implementation LIPPhotoContainer

// Custom logic goes here.
-(UIImage *)image {
    
    //Crear imagen desde NSData
    return [UIImage imageWithData:self.photoData];
    
}

- (void)setImage:(UIImage *)image {
    
    //Convertir imagen en NSData
    self.photoData = UIImageJPEGRepresentation(image, 0.9);
}

#pragma mark - Class Methods
+(instancetype) photoWithImage:(UIImage *) image
                       context:(NSManagedObjectContext *) context{
    
    LIPPhotoContainer *p = [NSEntityDescription insertNewObjectForEntityForName:[LIPPhotoContainer entityName]
                                                         inManagedObjectContext:context];
    
    p.photoData = UIImageJPEGRepresentation(image, 0.9);
    
    
    return p;
    
}

@end
