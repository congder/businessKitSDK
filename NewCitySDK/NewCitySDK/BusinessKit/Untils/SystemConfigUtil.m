//
//  SystemConfigUtil.m
//  smartcity
//
//  Created by wanghuafeng on 14-1-26.
//  Copyright (c) 2014年 Giant. All rights reserved.
//

#import "SystemConfigUtil.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "Reachability.h"
#import "LocalCache.h"
#import "NSString+MD5Addition.h"
#import "OpenSSLRSAWrapper.h"
#import "OpenUDID.h"
#import "NetworkAPI.h"
#import "MacroDefine.h"
#import "3Des.h"

@implementation SystemConfigUtil

+ (id)sharedSystemConfigUtil
{
    static SystemConfigUtil *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

//服务器端返回的UDID
- (void)setServerUDID:(NSString *)udid
{
    [[NSUserDefaults standardUserDefaults] setObject:udid forKey:HCurrentUDID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)getServerUDID
{
    NSString *udid = [[NSUserDefaults standardUserDefaults] objectForKey:HCurrentUDID];
    if (udid == nil) {
        udid = @"";
    }
    return udid;
}

//RSA的公钥
- (void)setRSAPublicKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:key forKey:RSA_PUBLICK_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)getRSAPublicKey
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:RSA_PUBLICK_KEY];
}

//Device Token
//- (void)setDeviceToken:(NSString *)deviceToken
//{
//    [[NSUserDefaults standardUserDefaults] setObject:deviceToken forKey:DEVICE_TOKEN];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//- (NSString *)getDeviceToken
//{
//    return [[NSUserDefaults standardUserDefaults] objectForKey:DEVICE_TOKEN];
//}

//Phone Number
- (void)setPhoneNumber:(NSString *)phone
{
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:PHONE_NUMBER];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)getPhoneNumber
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:PHONE_NUMBER];
}
//获取带有＊号掩码的电话号码
-(NSString *)getMaskedPhoneNumber{
    NSString *phoneNumber=[[NSUserDefaults standardUserDefaults] objectForKey:PHONE_NUMBER];
    NSRange range=NSMakeRange(3, 4);
    phoneNumber=[phoneNumber stringByReplacingCharactersInRange:range withString:@"****"];
    return phoneNumber;
}

//Gesture Sequence number
//- (void)setGestureSequence:(NSString *)gesture
//{
//    UserInfoModal  *userInfo = [[LocalCache sharedCache] cachedObjectForKey:@"userInfo"];
//    NSString *gestureKey=[NSString stringWithFormat:@"%@%@",userInfo.showAccount,GESTURE_CODE];
//    if (gesture.length > 0) {
//        [[LocalCache sharedCache] storeObject:gesture forKey:gestureKey block:^(LocalCache *cache, NSString *key) {
//            
//        }];
//    } else {
//        [[LocalCache sharedCache] removeCacheDataForKey:gestureKey];
//    }
//}
//
//- (NSString *)getGestureSequence
//{
//    UserInfoModal  *userInfo = [[LocalCache sharedCache] cachedObjectForKey:@"userInfo"];
//    NSString *gestureKey=[NSString stringWithFormat:@"%@%@",userInfo.showAccount,GESTURE_CODE];
//    return [[LocalCache sharedCache] cachedObjectForKey:gestureKey];
//}

//SetPayPwd
- (void)setPayPwdStatus:(BOOL)hasSet
{
    [[LocalCache sharedCache] storeObject:[NSNumber numberWithBool:hasSet] forKey:PAY_PWD_STATUS block:^(LocalCache *cache, NSString *key) {
    }];
}

- (BOOL)getPayPwdStatus
{
    return ((NSString *)[[LocalCache sharedCache] cachedObjectForKey:PAY_PWD_STATUS]).boolValue;
}

////ActiveStatus
//- (void)setNeedActive:(BOOL)need
//{
//    [[TMCache sharedCache] setObject:[NSNumber numberWithBool:need] forKey:NEED_ACTIVE_FLAG];
//}
//
//- (BOOL)getNeedActive
//{
//    return ((NSString *)[[TMCache sharedCache] objectForKey:NEED_ACTIVE_FLAG]).boolValue;
//}
//
////ActiveStatus
//- (void)setActiveStatus:(BOOL)status
//{
//    [[TMCache sharedCache] setObject:[NSNumber numberWithBool:status] forKey:USER_ACTIVE_STATUS];
//}
//
//- (BOOL)getActiveStatus
//{
//    return ((NSString *)[[TMCache sharedCache] objectForKey:USER_ACTIVE_STATUS]).boolValue;
//}

