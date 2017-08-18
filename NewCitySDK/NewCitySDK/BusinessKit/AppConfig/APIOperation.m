//
//  NetworkOperation.m
//  TeamWork
//
//  Created by kongjun on 14-6-17.
//  Copyright (c) 2014年 Shenghuo. All rights reserved.
//

#import "APIOperation.h"
#import "RESTError.h"
#import "NetworkAPI.h"
#import "MacroDefine.h"
//#import "CommonViewController.h"
#import "SystemConfigUtil.h"
#import "MacroDefine.h"
#import "HEncryptClass.h"
#import "AFHTTPClientForiOS6OrLower.h"
#import "UIViewController+HUD.h"
#import "MJExtension.h"
#import "3Des.h"
#import "AFHTTPClientUtil.h"
#define kMessage @"message"
#define kAFHttpClient ((CURRENT_SYS_VERSION_FLOAT < 7.0)?mAFHTTPClientForiOS6OrLower:mAFHTTPClient)
#define hAFHttpClient ((CURRENT_SYS_VERSION_FLOAT < 7.0)?mA)
#define CNetworkFail    @"网络不给力,请稍候重试"
#define GW_TOKEN_EXPIRE_ERROR_MESSAGE   @"用户令牌失效"

@implementation APIOperation

static UIAlertView *tokenErrorAlert;

#pragma mark - 解密返回数据
+ (id)decryptPacket:(NSString *)url res:(id)responseObject withToken: (NSString *)token{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"APIDecryptConfig" ofType:@"plist"];
    NSDictionary *decryptConfig = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSDictionary *config;
    for (NSString *key in [decryptConfig keyEnumerator]) {
        if ([url rangeOfString:key].location != NSNotFound) {
            config = decryptConfig[key];
        }
    }
//    DLog(@"%@", responseObject);
    @try {
        if (config) {
            id returnData = [APIOperation decryptRecursion:config withData:responseObject withPKey:nil withToken:token];
//            DLog(@"%@", returnData);
            return returnData;
        }
    }
    @catch (NSException *exception) {
//        DLog(@"%@", exception);
//        DLog(@"%@", responseObject);
        return responseObject;
    }
//    DLog(@"%@", responseObject);
    return responseObject;
}

+ (id)decryptRecursion: (id) config withData: (id) responseObject withPKey: (NSString *)pKey withToken: (NSString *)token {
    id decryptObject;
    if ([responseObject isKindOfClass:NSArray.class]) {
        decryptObject = [NSMutableArray array];
        for (id item in responseObject) {
            [decryptObject addObject:[APIOperation decryptRecursion:config withData:item withPKey:nil withToken:token]];
        }
    } else if ([responseObject isKindOfClass:NSDictionary.class]) {
        decryptObject = [NSMutableDictionary dictionaryWithDictionary:responseObject];
        for (NSString *key in [responseObject keyEnumerator]) {
            decryptObject[key] = [APIOperation decryptRecursion:config withData:responseObject[key] withPKey:key withToken:token];
        }
    } else {
        decryptObject = responseObject;
        @try {
            if (pKey && config[pKey]) {
                if ([@"DES" isEqualToString:config[pKey]]) {
                    if (token) {
                        decryptObject = [hEncrypt desDecryptWithKeyAndIV:responseObject withEnToken: token];
                    } else {
                        decryptObject = [hEncrypt desDecryptWithKeyAndIV:responseObject];
                    }
                }
            }
        }
        @catch (NSException *exception) {
            DLog(@"%@", exception);
        }
        @finally {
            if (!decryptObject || [@"" isEqualToString:decryptObject]) {
                decryptObject = responseObject;
            }
        }
    }
    return decryptObject;
}

+ (id) getAFHttpClient: (NSString*)URLString
{
    id AFHttpClient = ((CURRENT_SYS_VERSION_FLOAT < 7.0)?mAFHTTPClientForiOS6OrLower(URLString):mAFHTTPClient(URLString));
    return AFHttpClient;
}

