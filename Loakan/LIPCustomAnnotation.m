//
//  LIPCustomAnnotation.m
//  Loakan
//
//  Created by Laura Iglesias Piña on 23/2/15.
//  Copyright (c) 2015 lip. All rights reserved.
//

#import "LIPCustomAnnotation.h"

@implementation LIPCustomAnnotation

// Hacemos synthesize
@synthesize title, subtitle, coordinate;

// Implementamos el método de inicialización del objeto.
- (id)initWithTitle:(NSString *)aTitle subtitle:(NSString*)aSubtitle andCoordinate:(CLLocationCoordinate2D)coord
{
    self = [super init];
    title = aTitle;
    subtitle = aSubtitle;
    coordinate = coord;
    return self;
}


@end
