//
//  DistrictCouponTableViewCell.h
//  SmartCommunity
//
//  Created by 陈洋 on 16/1/5.
//  Copyright © 2016年 shenghuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseTableViewCell.h"

@interface DistrictCouponTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *couponNameLabel;
//优惠券价格
@property (strong, nonatomic) IBOutlet UILabel *couponPrice;
//门市价
@property (strong, nonatomic) IBOutlet UILabel *normalPrice;
//已售
@property (strong, nonatomic) IBOutlet UILabel *sealNumLb;
@property (weak, nonatomic) IBOutlet UIImageView *discountIcon;

- (void)hideBottomLine;
- (void)showBottomLine;
+ (CGFloat)measureHeight:(NSString *)name;

@end