//GAO
//拼接请求头
+ (NSDictionary *)makeRequestWithBody: (NSDictionary *)Params {
    return @{
//                             @"ReqSvcHeader": @{
//                                 @"tranDate": @"20160929",
//                                 @"tranTime": @"093249089",
//                                 @"tranTellerNo": @"10000002",
//                                 @"tranSeqNo": @"0790120160929093249593e000000001",
//                                 @"consumerId": @"079",
//                                 @"globalSeqNo": @"0790120160929093249593e",
//                                 @"sourceSysId": @"079",
//                                 @"branchId": @"P35H",
//                                 @"terminalCode": @"01000012345",
//                                 @"cityCode": @"010",
//                                 @"authrTellerNo": @"0123",
//                                 @"ip": @"192.168.108.125",
//                                 @"medium": @"06"
//                             },
//                             @"SvcBody": Params
             @"ReqSvcHeader": @{
                     @"tranDate":@"20160929",
                     @"tranTime":@"093249089",
                     @"tranTellerNo":@"10000002",
                     @"tranSeqNo":@"0790120160929093249593e000000001",
                     @"consumerId":@"079",
                     @"globalSeqNo":@"0790120160929093249593e",
                     @"sourceSysId":@"079",
                     @"branchId":@"P35H",
                     @"terminalCode":@"01000012345",
                     @"cityCode":@"010",
                     @"authrTellerNo":@"0123",
                     @"ip":@"192.168.108.125",
                     @"medium":@"06"
                     },
             @"SvcBody": Params
             
                            };
    
}
#pragma mark - 处理发送数据 公共输入
+ (id) handleReqPacket: (id) parameters withURL:(NSString *)url {
    id paramDic = parameters;
    if (parameters && ([parameters isKindOfClass:NSDictionary.class] || [parameters isKindOfClass:NSMutableDictionary.class])) {
        paramDic = [NSMutableDictionary dictionaryWithDictionary:parameters];
        if (!paramDic[@"appVersion"]) {
            NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            paramDic[@"appVersion"] = appVersion;
        }
//        if (!paramDic[@"reqEqptType"]) {
//            paramDic[@"reqEqptType"] = @"0";
//        }
        if (url && [url rangeOfString:@"/app_gw/"].location != NSNotFound) {
            
            NSString *uid = [mUserDefaults objectForKey:HCurrentUid];
            NSDictionary *reqAppInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"0", @"reqEqptType", uid ? uid : @"", @"uid", nil];
            NSString *reqAppInfoStr = [reqAppInfo mj_JSONString];
            
            __block NSDictionary *tokenDic;
            NSString *decryptToken = paramDic[CKeyTempClearToken];
            if (decryptToken) {
                NSString *userToken = paramDic[@"userToken"];
                NSString *tokenDESKey = [SystemConfigUtil calculateDESKEYWithToken:decryptToken];
                NSString *tokenDESIV = [SystemConfigUtil calculateDESIVWithToken:decryptToken];
                NSString *reqAppInfoEncryptStr = [_Des TripleDES:reqAppInfoStr encryptOrDecrypt:kCCEncrypt key:tokenDESKey andIV:tokenDESIV];
                tokenDic = @{@"reqAppInfo": reqAppInfoEncryptStr ? reqAppInfoEncryptStr : @"",
                             @"token": decryptToken,
                             @"userToken": userToken ? userToken : @""};
            } else {
                [hEncrypt newTokenEncryptParameter:@{@"reqAppInfo": reqAppInfoStr} encryptKey:@[@"reqAppInfo"] onCompletion:^(NSDictionary *params) {
                    tokenDic = params;
                }];
            }
            
            NSString *userToken = tokenDic[@"userToken"];
            if (!paramDic[@"userToken"] && userToken) {
                paramDic[@"userToken"] = userToken;
            }
            if (!paramDic[@"token"]) {
                paramDic[@"token"] = tokenDic[@"token"];
            }
            
            paramDic[@"reqAppInfo"] = tokenDic[@"reqAppInfo"];
            
        }
    }
    return paramDic;
}

+ (AFHTTPRequestOperation *)GET:(id)AFHttpClient
                            url:(NSString*)URLString
                     parameters:(id)parameters
                   onCompletion:(void (^)(id responseData, NSError* error))completionBlock
{
    id paramDic = [APIOperation handleReqPacket:parameters withURL:URLString];
    NSString *decryptToken;
    if (paramDic[CKeyTempClearToken]) {
        decryptToken = paramDic[CKeyTempClearToken];
        [paramDic removeObjectForKey:CKeyTempClearToken];
    }
    
    AFHTTPRequestOperation *operation = [AFHttpClient GET:URLString parameters:paramDic success:^(id operation, id responseObject) {
        DLog(@"%@", responseObject);
        [APIOperation doNetworkSuccess:operation withDecryptToken:decryptToken withResponseObject:responseObject url:URLString onCompletion:completionBlock];
    } failure:^(id operation, NSError* error) {
        [APIOperation doNetworkFail:operation withDecryptToken:decryptToken withError:error url:URLString  onCompletion:completionBlock];
    }];
    return operation;
}

