//
//  HHotListModelClass.h
//  SmartCommunity
//
//  Created by HY on 14/11/4.
//  Copyright (c) 2014年 shenghuo. All rights reserved.
//

#import "JSONModel.h"

@interface HHotListModelClass : JSONModel
@property (nonatomic, strong) NSString *hGroupId;
@property (nonatomic, strong) NSString *hGroupName;
@property (nonatomic, strong) NSString *hGroupIconUrl;
@property (nonatomic, strong) NSString *hGroupUserNum;
+(HHotListModelClass *)parsenValueJson:(NSDictionary *)valueDic;
@end
