//
//  NSDictionary+Addition.m
//  smartcity
//
//  Created by kongjun on 14-3-2.
//  Copyright (c) 2014年 Giant. All rights reserved.
//

#import "NSDictionary+Addition.h"

@implementation NSDictionary (Addition)
- (id)NotNSNullobjectForKey:(id)aKey{
    id object=[self objectForKey:aKey];
    if (!object || [object isKindOfClass:[NSNull class]]||[@"null" isEqualToString:object]) {
        return @"";
    }
    return object;
}
@end
