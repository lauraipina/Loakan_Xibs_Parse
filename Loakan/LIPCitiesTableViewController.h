//
//  LIPCitiesTableViewController.h
//  Loakan
//
//  Created by Laura Iglesias Piña on 17/2/15.
//  Copyright (c) 2015 lip. All rights reserved.
//

@import UIKit;
#import "LIPCoreDataTableViewController.h"

@class LIPCity;


@interface LIPCitiesTableViewController : LIPCoreDataTableViewController 

@property (strong, nonatomic) LIPCity *city;


@end