#pragma mark - Device
//获取设备类型
+ (NSString*)getDeviceType
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *model = (char*)malloc(size);
    sysctlbyname("hw.machine", model, &size, NULL, 0);
    NSString *sDeviceModel = [NSString stringWithCString:model encoding:NSUTF8StringEncoding];
    free(model);
    return sDeviceModel;
}


//获取硬件uuid
- (NSString*) uuidString
{
	NSString *ident = [[NSUserDefaults standardUserDefaults] objectForKey:@"unique identifier stored for app"];
    if (!ident) {
        CFUUIDRef uuidRef = CFUUIDCreate(NULL);
        CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
        CFRelease(uuidRef);
        ident = [NSString stringWithString:(__bridge NSString *)uuidStringRef];
        CFRelease(uuidStringRef);
        [[NSUserDefaults standardUserDefaults] setObject:ident forKey:@"unique identifier stored for app"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return ident;
}




//Mac地址
+ (NSString*)getMacAddress
{
    int                    mib[6];
    size_t                len;
    char                *buf;
    unsigned char        *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl    *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = (char*)malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    NSString *macAddress = [outstring uppercaseString];
    if (macAddress == nil || [macAddress isEqualToString:@"020000000000"])
    {
        
        macAddress=@"020000000000";
//        NSString *uuidString = [mSystemConfigUtil uuidString ];
//        if (uuidString)
//        {
//            macAddress = [uuidString substringWithRange:NSMakeRange(0, 12)];
//        }
//        else
//        {
//            macAddress = [[NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]] substringWithRange:NSMakeRange(0, 12)];
//        }
        
    }
    return macAddress;
}

// 屏幕分辨率
//+ (NSString *)getResolution
//{
//    float scaleFactor = [[UIScreen mainScreen] scale];
//    CGRect screen = [[UIScreen mainScreen] bounds];
//    CGFloat widthInPixel = screen.size.width * scaleFactor;
//    CGFloat heightInPixel = screen.size.height * scaleFactor;
//    return [NSString stringWithFormat:@"%.0fx%.0f", widthInPixel, heightInPixel];
//}

//运营商
+(NSString*)getCarrierName
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = info.subscriberCellularProvider;
    NSString *temName = [NSString stringWithFormat:@"%@",[carrier carrierName]];
    return temName;
}

//当前连网方式
+ (NSString*)getNetWorkType
{
    Reachability *r = [Reachability reachabilityForInternetConnection];
    NSString *typeStr = nil ;
    switch ([r currentReachabilityStatus])
    {
        case NotReachable:
            // 没有网络连接
            typeStr = @"";
            break;
        case ReachableViaWWAN:
            // 使用3G网络
            typeStr = @"3G";
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            typeStr = @"WiFi";
            break;
    }
    return typeStr;
} 

+ (NSString *)urlEncodedString:(NSData *)src
{
    NSString *sourceString = [[NSString alloc] initWithData:src encoding:NSUTF8StringEncoding];
    
    CFStringRef s = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                            (CFStringRef)sourceString,
                                                            NULL,
                                                            CFSTR("!*'();:@&=+$,/?%#[]"),
                                                            kCFStringEncodingUTF8);
    NSString *resultString =[NSString stringWithFormat:@"%@", s];
    CFRelease(s);
    return resultString;
}

+ (NSString *)calculateDefaultDESKEY
{
    NSString *serverDESKEY = HServerDESKEY;
    NSString *updateServerDESKEY = [serverDESKEY stringByAppendingString:serverDESKEY];
    NSString *result = [[[updateServerDESKEY stringFromMD5] substringToIndex:24] lowercaseString];
//    DLog(@"%@",result);
    return result;
}

