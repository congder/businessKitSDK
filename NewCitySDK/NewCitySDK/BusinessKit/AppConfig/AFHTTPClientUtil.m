//
//  AFHTTPClientUtil.m
//  TeamWork
//
//  Created by kongjun on 14-6-16.
//  Copyright (c) 2014年 Shenghuo. All rights reserved.
//

#import "AFHTTPClientUtil.h"
#import "NetworkAPI.h"

@implementation AFHTTPClientUtil


+ (instancetype) sharedClient:(NSString *)URL{
    NSString *URLString = @"";
    
    if ([[NSString stringWithFormat:@"%@",URL] rangeOfString:@"/app_gw/"].location != NSNotFound) {
        URLString = kBaseWithMoive;
        static AFHTTPClientUtil *_sharedMovie = Nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _sharedMovie = [[AFHTTPClientUtil alloc] initWithBaseURL:[NSURL URLWithString:URLString]];
            _sharedMovie.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        });
        
        return _sharedMovie;
    } else if([URL rangeOfString:@"/online_activity/"].location != NSNotFound) {
        URLString = kActivityURL;
        static AFHTTPClientUtil *_sharedActivity = Nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _sharedActivity = [[AFHTTPClientUtil alloc] initWithBaseURL:[NSURL URLWithString:URLString]];
            _sharedActivity.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        });
        return _sharedActivity;
    } else {
        URLString = kBaseURL;
        static AFHTTPClientUtil *_sharedClient = Nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _sharedClient = [[AFHTTPClientUtil alloc] initWithBaseURL:[NSURL URLWithString:URLString]];
            _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        });
        return _sharedClient;
    }
}

@end
