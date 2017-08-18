//
//  NetworkOperation.h
//  TeamWork
//
//  Created by kongjun on 14-6-17.
//  Copyright (c) 2014年 Shenghuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MacroDefine.h"
#import "AFNetworking.h"
@interface APIOperation : NSObject<UIAlertViewDelegate>

+ (NSDictionary *)makeRequestWithBody: (NSDictionary *)Params;
+ (id) getAFHttpClient: (NSString*)URLString;
+ (AFHTTPRequestOperation *)GET:(id)AFHttpClient
                            url:(NSString*)URLString
                     parameters:(id)parameters
                   onCompletion:(void (^)(id responseData, NSError* error))completionBlock;
+ (AFHTTPRequestOperation *)GET:(NSString *)URLString
  parameters:(id)parameters
onCompletion:(void (^)(id responseData, NSError *error))completionBlock;

+ (void )POST:(NSString *)URLString
   parameters:(id)parameters
 onCompletion:(void (^)(id responseData, NSError *error))completionBlock;

+(void)uploadMedia:(NSString*)URLString parameters:(id)parameters
      onCompletion:(void (^)(id responseData, NSError* error))completionBlock;

+(void)uploadMutipleMedia:(NSString*)URLString parameters:(id)parameters
             onCompletion:(void (^)(id responseData, NSError* error))completionBlock;
+ (void)SEARCHGET:(NSInteger)indexForNum url:(NSString*)URLString
       parameters:(id)parameters
     onCompletion:(void (^)(id responseData, NSError* error,NSInteger indexNum))completionBlock;
@end