+ (AFHTTPRequestOperation *)GET:(NSString*)URLString
      parameters:(id)parameters
    onCompletion:(void (^)(id responseData, NSError* error))completionBlock
{
    id AFHttpClient = ((CURRENT_SYS_VERSION_FLOAT < 7.0)?mAFHTTPClientForiOS6OrLower(URLString):mAFHTTPClient(URLString));
    return [APIOperation GET:AFHttpClient url:URLString parameters:parameters onCompletion:completionBlock];
}


+ (void)POST:(NSString*)URLString
  parameters:(id)parameters
onCompletion:(void (^)(id responseData, NSError* error))completionBlock{
    id paramDic = [APIOperation handleReqPacket:parameters withURL:URLString];
    NSString *decryptToken;
    if (paramDic[CKeyTempClearToken]) {
        decryptToken = paramDic[CKeyTempClearToken];
        [paramDic removeObjectForKey:CKeyTempClearToken];
    }
    id AFHttpClient = ((CURRENT_SYS_VERSION_FLOAT < 7.0)?mAFHTTPClientForiOS6OrLower(URLString):mAFHTTPClient(URLString));
     [AFHttpClient POST:URLString parameters:paramDic success:^(id operation, id responseObject) {
         [APIOperation doNetworkSuccess:operation withDecryptToken:decryptToken withResponseObject:responseObject url:URLString onCompletion:completionBlock];
     } failure:^(id operation, NSError* error) {
         [APIOperation doNetworkFail:operation withDecryptToken:decryptToken withError:error url:URLString  onCompletion:completionBlock];
     }];
}

+ (void)doNetworkFail: (id)operation
        withDecryptToken: (NSString *)decryptToken
        withError:(NSError *)error
        url: (NSString*)URLString
        onCompletion:(void (^)(id responseData, NSError* error))completionBlock {
    if (![mAppUtils hasConnectivity]) {
        // [mAppUtils showHint:kNetWorkUnReachableDesc];
        if (completionBlock) {
            @try {
                completionBlock(nil,error);
            }
            @catch (NSException *exception) {
                DLog(@"%@", exception);
                [mAppUtils showHint:[NSString stringWithFormat:@"%@[001]", CNetworkFail]];
            }
        }
        return ;
    }
    RESTError *restError = [[RESTError alloc] initWithDomain:kRequestErrorDomain  code:[error code] userInfo:[NSDictionary dictionaryWithObjectsAndKeys:CNetworkFail, ERRORMSG,[NSString stringWithFormat:@"%ld",(long)[error code]],ERRORCODE , nil]];
    
    if (completionBlock) {
        @try {
            completionBlock(nil, restError);
        }
        @catch (NSException *exception) {
            DLog(@"%@", exception);
            [mAppUtils showHint:[NSString stringWithFormat:@"%@[001]", CNetworkFail]];
        }
    }
}