+ (NSString *)calculateDefaultDESIV
{
    NSString *serverDESKEY = HServerDESKEY;
    NSString *updateServerDESKEY = [serverDESKEY stringByAppendingString:serverDESKEY];
    NSString *result = [[[updateServerDESKEY stringFromMD5] substringToIndex:8] lowercaseString];
//    DLog(@"%@",result);
    return result;
}

+ (NSString *)calculateDESKEYWithToken:(NSString *)token
{
    if (token == nil) {
        token = [mUserDefaults objectForKey:HCurrentToken];
    }
//    NSString *enToken = [[OpenSSLRSAWrapper shareInstance] decryptRSAKeyWithType:KeyTypePublic data:token];
    NSString *updateToken = [token stringByAppendingString:token];
    NSString *result = [[[updateToken stringFromMD5] substringToIndex:24] lowercaseString];
    return result;
}

+ (NSString *)calculateDESIVWithToken:(NSString *)token
{
    if (token == nil) {
         token =[mUserDefaults objectForKey:HCurrentToken];
    }
//    NSString *enToken = [[OpenSSLRSAWrapper shareInstance] decryptRSAKeyWithType:KeyTypePublic data:token];
    NSString *updateToken = [token stringByAppendingString:token];
    NSString *result = [[[updateToken stringFromMD5] substringToIndex:8] lowercaseString];
    return result;
}

+(NSString*)getDecryptToken{
    NSString *currentToken = [mUserDefaults objectForKey:HCurrentToken];
    NSString *enToken = [[OpenSSLRSAWrapper shareInstance] decryptRSAKeyWithType:KeyTypePublic data:currentToken];
    return enToken;
}

+(NSString*)getDecryptImToken{
    NSString *currentToken = [mUserDefaults objectForKey:HCurrentImToken];
    NSString *enToken = [[OpenSSLRSAWrapper shareInstance] decryptRSAKeyWithType:KeyTypePublic data:currentToken];
    return enToken;
}

