//
//  LIPCitiesTableViewCell.m
//  Loakan
//
//  Created by Laura Iglesias Piña on 17/2/15.
//  Copyright (c) 2015 lip. All rights reserved.
//

#import "LIPCitiesTableViewCell.h"

@implementation LIPCitiesTableViewCell

#pragma mark - Class methods
+ (CGFloat)height {
    return 60.0;
}

+ (NSString *)cellId {
    return [self description];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