+ (void)doNetworkSuccess: (id)operation
        withDecryptToken: (NSString *)decryptToken
        withResponseObject:(id)responseObject
        url: (NSString*)URLString
        onCompletion:(void (^)(id responseData, NSError* error))completionBlock {
//    DLog(@"%@", responseObject);
    if ([URLString rangeOfString:@"/online_bsn/"].location != NSNotFound) {
        NSString *code = [responseObject objectForKey:@"returnCode"];
        code = code ? code : [responseObject objectForKey:@"code"];
        NSString *returnMsg = [responseObject objectForKey:@"returnMsg"];
        returnMsg = returnMsg ? returnMsg : [responseObject objectForKey:@"error"];
        
        RESTError *restError = nil;
        NSDictionary *dataDict = [APIOperation decryptPacket:URLString res:[responseObject objectForKey:@"body"] withToken:decryptToken];
        if (![@"00000000" isEqualToString:code]) {
            restError = [[RESTError alloc] initWithDomain:kBusinessErrorDomain code:0 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:returnMsg, ERRORMSG,code, ERRORCODE, nil]];
            //登录失效
//            if ([GW_TOKEN_EXPIRE_ERROR_MESSAGE isEqualToString:returnMsg]) {
//                UIViewController *topVC = [mAppDelegate findTopViewController];
//                if (topVC) {
//                    [topVC hideHud];
//                }
//                [mAppDelegate tokenErrorAlert:@"AS105"];
//                return;
//            }
        }
        if (completionBlock) {
            @try {
                completionBlock(dataDict, restError);
            }
            @catch (NSException *exception) {
                DLog(@"%@", exception);
                [mAppUtils showHint:[NSString stringWithFormat:@"%@[001]", CNetworkFail]];
            }
        }
    } else {
        NSString *code = [responseObject objectForKey:@"code"];
        NSDictionary *dataDict = [APIOperation decryptPacket:URLString res:[responseObject objectForKey:@"data"] withToken:decryptToken];
        RESTError *restError = nil;
        //业务逻辑错误
        if(![@"0" isEqualToString:[code uppercaseString]]) {
            NSString *codeUpper = [code uppercaseString];
            NSString *errorMsg = [responseObject objectForKey:@"error"];
            DLog(@"error code = %@，responseObject = %@",code,errorMsg);
            restError = [[RESTError alloc] initWithDomain:kBusinessErrorDomain code:0 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:errorMsg, ERRORMSG,code, ERRORCODE, nil]];
            //登录失效
            if ([@"AS105" isEqualToString:codeUpper] ||
                [@"AS108" isEqualToString:codeUpper] ||
                [GW_TOKEN_EXPIRE_ERROR_MESSAGE isEqualToString:errorMsg]) {
//                if (![HAppUserCheckLogout isEqualToString:URLString]) {
//                    UIViewController *topVC = [mAppDelegate findTopViewController];
//                    if (topVC) {
//                        [topVC hideHud];
//                    }
//                    [mAppDelegate tokenErrorAlert:@"AS105"];
//                    return;
//                }
            }
        }
        if (completionBlock) {
            @try {
                completionBlock(dataDict,restError);
            }
            @catch (NSException *exception) {
                DLog(@"%@", exception);
                [mAppUtils showHint:[NSString stringWithFormat:@"%@[001]", CNetworkFail]];
            }
        }
    }
}

//+ (void)POST:(NSString*)URLString
//      parameters:(id)parameters
//    onCompletion:(void (^)(id responseData, NSError* error))completionBlock
//{
//
//    id paramDic = [APIOperation handleReqPacket:parameters withURL:URLString];
//    NSString *decryptToken;
//    if (paramDic[CKeyTempClearToken]) {
//        decryptToken = paramDic[CKeyTempClearToken];
//        [paramDic removeObjectForKey:CKeyTempClearToken];
//    }
//    
//    id AFHttpClient = ((CURRENT_SYS_VERSION_FLOAT < 7.0)?mAFHTTPClientForiOS6OrLower(URLString):mAFHTTPClient(URLString));
//    [AFHttpClient POST:URLString parameters:paramDic success:^(id operation, id responseObject) {
//        
//        NSString *code = [responseObject objectForKey:@"code"];
//        NSDictionary *dataDict=[responseObject objectForKey:@"data"];
//        RESTError *restError = nil;
//        //业务逻辑错误
//        if(![[code uppercaseString] isEqualToString:@"0"])
//        {
//             DLog(@"error code = %@，responseObject = %@",code,responseObject);
//#if defined (CONFIGURATION_DEBUG)
//            restError = [[RESTError alloc] initWithDomain:kBusinessErrorDomain
//                                                     code:0
//                                                 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@,%@",URLString,[responseObject objectForKey:@"error"]], ERRORMSG,[responseObject objectForKey:@"code"], ERRORCODE, nil]];
//#else
//            restError = [[RESTError alloc] initWithDomain:kBusinessErrorDomain
//                                                     code:0
//                                                 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[responseObject objectForKey:@"error"], ERRORMSG,[responseObject objectForKey:@"code"], ERRORCODE, nil]];
//#endif
//        }
//        if (completionBlock) {
//            completionBlock(dataDict,restError);
//        }
//    } failure:^(id operation, NSError* error) {
//        if (![mAppUtils hasConnectivity]) {
//            [mAppUtils showHint:kNetWorkUnReachableDesc];
//            if (completionBlock) {
//                completionBlock(nil,error);
//            }
//            return ;
//        }
//#if defined (CONFIGURATION_DEBUG)
//        RESTError *restError = [[RESTError alloc] initWithDomain:kRequestErrorDomain
//                                                            code:[error code]
//                                                        userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                                  [NSString stringWithFormat:@"%@,%@",URLString,CNetworkFail], ERRORMSG,
//                                                                  [NSString stringWithFormat:@"%ld",(long)[error code]],ERRORCODE , nil]];
//#else
//        RESTError *restError = [[RESTError alloc] initWithDomain:kRequestErrorDomain
//                                                            code:[error code]
//                                                        userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                                  CNetworkFail, ERRORMSG,
//                                                                  [NSString stringWithFormat:@"%ld",(long)[error code]],ERRORCODE , nil]];
//#endif
//        if (completionBlock) {
//            completionBlock (nil,restError);
//        }
//    }];
//}