//+ (NSString *)calculateDESKEYWithToken{
//    
//    UserInfoModal *userInfo = [[LocalCache sharedCache] cachedObjectForKey:@"userInfo"];
//    NSString *token=userInfo.token;
//    NSString *updateToken = [token stringByAppendingString:token];
//    NSString *result = [[[updateToken stringFromMD5] substringToIndex:24] lowercaseString];
//    return result;
//}
//
//+ (NSString *)calculateDESIVWithToken
//{
//    UserInfoModal *userInfo = [[LocalCache sharedCache] cachedObjectForKey:@"userInfo"];
//    NSString * token=userInfo.token;
//    NSString *updateToken = [token stringByAppendingString:token];
//    NSString *result = [[[updateToken stringFromMD5] substringToIndex:8] lowercaseString];
//    return result;
//}
//
//
//-(NSString *) loginLogWithPreUrl:(NSString *)preURL   currentURL:(NSString *)currentURL{
//    NSMutableString *logString=[NSMutableString new];
//    NSDateFormatter *dateFormatter=[self logFileDateFormatter];
//    NSString *formattedDate = [dateFormatter stringFromDate:[NSDate date]];
//    
//    UserInfoModal *userInfo = [[LocalCache sharedCache] cachedObjectForKey:@"userInfo"];
//    
//    [logString appendString:@"app"];
//    [logString appendString:@"\t"];
//    
//    [logString appendString:formattedDate];
//    [logString appendString:@"\t"];
//    [logString appendString:@"VLOG"];
//    [logString appendString:@"\t"];
//    [logString appendString:@"APPTraceServer"];
//    [logString appendString:@"\t"];
//    [logString appendString:@"\t"];
//    [logString appendString:@"acclogin_app"];
//    [logString appendString:@"\t"];
//    [logString appendString:@"info"];
//    [logString appendString:@"\t"];
//    [logString appendString: userInfo.uid];
//    [logString appendString:@"\t"];
//    [logString appendString:userInfo.showAccount];
//    [logString appendString:@"\t"];
//    NSString *ipAddress=[[LocalCache sharedCache] cachedObjectForKey:@"ip"];
//    if (ipAddress==Nil) {
//        [logString appendString:@""];
//    }else{
//        [logString appendString:ipAddress];
//    }
//    [logString appendString:@"\t"];
//    [logString appendString:@"\t"];
//    NSString *macAddress=[SystemConfigUtil getMacAddress];
//    if (![macAddress isEqualToString:@"020000000000"]) {
//        [logString appendString:macAddress];
//    }
//    [logString appendString:@"\t"];
//    //硬件udid
//    if ([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
//        // This will run if it is iOS6 or higher
//        ;
//        [logString appendString:[[[UIDevice currentDevice] identifierForVendor] UUIDString]];
//    }
//    [logString appendString:@"\t"];
//    
//    //硬件uuid
//    if ([mSystemConfigUtil uuidString ]&&[[mSystemConfigUtil uuidString ] length]>0) {
//        [logString appendString:[mSystemConfigUtil uuidString ]];
//    }
//    [logString appendString:@"\t"];
//    
//    
//    //openudid
//    if ([OpenUDID value]&&[[OpenUDID value] length]>0) {
//        [logString appendString:[OpenUDID value]];
//    }
//    [logString appendString:@"\t"];
//    //硬件id5,id6留空
//    [logString appendString:@"\t"];
//    [logString appendString:@"\t"];
//    
//    [logString appendString:[SystemConfigUtil getDeviceType]];
//    [logString appendString:@"\t"];
//    [logString appendString:[NSString stringWithFormat:@"iOS_%@",[UIDevice currentDevice].systemVersion]];
//    [logString appendString:@"\t"];
//    [logString appendString: [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
//    [logString appendString:@"\t"];
//    //操作系统内核版本(置空)
//    [logString appendString:@"\t"];
//    
//    [logString appendString:[SystemConfigUtil getResolution]];
//    [logString appendString:@"\t"];
//    [logString appendString:@"0"];
//    [logString appendString:@"\t"];
//    [logString appendString: [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"]objectAtIndex:0]];
//    //浏览器插件
//    [logString appendString:@"\t"];
//    [logString appendString:@"\t"];
//    //来源url
//    [logString appendString:preURL];
//    [logString appendString:@"\t"];
//    //当前url
//    [logString appendString:currentURL];
//    [logString appendString:@"\t"];
//    
//    //广告
//    [logString appendString:@"\t"];
//    [logString appendString:@"\t"];
//    [logString appendString:@"\t"];
//    [logString appendString:@"\t"];
//    
//    //登录时间
//    [logString appendString:formattedDate];
//    [logString appendString:@"\t"];
//    //channel_id
//    [logString appendString:@"4"];
//    
//    //结束的换行符号
//    [logString appendString:@"\n"];
//    
//    return logString;
//}

