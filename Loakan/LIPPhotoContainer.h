#import "_LIPPhotoContainer.h"
@import UIKit;

@interface LIPPhotoContainer : _LIPPhotoContainer {}

// Custom logic goes here.
@property (nonatomic, strong) UIImage *image;

+(instancetype) photoWithImage:(UIImage *) image
                       context:(NSManagedObjectContext *) context;

@end
