//
//  DistrictDetailsModel.m
//  SmartCommunity
//
//  Created by apple on 15/5/20.
//  Copyright (c) 2015年 shenghuo. All rights reserved.
//

#import "DistrictDetailsModel.h"
#import "ImageDownloader.h"

@implementation DistrictDetailsModel


-(void)dealloc{
    
    _dishes = @"";//菜名
    _logoImage= @"";//图片logo
    _number= @"";//合计
    _company= @"";//公司
    _disheId= @"";
    _store_id= @"";//店铺编号
    _indexPathRow= @"";
    _business_id= @"";//商家编号
    _business_name= @"";//商家名称
    _discount= @"";//折扣
    _discount_type= @"";//折扣类型
    _distance= @"";//距离
    _goodsId= @"";//商品编号
    _isRecommended= @"";//是否推荐
    _name= @"";//店铺名称
    _over_time= @"";//截止时间
    _photo_url= @"";
    _price= @"";
    _show_price= @"";
    _start_time= @"";
    _storeName= @"";
    _acceptOrgCode= @"";
    _acceptOrgName= @"";
    _special= @"";//特色菜
    //_productCategoryIdList= @"";
}


+ (DistrictDetailsModel *)districtModel:(NSDictionary *)dic
{
    
    ImageDownloader * downloader = [[ImageDownloader alloc] init];
    

    
    DistrictDetailsModel *model = [DistrictDetailsModel new];
//    model.disheId = [dic objectForKey:@"id"];
//    model.dishes = [dic objectForKey:@"dishes"];
//    model.list = [dic objectForKey:@"list"];
//    model.price = [dic objectForKey:@"price"];
//    model.logoImage = [dic objectForKey:@"logoImage"];
//    model.company = [dic objectForKey:@"company"];
    
    model.business_id = [dic objectForKey:@"business_id"];
    model.business_name = [dic objectForKey:@"business_name"];
    model.discount = [dic objectForKey:@"discount"];
    model.discount_type = [dic objectForKey:@"discount_type"];
    model.distance = [dic objectForKey:@"distance"];
    model.goodsId = [dic objectForKey:@"id"];//改
    model.isRecommended = [dic objectForKey:@"isRecommended"];
    model.name = [dic objectForKey:@"name"];
    model.over_time = [dic objectForKey:@"over_time"];
    model.photo_url = [dic objectForKey:@"photo_url"];
    model.price = [dic objectForKey:@"price"];
    model.store_id = [dic objectForKey:@"storeId"];
    model.storeName = [dic objectForKey:@"storeName"];
    model.show_price = [dic objectForKey:@"show_price"];
    model.start_time = [dic objectForKey:@"start_time"];
    model.storeName = [dic objectForKey:@"storeName"];
    model.special = [dic objectForKey:@"special"];
    model.acceptOrgCode = [dic objectForKey:@"acceptOrgCode"];
    model.newsPic = [downloader loadLocalImage:[NSString stringWithFormat:@"%@",[dic objectForKey:@"photo_url"]]];
    model.productCategoryIdList = [dic objectForKey:@"productCategoryIdList"];
    
    model.productSoldNo = [dic objectForKey:@"productSoldNo"];
//    business_id;
//    business_name;
//    discount;
//    discount_type;
//    distance;
//    goodsId;
//    isRecommended;
//    name;
//    over_time;
//    photo_url;
//    price;
//    show_price;
//    start_time;
    
    return model;
}

+ (DistrictDetailsModel *)districtDetailModel :(NSDictionary *)dic {
    
    
    NSArray *storeList = dic[@"storeList"];
    NSDictionary *storeInfo = nil;
    for (NSDictionary *store in storeList) {
        if ([@"01" isEqualToString:store[@"relationType"]]) {
            storeInfo = store;
        }
    }
    NSMutableDictionary *totalInfo = [NSMutableDictionary dictionary];
    if (storeInfo) {
        totalInfo = [NSMutableDictionary dictionaryWithDictionary:storeInfo];
        [totalInfo addEntriesFromDictionary:storeInfo];
    }
    [totalInfo addEntriesFromDictionary:dic];
    totalInfo[@"business_id"] = totalInfo[@"keeperId"];
    totalInfo[@"business_name"] = totalInfo[@"keeperName"];
    [totalInfo removeObjectForKey:@"storeList"];
    
    DistrictDetailsModel *model = [DistrictDetailsModel districtModel:totalInfo];
    return model;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    self.number = [decoder decodeObjectForKey:@"number"];
    self.indexPathRow = [decoder decodeObjectForKey:@"indexPathRow"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.number forKey:@"number"];
    [encoder encodeObject:self.indexPathRow forKey:@"indexPathRow"];
}

//+ (NSMutableArray *)handleData:(NSData *)data;
//{
//    
//    //解析数据
//    NSError * error = nil;
//    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
//    NSMutableArray * originalArray = [dic objectForKey:@"news"];
//    
//    //封装数据对象
//    NSMutableArray * resultArray = [NSMutableArray array];
//    
//    for (int i=0 ;i<[originalArray count]; i++) {
//        NSDictionary * newsDic = [originalArray objectAtIndex:i];
//        DistrictDetailsModel * item = [[DistrictDetailsModel alloc] initWithDictionary:newsDic];
//        [resultArray addObject:item];
//    }
//    
//    return resultArray;
//}

@end
