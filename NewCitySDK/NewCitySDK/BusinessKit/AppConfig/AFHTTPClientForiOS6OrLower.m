//
//  AFHTTPClientForiOS6AndLower.m
//  TeamWork
//
//  Created by kongjun on 14-7-30.
//  Copyright (c) 2014年 Shenghuo. All rights reserved.
//

#import "AFHTTPClientForiOS6OrLower.h"
#import "NetworkAPI.h"
@implementation AFHTTPClientForiOS6OrLower

+ (instancetype) sharedClient:(NSString *)URL
{
    NSString *URLString = @"";
    
    if ([[NSString stringWithFormat:@"%@",URL] rangeOfString:@"/app_gw/film"].location != NSNotFound) {
        URLString = kBaseWithMoive;
        static AFHTTPClientForiOS6OrLower *_sharedMovie = Nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _sharedMovie = [[AFHTTPClientForiOS6OrLower alloc] initWithBaseURL:[NSURL URLWithString:URLString]];
            _sharedMovie.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        });
        
        return _sharedMovie;
    }else{
        URLString = kBaseURL;
        static AFHTTPClientForiOS6OrLower *_sharedClient = Nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _sharedClient = [[AFHTTPClientForiOS6OrLower alloc] initWithBaseURL:[NSURL URLWithString:URLString]];
            _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        });
        return _sharedClient;
    }
}
@end
