//
//  LIPMarketsCollectionViewController.h
//  Loakan
//
//  Created by Laura Iglesias Piña on 18/2/15.
//  Copyright (c) 2015 lip. All rights reserved.
//

@import UIKit;
@import Social;
#import <ParseUI/PFQueryCollectionViewController.h>

@interface LIPMarketsCollectionViewController : PFQueryCollectionViewController

@property (nonatomic, strong) NSArray *favoriteMarkets;
@property (nonatomic) BOOL isDisplayFavorite;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *className;

@property (nonatomic) BOOL isFavorite;

- (instancetype)initWithClassName:(NSString *)className
                             city:(NSString *)aCity;

- (instancetype)initWithClassName:(NSString *)className
                   arrayFavorites:(NSArray *)myFavoriteMarkets;

@end
