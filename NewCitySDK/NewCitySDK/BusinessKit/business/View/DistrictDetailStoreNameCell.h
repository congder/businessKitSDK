//
//  DistrictDetailStoreNameCell.h
//  SmartCommunity
//
//  Created by Echo on 16/5/6.
//  Copyright © 2016年 shenghuo. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface DistrictDetailStoreNameCell : BaseTableViewCell
//店名
@property (strong, nonatomic) IBOutlet UILabel *storeNameLb;
//人均价格
@property (strong, nonatomic) IBOutlet UILabel *averagePrice;
/***距离我***/
@property (strong, nonatomic) IBOutlet UILabel *dictanctToMe;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineHeight;

-(void)setData:(NSDictionary *)data;
+(float)getStoreNameStringHeight:(NSString *)string;
@end
