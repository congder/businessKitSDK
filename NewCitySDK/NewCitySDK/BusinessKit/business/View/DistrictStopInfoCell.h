//
//  DistrictStopInfo.h
//  SmartCommunity
//
//  Created by Echo on 16/5/6.
//  Copyright © 2016年 shenghuo. All rights reserved.
//

#import "BaseTableViewCell.h"
/***停车信息***/
@interface DistrictStopInfoCell : BaseTableViewCell

@property (strong, nonatomic) IBOutlet UILabel *stopInfoLb;

+ (CGFloat)measuredHeight:(NSString *)text;
@end