//上传文件\图片
+(void)uploadMedia:(NSString*)URLString parameters:(id)parameters
      onCompletion:(void (^)(id responseData, NSError* error))completionBlock {
    
    NSData *fileData = UIImageJPEGRepresentation([parameters objectForKey:@"file"], 0.5);
    id AFHttpClient = ((CURRENT_SYS_VERSION_FLOAT < 7.0)?mAFHTTPClientForiOS6OrLower(URLString):mAFHTTPClient(URLString));
    [AFHttpClient POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:fileData
                                    name:@"file"
                                fileName:@"picture.jpg"
                                mimeType:@"image/jpeg"];
        
    } success:^(id operation, id responseObject) {
        
        NSString *code = [responseObject objectForKey:@"code"];
        NSDictionary *dataDict=[responseObject objectForKey:@"data"];
        RESTError *restError = nil;
        //业务逻辑错误
        if(![[code uppercaseString] isEqualToString:@"0"])
        {
            DLog(@"error code = %@，responseObject = %@",code,responseObject);
            restError = [[RESTError alloc] initWithDomain:kBusinessErrorDomain
                                                     code:0
                                                 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[responseObject objectForKey:@"error"], ERRORMSG,[responseObject objectForKey:@"code"], ERRORCODE, nil]];
        }
        if (completionBlock) {
            completionBlock(dataDict,restError);
        }
        
    } failure:^(id operation, NSError *error) {
        if (![mAppUtils hasConnectivity]) {
            [mAppUtils showHint:kNetWorkUnReachableDesc];
            if (completionBlock) {
                completionBlock(nil,error);
            }
            return ;
        }
        RESTError *restError = [[RESTError alloc] initWithDomain:kRequestErrorDomain
                                                            code:[error code]
                                                        userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                  CNetworkFail, ERRORMSG,
                                                                  [NSString stringWithFormat:@"%ld",(long)[error code]],ERRORCODE , nil]];
        if (completionBlock) {
            completionBlock (nil,restError);
        }
        
    }];
    
}