//-(NSString *)signUpLogWithPreUrl:(NSString *)preURL   currentURL:(NSString *)currentURL{
//    NSMutableString *logString=[NSMutableString new];
//    NSDateFormatter *dateFormatter=[self logFileDateFormatter];
//    NSString *formattedDate = [dateFormatter stringFromDate:[NSDate date]];
//    
//    UserInfoModal *userInfo = [[LocalCache sharedCache] cachedObjectForKey:@"userInfo"];
//    
//    [logString appendString:@"app"];
//    [logString appendString:@"\t"];
//    
//    [logString appendString:formattedDate];
//    [logString appendString:@"\t"];
//    [logString appendString:@"VLOG"];
//    [logString appendString:@"\t"];
//    [logString appendString:@"APPTraceServer"];
//    [logString appendString:@"\t"];
//    [logString appendString:@"\t"];
//    [logString appendString:@"regcard_app"];
//    [logString appendString:@"\t"];
//    [logString appendString:@"info"];
//    [logString appendString:@"\t"];
//    [logString appendString: userInfo.uid];
//    [logString appendString:@"\t"];
//    [logString appendString:userInfo.showAccount];
//    [logString appendString:@"\t"];
//    //新城势卡号留空
//    [logString appendString:@"\t"];
//    //帐号类型
//    //[logString appendString:@"1"];
//    [logString appendString:@"\t"];
//    //商业类型
//    //[logString appendString:@"1"];
//    [logString appendString:@"\t"];
//    //帐号厂商
//    //[logString appendString:@"1"];
//    [logString appendString:@"\t"];
//    //渠道编号
//    //[logString appendString:@"04"];
//    [logString appendString:@"\t"];
//    //帐号名
//    [logString appendString:userInfo.showAccount];
//    [logString appendString:@"\t"];
//    
//    //密码类型
//    //[logString appendString:@"1"];
//    [logString appendString:@"\t"];
//    //绑定的手机号
//    [logString appendString:[mSystemConfigUtil getPhoneNumber]];
//    [logString appendString:@"\t"];
//    //证件
//    [logString appendString:@"\t"];
//    [logString appendString:@"\t"];
//    [logString appendString:@"\t"];
//    //新城势所属地区
//    [logString appendFormat:@"\t"];
//    //ip
//    NSString *ipAddress=[[LocalCache sharedCache] cachedObjectForKey:@"ip"];
//    if (ipAddress==Nil) {
//        [logString appendString:@""];
//    }else{
//        [logString appendString:ipAddress];
//    }
//    [logString appendString:@"\t"];
//    [logString appendString:@"\t"];
//    
//    NSString *macAddress=[SystemConfigUtil getMacAddress];
//    if (![macAddress isEqualToString:@"020000000000"]) {
//        [logString appendString:macAddress];
//    }
//    [logString appendString:@"\t"];
//    //硬件udid
//    if ([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
//        // This will run if it is iOS6 or higher
//        ;
//        [logString appendString:[[[UIDevice currentDevice] identifierForVendor] UUIDString]];
//    }
//    [logString appendString:@"\t"];
//    
//    //硬件uuid
//    if ([mSystemConfigUtil uuidString ]&&[[mSystemConfigUtil uuidString ] length]>0) {
//        [logString appendString:[mSystemConfigUtil uuidString ]];
//    }
//    [logString appendString:@"\t"];
//    //openudid
//    if ([OpenUDID value]&&[[OpenUDID value] length]>0) {
//        [logString appendString:[OpenUDID value]];
//    }
//    [logString appendString:@"\t"];
//    //硬件id5,id6留空
//    [logString appendString:@"\t"];
//    [logString appendString:@"\t"];
//    
//    [logString appendString:[SystemConfigUtil getDeviceType]];
//    [logString appendString:@"\t"];
//    [logString appendString:[NSString stringWithFormat:@"iOS_%@",[UIDevice currentDevice].systemVersion]];
//    [logString appendString:@"\t"];
//    [logString appendString: [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
//    [logString appendString:@"\t"];
//    //操作系统内核版本(置空)
//    [logString appendString:@"\t"];
//    
//    [logString appendString:[SystemConfigUtil getResolution]];
//    [logString appendString:@"\t"];
//    [logString appendString:@"0"];
//    [logString appendString:@"\t"];
//    [logString appendString: [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0]];
//    //浏览器插件
//    [logString appendString:@"\t"];
//    [logString appendString:@"\t"];
//    //来源url
//    [logString appendString:preURL];
//    [logString appendString:@"\t"];
//    //当前url
//    [logString appendString:currentURL];
//    [logString appendString:@"\t"];
//    
//    //广告
//    [logString appendString:@"\t"];
//    [logString appendString:@"\t"];
//    [logString appendString:@"\t"];
//    [logString appendString:@"\t"];
//    //teller id
//    [logString appendString:@"\t"];
//    
//    //登录时间
//    [logString appendString:formattedDate];
//    [logString appendString:@"\t"];
//    //channel_id
//    [logString appendString:@"4"];
//    
//    //结束的换行符号
//    [logString appendString:@"\n"];
//    
//    return logString;
//}
//
//-(NSString *) urlTrackLogWithPreUrl:(NSString *)preURL   currentURL:(NSString *)currentURL{
//    NSMutableString *logString=[NSMutableString new];
//    NSDateFormatter *dateFormatter=[self logFileDateFormatter];
//    NSString *formattedDate = [dateFormatter stringFromDate:[NSDate date]];
//    
//    [logString appendString:@"app"];
//    [logString appendString:@"\t"];
//    
//    [logString appendString:formattedDate];
//    [logString appendString:@"\t"];
//    [logString appendString:@"VLOG"];
//    [logString appendString:@"\t"];
//    [logString appendString:@"APPTraceServer"];
//    [logString appendString:@"\t"];
//    [logString appendString:@"\t"];
//    [logString appendString:@"access_app"];
//    [logString appendString:@"\t"];
//    [logString appendString:@"info"];
//    [logString appendString:@"\t"];
//    NSString *ipAddress=[[LocalCache sharedCache] cachedObjectForKey:@"ip"];
//    if (ipAddress==Nil) {
//        [logString appendString:@""];
//    }else{
//        [logString appendString:ipAddress];
//    }
//    
//    [logString appendString:@"\t"];
//    [logString appendString:@"\t"];
//    NSString *macAddress=[SystemConfigUtil getMacAddress];
//    if (![macAddress isEqualToString:@"020000000000"]) {
//        [logString appendString:macAddress];
//    }
//    [logString appendString:@"\t"];
//    //硬件udid
//    if ([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
//        // This will run if it is iOS6 or higher
//        ;
//        [logString appendString:[[[UIDevice currentDevice] identifierForVendor] UUIDString]];
//    }
//    [logString appendString:@"\t"];
//    
//    //硬件uuid
//    if ([mSystemConfigUtil uuidString ]&&[[mSystemConfigUtil uuidString ] length]>0) {
//        [logString appendString:[mSystemConfigUtil uuidString ]];
//    }
//    [logString appendString:@"\t"];
//    //openudid
//    if ([OpenUDID value]&&[[OpenUDID value] length]>0) {
//        [logString appendString:[OpenUDID value]];
//    }
//    [logString appendString:@"\t"];
//    
//    //硬件id5,id6留空
//    [logString appendString:@"\t"];
//    [logString appendString:@"\t"];
//    
//    [logString appendString:[SystemConfigUtil getDeviceType]];
//    [logString appendString:@"\t"];
//    [logString appendString:[NSString stringWithFormat:@"iOS_%@",[UIDevice currentDevice].systemVersion]];
//    [logString appendString:@"\t"];
//    [logString appendString: [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
//    [logString appendString:@"\t"];
//    //操作系统内核版本(置空)
//    [logString appendString:@"\t"];
//    [logString appendString:[SystemConfigUtil getResolution]];
//    [logString appendString:@"\t"];
//    [logString appendString:@"0"];
//    [logString appendString:@"\t"];
//    [logString appendString: [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0]];
//    //浏览器插件
//    [logString appendString:@"\t"];
//    [logString appendString:@"\t"];
//    //来源url
//    [logString appendString:preURL];
//    [logString appendString:@"\t"];
//    //当前url
//    [logString appendString:currentURL];
//    [logString appendString:@"\t"];
//    
//    //广告
//    [logString appendString:@"\t"];
//    [logString appendString:@"\t"];
//    [logString appendString:@"\t"];
//    
//    //登录时间
//    [logString appendString:formattedDate];
//    [logString appendString:@"\t"];
//    //channel_id
//    [logString appendString:@"4"];
//    
//    
//    //结束的换行符号
//    [logString appendString:@"\n"];
//    
//    return logString;
//}



