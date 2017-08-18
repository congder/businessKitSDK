//
//  AFHTTPClientForiOS6AndLower.h
//  TeamWork
//
//  Created by kongjun on 14-7-30.
//  Copyright (c) 2014年 Shenghuo. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
@interface AFHTTPClientForiOS6OrLower : AFHTTPRequestOperationManager
+ (instancetype)sharedClient:(NSString *)URL;
@end
