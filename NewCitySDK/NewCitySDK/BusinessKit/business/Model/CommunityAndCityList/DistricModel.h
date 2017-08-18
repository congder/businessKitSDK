//
//  DistricModel.h
//  SmartCommunity
//
//  Created by mac on 15/6/5.
//  Copyright (c) 2015年 shenghuo. All rights reserved.
//

#import "JSONModel.h"

@interface DistricModel : JSONModel

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *avgPrice;
@property (nonatomic, strong) NSString *businessId;
@property (nonatomic, strong) NSString *businessName;
@property (nonatomic, strong) NSString *businessShopNum;
@property (nonatomic, strong) NSString *categoryId;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, assign) NSString *hasCoupon;
@property (nonatomic, assign) NSString *hasDeal;
@property (nonatomic, strong) NSString *districId;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *titleName;
@property (nonatomic, strong) NSString *photoUrl;
@property (nonatomic, strong) NSString *regionId;
@property (nonatomic, strong) NSString *special;
@property (nonatomic, strong) NSString *telNum;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSString *udid;
@property (nonatomic, strong) NSString *totalCount;
@property (nonatomic, strong) NSString *storeId;

@property (nonatomic, strong) NSArray *goodsList;

+ (DistricModel *) districMoadel:(NSDictionary *)dic;
/**
 * @"/service/queryWebProductInfo"中storeList的item转换
 */
+ (DistricModel *)districMoadelWithProductInfo:(NSDictionary *)dic;
- (BOOL) hasGoodsList;
@end
