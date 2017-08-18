//
//  DistrictFeatureTableViewCell.h
//  SmartCommunity
//
//  Created by Xiaowen Ji on 07/12/15.
//  Copyright © 2015 shenghuo. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface DistrictFeatureTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dmts;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UIImageView *iconImage;

+ (CGFloat)measuredHeight:(NSString *)text;
@end
