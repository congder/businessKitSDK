//
//  DistrictBusStationInfoCell.h
//  SmartCommunity
//
//  Created by Echo on 16/5/6.
//  Copyright © 2016年 shenghuo. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface DistrictBusStationInfoCell : BaseTableViewCell
@property (strong, nonatomic) IBOutlet UILabel *busStationInfoLb;
+ (CGFloat)measuredHeight:(NSString *)text;
@end
