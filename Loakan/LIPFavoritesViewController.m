//
//  LIPFavoritesViewController.m
//  Loakan
//
//  Created by Laura Iglesias Piña on 22/3/15.
//  Copyright (c) 2015 lip. All rights reserved.
//

#import "LIPFavoritesViewController.h"

@interface LIPFavoritesViewController()

@property (strong, nonatomic) NSUserDefaults *defaults;

@end



@implementation LIPFavoritesViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.defaults = [NSUserDefaults standardUserDefaults];
        [self.defaults registerDefaults:@{@"favorites": @[]}];
    }
    return self;
}

- (BOOL)isFavoriteMarket:(NSString *)market {
    NSArray *favorites = [self.defaults arrayForKey:@"favorites"];
    return [favorites containsObject:market];
}

- (void)addFavoriteMarket:(NSString *)market{
    NSMutableArray *favorites = [[self.defaults arrayForKey:@"favorites"] mutableCopy];
    [favorites addObject:market];
    [self.defaults setObject:favorites forKey:@"favorites"];
}

- (void)removeFavoriteMarket:(NSString *)market {
    NSMutableArray *favorites = [[self.defaults arrayForKey:@"favorites"] mutableCopy];
    [favorites removeObject:market];
    [self.defaults setObject:favorites forKey:@"favorites"];
}


@end
