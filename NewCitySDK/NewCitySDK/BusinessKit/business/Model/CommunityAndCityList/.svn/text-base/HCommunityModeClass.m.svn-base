//
//  HCommunityModeClass.m
//  SmartCommunity
//
//  Created by HY on 14/10/30.
//  Copyright (c) 2014年 shenghuo. All rights reserved.
//

#import "HCommunityModeClass.h"

@implementation HCommunityModeClass

+ (HCommunityModeClass *)parsenValueJson:(NSDictionary *)valueDic{
    HCommunityModeClass *communityMode = [[HCommunityModeClass alloc] init];
    communityMode.hCommunityID = [valueDic NotNSNullobjectForKey:@"community_id"];
//     communityMode.hCommunityID = [valueDic NotNSNullobjectForKey:@"city_id"];//社区id去掉
    communityMode.hCommunityName = [valueDic NotNSNullobjectForKey:@"community_name"];
    communityMode.hCommunityaddress = [valueDic NotNSNullobjectForKey:@"address"];
    communityMode.hDistance = [valueDic NotNSNullobjectForKey:@"distance"];
    communityMode.hCityId = [valueDic NotNSNullobjectForKey:@"city_id"];
    communityMode.hCityName = [valueDic NotNSNullobjectForKey:@"city_name"];
    communityMode.hCityWeatherCode = [valueDic NotNSNullobjectForKey:@"weather_code"];
    return communityMode;
}


//===========================================================
//  Keyed Archiving
//
//===========================================================
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.hCommunityID forKey:@"community_id"];
    [encoder encodeObject:self.hCommunityName forKey:@"hCommunityName"];
    [encoder encodeObject:self.hCommunityaddress forKey:@"hCommunityaddress"];
    [encoder encodeObject:self.hDistance forKey:@"hDistance"];
    [encoder encodeObject:self.hCityId forKey:@"hCityId"];
    [encoder encodeObject:self.hCityName forKey:@"hCityName"];
    [encoder encodeObject:self.hCityWeatherCode forKey:@"hCityWeatherCode"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.hCommunityID = [decoder decodeObjectForKey:@"community_id"];
        self.hCommunityName = [decoder decodeObjectForKey:@"hCommunityName"];
        self.hCommunityaddress = [decoder decodeObjectForKey:@"hCommunityaddress"];
        self.hDistance = [decoder decodeObjectForKey:@"hDistance"];
        self.hCityId = [decoder decodeObjectForKey:@"hCityId"];
        self.hCityName = [decoder decodeObjectForKey:@"hCityName"];
        self.hCityWeatherCode = [decoder decodeObjectForKey:@"hCityWeatherCode"];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    id theCopy = [[[self class] allocWithZone:zone] init];  // use designated initializer
    
    [theCopy setHCommunityID:[self.hCommunityID copy]];
    [theCopy setHCommunityName:[self.hCommunityName copy]];
    [theCopy setHCommunityaddress:[self.hCommunityaddress copy]];
    [theCopy setHDistance:[self.hDistance copy]];
    [theCopy setHCityId:[self.hCityId copy]];
    [theCopy setHCityName:[self.hCityName copy]];
    [theCopy setHCityWeatherCode:[self.hCityWeatherCode copy]];
    
    return theCopy;
}
@end
