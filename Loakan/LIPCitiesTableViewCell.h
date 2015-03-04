//
//  LIPCitiesTableViewCell.h
//  Loakan
//
//  Created by Laura Iglesias Piña on 17/2/15.
//  Copyright (c) 2015 lip. All rights reserved.
//

@import UIKit;

@interface LIPCitiesTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;

@property (weak, nonatomic) IBOutlet UILabel *numMarketLabel;

+ (CGFloat)height;
+ (NSString *)cellId;

@end
