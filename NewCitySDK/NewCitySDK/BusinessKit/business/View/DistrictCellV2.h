//
//  DistrictCellV2.h
//  SmartCommunity
//
//  Created by 陈洋 on 16/1/8.
//  Copyright © 2016年 shenghuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DistricModel.h"
#import<UIKit/UIKit.h>
@interface DistrictCellV2 : UITableViewCell
@property (strong, nonatomic) UIImageView *districtImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UIImageView *addressIcon;
@property (strong, nonatomic) UILabel *addressLabel;
@property (strong, nonatomic) UILabel *distanceLabel;
@property (strong, nonatomic) UILabel *avgPriceLabel;
@property (strong, nonatomic) UIImageView *couponIcon;
@property (strong, nonatomic) UILabel *couponLabel; 
@property (strong, nonatomic) DistricModel *disModel;
- (void) refreshCouponUI;
@end
