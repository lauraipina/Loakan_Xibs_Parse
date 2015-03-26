//
//  LIPMarketParse.h
//  Loakan
//
//  Created by Laura Iglesias Piña on 18/3/15.
//  Copyright (c) 2015 lip. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface LIPMarketParse : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *timeTable;
@property (nonatomic, strong) PFFile *imageFile;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) PFGeoPoint *location;
@property (nonatomic, strong) NSURL *webURL;
@property (nonatomic, strong) NSURL *facebookURL;
@property (nonatomic, strong) NSURL *twitterURL;
@property (nonatomic, strong) NSURL *instagramURL;
@property (nonatomic) BOOL isFavorite;

@end