+(void)uploadMutipleMedia:(NSString*)URLString parameters:(id)parameters
      onCompletion:(void (^)(id responseData, NSError* error))completionBlock {
    
    NSMutableArray *mediaArray = [NSMutableArray new];
    NSMutableDictionary *params = [NSMutableDictionary new];
    for (int i =0 ;i<[parameters allKeys].count;i++) {
        id key =[[parameters allKeys] objectAtIndex:i];
        id value = [[parameters allValues] objectAtIndex:i];
        
        if ([value isKindOfClass:[NSData class]]) {
            NSMutableDictionary *dict = [NSMutableDictionary new];
            [dict setValue:key  forKey:@"name"];
            [dict setValue:value  forKey:@"data"];
            [mediaArray addObject:dict];
        }else{
            [params setObject:value forKey:key];
        }
    }
    //NSDictionary *parametersDict = parameters;
   //  = @{@"userId":[parametersDict valueForKey:@"userId"] ,
                      //       @"tasks":[parametersDict valueForKey:@"tasks"]
                          //   };
    //NSData *fileData = UIImageJPEGRepresentation([parameters objectForKey:@"file"], 0.5);
    id AFHttpClient = ((CURRENT_SYS_VERSION_FLOAT < 7.0)?mAFHTTPClientForiOS6OrLower(URLString):mAFHTTPClient(URLString));
    [AFHttpClient POST:URLString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (NSDictionary *dict in mediaArray) {
            [formData appendPartWithFileData:[dict objectForKey:@"data"]
                                        name:[dict objectForKey:@"name"]
                                    fileName:@"picture.jpg"
                                    mimeType:@"image/jpeg"];
        }
       
        
    } success:^(id operation, id responseObject) {
        
        NSString *code = [responseObject objectForKey:@"code"];
        NSDictionary *dataDict=[responseObject objectForKey:@"data"];
        RESTError *restError = nil;
        //业务逻辑错误
        if(![[code uppercaseString] isEqualToString:@"0"])
        {
            
            restError = [[RESTError alloc] initWithDomain:kBusinessErrorDomain
                                                     code:0
                                                 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[responseObject objectForKey:@"error"], ERRORMSG,[responseObject objectForKey:@"code"], ERRORCODE, nil]];
        }
        if (completionBlock) {
            completionBlock(dataDict,restError);
        }
        
    } failure:^(id operation, NSError *error) {
        if (![mAppUtils hasConnectivity]) {
            [mAppUtils showHint:kNetWorkUnReachableDesc];
            if (completionBlock) {
                completionBlock(nil,error);
            }
            return ;
        }
        RESTError *restError = [[RESTError alloc] initWithDomain:kRequestErrorDomain
                                                            code:[error code]
                                                        userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                  CNetworkFail, ERRORMSG,
                                                                  [NSString stringWithFormat:@"%ld",(long)[error code]],ERRORCODE , nil]];
        if (completionBlock) {
            completionBlock (nil,restError);
        }
        
    }];
    
}

+ (void)SEARCHGET:(NSInteger)indexForNum url:(NSString*)URLString
 parameters:(id)parameters
onCompletion:(void (^)(id responseData, NSError* error,NSInteger indexNum))completionBlock
{
    
    id AFHttpClient = ((CURRENT_SYS_VERSION_FLOAT < 7.0)?mAFHTTPClientForiOS6OrLower(URLString):mAFHTTPClient(URLString));
    [AFHttpClient GET:URLString parameters:parameters success:^(id operation, id responseObject) {
        
        NSString *code = [responseObject objectForKey:@"code"];
        NSDictionary *dataDict=[responseObject objectForKey:@"data"];
        RESTError *restError = nil;
        //业务逻辑错误
        if(![[code uppercaseString] isEqualToString:@"0"])
        {
#if defined (CONFIGURATION_DEBUG)
            restError = [[RESTError alloc] initWithDomain:kBusinessErrorDomain
                                                     code:0
                                                 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@,%@",URLString,[responseObject objectForKey:@"error"]], ERRORMSG,[responseObject objectForKey:@"code"], ERRORCODE, nil]];
#else
            restError = [[RESTError alloc] initWithDomain:kBusinessErrorDomain
                                                     code:0
                                                 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[responseObject objectForKey:@"error"], ERRORMSG,[responseObject objectForKey:@"code"], ERRORCODE, nil]];
#endif
            
        }
        if (completionBlock) {
            completionBlock(dataDict,restError,indexForNum);
        }
    } failure:^(id operation, NSError* error) {
        
        if (![mAppUtils hasConnectivity]) {
            [mAppUtils showHint:kNetWorkUnReachableDesc];
            if (completionBlock) {
                completionBlock(nil,error,indexForNum);
            }
            return ;
        }
#if defined (CONFIGURATION_DEBUG)
        RESTError *restError = [[RESTError alloc] initWithDomain:kRequestErrorDomain
                                                            code:[error code]
                                                        userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                  [NSString stringWithFormat:@"%@,%@",URLString,CNetworkFail], ERRORMSG,
                                                                  [NSString stringWithFormat:@"%ld",(long)[error code]],ERRORCODE , nil]];
#else
        RESTError *restError = [[RESTError alloc] initWithDomain:kRequestErrorDomain
                                                            code:[error code]
                                                        userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                  CNetworkFail, ERRORMSG,
                                                                  [NSString stringWithFormat:@"%ld",(long)[error code]],ERRORCODE , nil]];
#endif
        if (completionBlock) {
            completionBlock (nil,restError,indexForNum);
        }
    }];
}

@end
