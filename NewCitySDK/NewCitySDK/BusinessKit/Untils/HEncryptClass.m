//
//  HEncryptClass.m
//  SmartCommunity
//
//  Created by HY on 14/10/29.
//  Copyright (c) 2014年 shenghuo. All rights reserved.
//

#import "HEncryptClass.h"
#import "3Des.h"
#import "SystemConfigUtil.h"
#import "OpenUDID.h"
#import "MacroDefine.h"
#import "HCommunityModeClass.h"
#import "LocalCache.h"
#import "NSString+Addition.h"
#import "OpenSSLRSAWrapper.h"
#import "APIOperation.h"
#import "NetworkAPI.h"
@interface HEncryptClass ()
@property (nonatomic, strong) NSString *udid;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *enToken;
@property (nonatomic, strong) NSString *DESKey;
@property (nonatomic, strong) NSString *DESIV;
@property (nonatomic, strong) NSString *DESTokenKey;
@property (nonatomic, strong) NSString *DESTokenIV;
@end

@implementation HEncryptClass

+ (id)sharedHEncryptClassInstance{
    static HEncryptClass *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init{
    if (self = [super init]) {
        [self commonAttributeInit];
    }
    
    return self;
}

- (void)commonAttributeInit{
    self.udid = [mSystemConfigUtil getServerUDID];
    self.uid = [mUserDefaults objectForKey:HCurrentUid];
    self.token = [mUserDefaults objectForKey:HCurrentToken];
    self.DESKey = [SystemConfigUtil calculateDefaultDESKEY];
    self.DESIV = [SystemConfigUtil calculateDefaultDESIV];
    
    self.enToken = [[OpenSSLRSAWrapper shareInstance] decryptRSAKeyWithType:KeyTypePublic data:self.token];
    self.DESTokenKey = [SystemConfigUtil calculateDESKEYWithToken:self.enToken];
    self.DESTokenIV = [SystemConfigUtil calculateDESIVWithToken:self.enToken];
}

- (void)encryptAccountWithUdid:(NSArray *)paraArray dicKeyArray:(NSArray *)keyArray onCompletion:(void (^)(NSDictionary *dic))completionBlock{
    
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
//    [paraDic setObject:[mSystemConfigUtil getServerUDID] forKey:@"udid"];
    
    [paraDic setObject:@"upbtsusTnKw=" forKey:@"udid"];

    //    NSString *enToken = [SystemConfigUtil getDecryptToken];
    //    NSString *descKey = [SystemConfigUtil calculateDESKEYWithToken:enToken];
    //    NSString *ivkey = [SystemConfigUtil calculateDESIVWithToken:enToken];
    for (int i =0; i < paraArray.count; i++) {
        //        [paraDic setObject:[_Des TripleDES:paraArray[i]
        //                          encryptOrDecrypt:kCCEncrypt
        //                                       key:descKey
        //                                     andIV:ivkey] forKey:keyArray[i]];
        
        [paraDic setObject:paraArray[i] forKey:keyArray[i]];
    }
    completionBlock(paraDic);
};
- (void)encryptAccountWithNotUdid:(NSArray *)paraArray dicKeyArray:(NSArray *)keyArray onCompletion:(void (^)(NSDictionary *dic))completionBlock{
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    //    NSString *enToken = [SystemConfigUtil getDecryptToken];
    //    NSString *descKey = [SystemConfigUtil calculateDESKEYWithToken:enToken];
    //    NSString *ivkey = [SystemConfigUtil calculateDESIVWithToken:enToken];
    for (int i =0; i <paraArray.count; i++) {
        //        NSString *string = [_Des TripleDES:paraArray[i]
        //                          encryptOrDecrypt:kCCEncrypt
        //                                       key:descKey
        //                                     andIV:ivkey];
        //        [paraDic setObject:string forKey:keyArray[i]];
        [paraDic setObject:paraArray[i] forKey:keyArray[i]];
    }
    completionBlock(paraDic);
}

-(void)encryptAppInitParameter:(void (^)(NSMutableDictionary *dic))completionBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[_Des TripleDES:[SystemConfigUtil getDeviceType] encryptOrDecrypt:kCCEncrypt key:[SystemConfigUtil calculateDefaultDESKEY] andIV:[SystemConfigUtil calculateDefaultDESIV]] forKey:@"device_type"];
    [parameters setObject:[_Des TripleDES:[OpenUDID value] encryptOrDecrypt:kCCEncrypt key:[SystemConfigUtil calculateDefaultDESKEY] andIV:[SystemConfigUtil calculateDefaultDESIV]] forKey:@"device_id"];
    
    NSString *macAddress=[SystemConfigUtil getMacAddress];
    if (![macAddress isEqualToString:@"020000000000"]) {
        [parameters setObject:[_Des TripleDES:[SystemConfigUtil getMacAddress] encryptOrDecrypt:kCCEncrypt key:[SystemConfigUtil calculateDefaultDESKEY] andIV:[SystemConfigUtil calculateDefaultDESIV]] forKey:@"mac"];
    }else{
        [parameters setObject:[_Des TripleDES:@" " encryptOrDecrypt:kCCEncrypt key:[SystemConfigUtil calculateDefaultDESKEY] andIV:[SystemConfigUtil calculateDefaultDESIV]] forKey:@"mac"];
    }
    
    [parameters setObject:[_Des TripleDES:@" " encryptOrDecrypt:kCCEncrypt key:[SystemConfigUtil calculateDefaultDESKEY] andIV:[SystemConfigUtil calculateDefaultDESIV]] forKey:@"imei"];
    
    [parameters setObject:[_Des TripleDES:[NSString stringWithFormat:@"iOS_%@",CURRENT_SYS_VERSION] encryptOrDecrypt:kCCEncrypt key:[SystemConfigUtil calculateDefaultDESKEY] andIV:[SystemConfigUtil calculateDefaultDESIV]] forKey:@"os"];
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [parameters setObject:[_Des TripleDES:appVersion encryptOrDecrypt:kCCEncrypt key:[SystemConfigUtil calculateDefaultDESKEY] andIV:[SystemConfigUtil calculateDefaultDESIV]] forKey:@"app_version"];
    completionBlock(parameters);
}
@end

