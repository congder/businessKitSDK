//
//  HCityModelClass.m
//  SmartCommunity
//
//  Created by HY on 14/10/30.
//  Copyright (c) 2014年 shenghuo. All rights reserved.
//

#import "HCityModelClass.h"

@implementation HCityModelClass

+ (HCityModelClass *)parsenValueJson:(NSDictionary *)valueDic{
    HCityModelClass *cityModel = [HCityModelClass new];
    cityModel.hEnName = [valueDic NotNSNullobjectForKey:@"en_name"];
    cityModel.hCityID = [valueDic NotNSNullobjectForKey:@"city_id"];
    cityModel.hCityName = [valueDic NotNSNullobjectForKey:@"city_name"];
    cityModel.hCityIsHot = [valueDic NotNSNullobjectForKey:@"is_hot"];
    return cityModel;
}
+ (HCityModelClass *)parsenValueJsonWithResultSet:(FMResultSet *)resultSet{
    HCityModelClass *info = [[HCityModelClass alloc] init];
    info.hEnName = [resultSet stringForColumn:@"en_name"];
    info.hCityID = [resultSet stringForColumn:@"city_id"];
    info.hCityName = [resultSet stringForColumn:@"city_name"];
    info.hCityIsHot = [resultSet stringForColumn:@"is_hot"];
    return info;
}
//===========================================================
//  Keyed Archiving
//
//===========================================================
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.hEnName forKey:@"hEnName"];
    [encoder encodeObject:self.hCityID forKey:@"hCityID"];
    [encoder encodeObject:self.hCityName forKey:@"hCityName"];
    [encoder encodeObject:self.hCityIsHot forKey:@"hCityIsHot"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.hEnName = [decoder decodeObjectForKey:@"hEnName"];
        self.hCityID = [decoder decodeObjectForKey:@"hCityID"];
        self.hCityName = [decoder decodeObjectForKey:@"hCityName"];
        self.hCityIsHot = [decoder decodeObjectForKey:@"hCityIsHot"];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    id theCopy = [[[self class] allocWithZone:zone] init];  // use designated initializer
    
    [theCopy setHEnName:[self.hEnName copy]];
    [theCopy setHCityID:[self.hCityID copy]];
    [theCopy setHCityName:[self.hCityName copy]];
    [theCopy setHCityIsHot:[self.hCityIsHot copy]];
    
    return theCopy;
}
@end
