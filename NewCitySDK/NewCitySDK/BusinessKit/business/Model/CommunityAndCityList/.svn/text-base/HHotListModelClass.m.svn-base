//
//  HHotListModelClass.m
//  SmartCommunity
//
//  Created by HY on 14/11/4.
//  Copyright (c) 2014年 shenghuo. All rights reserved.
//

#import "HHotListModelClass.h"

@implementation HHotListModelClass
+(HHotListModelClass *)parsenValueJson:(NSDictionary *)valueDic{
    HHotListModelClass *hotListClass = [HHotListModelClass new];
    hotListClass.hGroupId = [valueDic NotNSNullobjectForKey:@"team_id"];
    hotListClass.hGroupName = [valueDic NotNSNullobjectForKey:@"team_name"];
    hotListClass.hGroupIconUrl = [valueDic NotNSNullobjectForKey:@"icon_url"];
    hotListClass.hGroupUserNum = [valueDic NotNSNullobjectForKey:@"usernum"];
    return hotListClass;
}
//===========================================================
//  Keyed Archiving
//
//===========================================================
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.hGroupId forKey:@"hGroupId"];
    [encoder encodeObject:self.hGroupName forKey:@"hGroupName"];
    [encoder encodeObject:self.hGroupIconUrl forKey:@"hGroupIconUrl"];
    [encoder encodeObject:self.hGroupUserNum forKey:@"hGroupUserNum"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.hGroupId = [decoder decodeObjectForKey:@"hGroupId"];
        self.hGroupName = [decoder decodeObjectForKey:@"hGroupName"];
        self.hGroupIconUrl = [decoder decodeObjectForKey:@"hGroupIconUrl"];
        self.hGroupUserNum = [decoder decodeObjectForKey:@"hGroupUserNum"];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    id theCopy = [[[self class] allocWithZone:zone] init];  // use designated initializer
    
    [theCopy setHGroupId:[self.hGroupId copy]];
    [theCopy setHGroupName:[self.hGroupName copy]];
    [theCopy setHGroupIconUrl:[self.hGroupIconUrl copy]];
    [theCopy setHGroupUserNum:[self.hGroupUserNum copy]];
    
    return theCopy;
}
@end