- (NSDateFormatter *)logFileDateFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss'"];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    return dateFormatter;
}

//-(UserInfoModal *) getUserInfoModel{
//    UserInfoModal *userInfo = [[LocalCache sharedCache] cachedObjectForKey:@"userInfo"];
//    return userInfo;
//}

//-(NSString *)getShowAccout{
//    NSString *showAccout=nil;
//    UserInfoModal *userInfo = [[LocalCache sharedCache] cachedObjectForKey:@"userInfo"];
//    if (userInfo) {
//        showAccout=userInfo.showAccount;
//    }
//    return showAccout;
//}
//
//-(NSString *) getGestureSwitchStateKeyString{
//    NSString *gestureStateString=nil;
//    NSString *showAccout=[self getShowAccout];
//    if (showAccout) {
//         gestureStateString=[NSString stringWithFormat:@"%@%@",showAccout,kGestureStateConstantString];
//    }
//    return gestureStateString;
//}


+ (NSString *)tokenDecrptContent:(NSString *)encryptStr{
    NSString *enToken = [SystemConfigUtil getDecryptToken];
    NSString *decrptInfo = [_Des TripleDES:encryptStr encryptOrDecrypt:kCCDecrypt key:[SystemConfigUtil calculateDESKEYWithToken:enToken] andIV:[SystemConfigUtil calculateDESIVWithToken:enToken]];
    
    return decrptInfo;
}
@end
