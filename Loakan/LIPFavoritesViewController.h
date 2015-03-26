//
//  LIPFavoritesViewController.h
//  Loakan
//
//  Created by Laura Iglesias Piña on 22/3/15.
//  Copyright (c) 2015 lip. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LIPFavoritesViewController : NSObject

- (BOOL)isFavoriteMarket:(NSString *)market;
- (void)addFavoriteMarket:(NSString *)market;
- (void)removeFavoriteMarket:(NSString *)market;

@end
