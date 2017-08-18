//
//  DistrictDetailsModel.h
//  SmartCommunity
//
//  Created by apple on 15/5/20.
//  Copyright (c) 2015年 shenghuo. All rights reserved.
//

#import "JSONModel.h"
#import <UIKit/UIKit.h>

@interface DistrictDetailsModel : JSONModel

@property (strong, nonatomic) NSString *dishes;//菜名
@property (strong, nonatomic) NSString *logoImage;//图片logo
@property (strong, nonatomic) NSString *number;//合计
@property (strong, nonatomic) NSString *company;//公司
@property (strong, nonatomic) NSString *disheId;
@property (strong, nonatomic) NSString *store_id;//店铺编号
@property (strong, nonatomic) NSString *indexPathRow;

@property (strong, nonatomic) NSString *business_id;//商家编号
@property (strong, nonatomic) NSString *business_name;//商家名称
@property (strong, nonatomic) NSString *discount;//折扣
@property (strong, nonatomic) NSString *discount_type;//折扣类型
@property (strong, nonatomic) NSString *distance;//距离
@property (strong, nonatomic) NSString *goodsId;//商品编号
@property (strong, nonatomic) NSString *isRecommended;//是否推荐
@property (strong, nonatomic) NSString *name;//店品名称
@property (strong, nonatomic) NSString *over_time;//截止时间
@property (strong, nonatomic) NSString *photo_url;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *show_price;
@property (strong, nonatomic) NSString *start_time;
@property (strong, nonatomic) NSString *storeName;
@property (strong, nonatomic) NSString *acceptOrgCode;
@property (strong, nonatomic) NSString *acceptOrgName;
@property (strong, nonatomic) NSString *special;//特色菜
@property (strong, nonatomic) NSArray *productCategoryIdList;

//销量
@property (copy, nonatomic) NSString *productSoldNo;

@property (nonatomic, strong) UIImage *newsPic;
+ (DistrictDetailsModel *)districtModel :(NSDictionary *)dic;
//调用/service/queryWebProductInfo对其填充
+ (DistrictDetailsModel *)districtDetailModel :(NSDictionary *)dic;

@end
