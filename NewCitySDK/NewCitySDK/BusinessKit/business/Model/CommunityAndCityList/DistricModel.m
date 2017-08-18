//
//  DistricModel.m
//  SmartCommunity
//
//  Created by mac on 15/6/5.
//  Copyright (c) 2015年 shenghuo. All rights reserved.
//

#import "DistricModel.h"

@implementation DistricModel

+ (DistricModel *)districMoadel:(NSDictionary *)dic
{
    DistricModel *model = [DistricModel new];
    model.avgPrice = [dic objectForKey:@"avg_price"];
    model.businessId = [dic objectForKey:@"business_id"];
    model.businessName = [dic objectForKey:@"business_name"];
    model.districId = [dic objectForKey:@"id"];
    model.titleName = [dic objectForKey:@"name"];
    model.businessShopNum = [dic objectForKey:@"business_shop_num"];
    model.categoryId = [dic objectForKey:@"category_id"];
    model.distance = [dic objectForKey:@"distance"];
    model.hasCoupon = [dic objectForKey:@"has_coupon"];
    model.hasDeal = [dic objectForKey:@"has_deal"];
    model.latitude = [dic objectForKey:@"latitude"];
    model.longitude = [dic objectForKey:@"longitude"];
    model.photoUrl = [dic objectForKey:@"photo_url"];
    model.regionId = [dic objectForKey:@"region_id"];
    model.special = [dic objectForKey:@"special"];
    model.telNum = [dic objectForKey:@"telNum"];
    model.telephone = [dic objectForKey:@"telephone"];
    model.udid = [dic objectForKey:@"udid"];
    model.totalCount = [dic objectForKey:@"total_count"];
    model.storeId = [dic objectForKey:@"id"];
    model.goodsList = [dic objectForKey:@"goods_list"];
    return model;
}

//@"/service/queryWebProductInfo"中storeList的item转换
+ (DistricModel *)districMoadelWithProductInfo:(NSDictionary *)dic
{
    DistricModel *model = [DistricModel districMoadel:dic];
    model.telephone = dic[@"phoneNum"];
    model.titleName = dic[@"storeName"];
    model.storeId = dic[@"storeId"];
    model.address = dic[@"storeAddress"];
    return model;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
//    self.number = [decoder decodeObjectForKey:@"number"];
//    self.indexPathRow = [decoder decodeObjectForKey:@"indexPathRow"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
//    [encoder encodeObject:self.number forKey:@"number"];
//    [encoder encodeObject:self.indexPathRow forKey:@"indexPathRow"];
}

- (BOOL) hasGoodsList {
    return self.goodsList != nil && self.goodsList.count > 0;
}

@end
