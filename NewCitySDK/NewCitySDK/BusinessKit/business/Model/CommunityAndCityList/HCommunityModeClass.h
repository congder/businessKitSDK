//
//  HCommunityModeClass.h
//  SmartCommunity
//
//  Created by HY on 14/10/30.
//  Copyright (c) 2014年 shenghuo. All rights reserved.
//

#import "JSONModel.h"

@interface HCommunityModeClass : JSONModel
@property (nonatomic, strong) NSString *hCommunityID;
@property (nonatomic, strong) NSString *hCommunityName;
@property (nonatomic, strong) NSString *hCommunityaddress;
@property (nonatomic, strong) NSString *hDistance;
@property (nonatomic, strong) NSString *hCityId;
@property (nonatomic, strong) NSString *hCityName;
@property (nonatomic, strong) NSString *hCityWeatherCode;

+ (HCommunityModeClass *)parsenValueJson:(NSDictionary *)valueDic;
@end
