//
//  SystemConfigUtil.h
//  smartcity
//
//  Created by wanghuafeng on 14-1-26.
//  Copyright (c) 2014年 Giant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemConfigUtil : NSObject

+ (id)sharedSystemConfigUtil;

// Server udid
- (void)setServerUDID:(NSString *)udid;
- (NSString *)getServerUDID;

//RSA public key
- (void)setRSAPublicKey:(NSString *)key;
- (NSString *)getRSAPublicKey;

//Device Token
- (void)setDeviceToken:(NSString *)deviceToken;
- (NSString *)getDeviceToken;

//Phone Number
- (void)setPhoneNumber:(NSString *)phone;
- (NSString *)getPhoneNumber;
-(NSString *)getMaskedPhoneNumber;

//Gesture Sequence number
- (void)setGestureSequence:(NSString *)gesture;
- (NSString *)getGestureSequence;

//SetPayPwd
- (void)setPayPwdStatus:(BOOL)hasSet;
- (BOOL)getPayPwdStatus;

////ActiveStatus
//- (void)setNeedActive:(BOOL)need;
//- (BOOL)getNeedActive;
//
////ActiveStatus
//- (void)setActiveStatus:(BOOL)status;
//- (BOOL)getActiveStatus;

+ (NSString *)getDeviceType;
+ (NSString *)getMacAddress;
+ (NSString *)getResolution;
+ (NSString *)getCarrierName;
+ (NSString *)getNetWorkType;
//获取硬件uuid
- (NSString*) uuidString;

+ (NSString *)urlEncodedString:(NSData *)src;

+ (NSString *)calculateDefaultDESKEY;
+ (NSString *)calculateDefaultDESIV;

+ (NSString *)calculateDESKEYWithToken:(NSString *)token;
+ (NSString *)calculateDESIVWithToken:(NSString *)token;

//获取解密后的token
+(NSString*)getDecryptToken;
+(NSString*)getDecryptImToken;

+ (NSString *)calculateDESKEYWithToken;
+ (NSString *)calculateDESIVWithToken;


//-(NSString *) loginLogWithPreUrl:(NSString *)preURL   currentURL:(NSString *)currentURL;
//-(NSString *) signUpLogWithPreUrl:(NSString *)preURL   currentURL:(NSString *)currentURL;
-(NSString *) urlTrackLogWithPreUrl:(NSString *)preURL   currentURL:(NSString *)currentURL;

//获取UserInfoModel
//-(UserInfoModal *) getUserInfoModel;
//获取showAccout
-(NSString *)getShowAccout;
//获取用户帐户对应的手势密码的key
-(NSString *) getGestureSwitchStateKeyString;

/**
 *  token 解密返回的参数
 */
+ (NSString *)tokenDecrptContent:(NSString *)encryptStr;
@end
