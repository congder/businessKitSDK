//
//  AFHTTPClientUtil.h
//  TeamWork
//
//  Created by kongjun on 14-6-16.
//  Copyright (c) 2014年 Shenghuo. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface AFHTTPClientUtil : AFHTTPSessionManager

+ (instancetype)sharedClient:(NSString *)URL;

@end
