//
//  HCityModelClass.h
//  SmartCommunity
//
//  Created by HY on 14/10/30.
//  Copyright (c) 2014年 shenghuo. All rights reserved.
//

#import "JSONModel.h"

@interface HCityModelClass : JSONModel
@property (nonatomic, strong) NSString *hEnName;
@property (nonatomic, strong) NSString *hCityID;
@property (nonatomic, strong) NSString *hCityName;
@property (nonatomic, strong) NSString *hCityIsHot;

+ (HCityModelClass *)parsenValueJson:(NSDictionary *)valueDic;
+ (HCityModelClass *)parsenValueJsonWithResultSet:(FMResultSet *)resultSet;
@end
