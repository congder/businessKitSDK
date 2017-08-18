//
//  AppUtils.m
//  TeamWork
//
//  Created by kongjun on 14-7-10.
//  Copyright (c) 2014年 Shenghuo. All rights reserved.
//

#import "AppUtils.h"
#import "MacroDefine.h"
#import "UIView+Toast.h"
#import "UIImage+Addition.h"
#import "NSString+Regular.h"
#import "HCommunityModeClass.h"
#import "Reachability.h"
#import "LocalCache.h"
#import "3Des.h"
#import "SystemConfigUtil.h"
#import "NetworkAPI.h"
#define SENDREALNAME @"1"
#define DIDNOTSENDREALNAME @"0"

@implementation AppUtils

+ (id)sharedAppUtilsInstance
{
    static AppUtils *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (NSData *) compressImageToProperSize:(UIImage *)image
{
    @autoreleasepool {
        NSData  *imageData    = UIImageJPEGRepresentation(image, kMESImageQuality);
        double   factor       = 0.6;
        double   adjustment   = 1.0 / sqrt(2.0);  // or use 0.8 or whatever you want
        CGSize   size         = image.size;
        CGSize   currentSize  = size;
        UIImage *currentImage = image;
        
        NSInteger maxSize = kMaxImageUploadSize;
        if (image.size.height/ image.size.width > 3) {
            maxSize = KMaxLongImageUploadSize;
        }
        
        while (imageData.length >= maxSize)
        {
            factor      *= adjustment;
            currentSize  = CGSizeMake(roundf(size.width * factor), roundf(size.height * factor));
            currentImage = [image  resizedImage:currentSize interpolationQuality:kMESImageQuality];
            imageData    = UIImageJPEGRepresentation(currentImage, kMESImageQuality);
        }
        return imageData;
    }
}

- (void)showHint:(NSString *)hint
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"HintTranslator" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    if (data && data[hint]) {
        hint = data[hint];
    }
    [view makeToast:hint duration:2 position:[NSValue valueWithCGPoint:CGPointMake(view.center.x,  CGRectGetHeight(view.frame) - 88)]];
}

- (void)tableViewSeparatorInsetZero:(UITableView *)tableView
{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)cellSeparatorInsetZero:(UITableViewCell *)cell
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    //    按照作者最后的意思还要加上下面这一段
    //    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
    //        [cell setPreservesSuperviewLayoutMargins:NO];
    //    }
}

// 检测网络是否活跃
- (BOOL)hasConnectivity
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&zeroAddress);
    if(reachability != NULL) {
        //NetworkStatus retVal = NotReachable;
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(reachability, &flags)) {
            if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
            {
                // if target host is not reachable
                return NO;
            }
            
            if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
            {
                // if target host is reachable and no connection is required
                //  then we'll assume (for now) that your on Wi-Fi
                return YES;
            }
            
            
            if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
                 (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
            {
                // ... and the connection is on-demand (or on-traffic) if the
                //     calling application is using the CFSocketStream or higher APIs
                
                if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
                {
                    // ... and no [user] intervention is needed
                    return YES;
                }
            }
            
            if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
            {
                // ... but WWAN connections are OK if the calling application
                //     is using the CFNetwork (CFSocketStream?) APIs.
                return YES;
            }
        }
    }
    
    return NO;
}

//-(void)sendSocketLocalNotification:(NSString *)alertBody{
//    NSDate *now=[NSDate new];
//    UILocalNotification *notification=[[UILocalNotification alloc] init];
//    notification.fireDate=[now dateByAddingTimeInterval:0];
//    notification.timeZone=[NSTimeZone defaultTimeZone];
//    notification.alertBody=alertBody;
//    //notification.soundName = @"default";
//    AudioServicesPlaySystemSound(1367);
//    [notification setApplicationIconBadgeNumber:1];
//    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
//}

- (NSString *)stringWithUUID
{
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    CFStringRef uuidStrRef = CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    
    NSString *uuidStr = (__bridge NSString *)uuidStrRef;
    CFRelease(uuidStrRef);
    
    return uuidStr;
}

//-(void)deleteDBTable
//{
//    [[XLSQLite sharedInstance] dropTableWithName:kChatNotes];
//    [[XLSQLite sharedInstance] dropTableWithName:kFriendsList];
//    [[XLSQLite sharedInstance] dropTableWithName:kGroupsList];
//    [[XLSQLite sharedInstance] dropTableWithName:kVerifications];
//    [[XLSQLite sharedInstance] dropTableWithName:kUpdateGroup];
//    [[XLSQLite sharedInstance] dropTableWithName:kTaskNotes];
//    [[XLSQLite sharedInstance] dropTableWithName:kMassNotes];
//    [[XLSQLite sharedInstance] dropTableWithName:kProcess];
//
//}

-(UIViewController *) getCurrentViewController: (UIView *)view {
    UIViewController *currentVC;
    while (view != nil) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:UIViewController.class]) {
            currentVC = (UIViewController *) nextResponder;
            break;
        }
        view = [view superview];
    }
    return currentVC;
}
/*
- (void) getCardInfo: (void (^)(NSError *e))completionBlock {
    [hNetWorkOperation hNetworkAccountCardList:^(id responseData, NSError *error) {
        DLog(@"%@", responseData);
        if (!error) {
            NSString *enToken = [SystemConfigUtil getDecryptToken];
            NSString *cardList = [_Des TripleDES:[responseData objectForKey:@"card_list"] encryptOrDecrypt:kCCDecrypt key:[SystemConfigUtil calculateDESKEYWithToken:enToken] andIV:[SystemConfigUtil calculateDESIVWithToken:enToken]];
            //将json字符串转化为数据然后解析
            NSData* jsonData = [cardList dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *cardListArray = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
            
            if (cardListArray.count > 0) {
                NSDictionary *cardNumDic = [cardListArray objectAtIndex:0];
                NSString *cardid = [cardNumDic objectForKey:@"cardid"];
                NSString *uid = [_Des TripleDES:[responseData objectForKey:@"uid"] encryptOrDecrypt:kCCDecrypt key:[SystemConfigUtil calculateDESKEYWithToken:enToken] andIV:[SystemConfigUtil calculateDESIVWithToken:enToken]];
                //保存新城势卡号  HMyShtCardVC.m
                if (![cardid isEqualToString:@""]) {
                    [mUserDefaults setObject:cardid forKey:HLIFECARD];
                    [mUserDefaults synchronize];
                }
                if (uid.length!=0) {
                    [mUserDefaults setObject:uid forKey:HLIFEUID];
                    [mUserDefaults synchronize];
                }
            }
        }else{
            if ([[error.userInfo objectForKey:ERRORCODE] isEqualToString:@"AS105"]||[[error.userInfo objectForKey:ERRORCODE] isEqualToString:@"AS108"]){
                [mAppDelegate tokenErrorAlert:@"AS105"];
            } else {
                mAlertAPIErrorInfo(error);
                DLog(@"获取新城势卡列表 error:%@",[error.userInfo objectForKey:ERRORMSG]);
            }
        }
        completionBlock(error);
    }];
}
*/
- (NSDictionary *)getFunctionDataSource: (NSString *)key exceptKeys: (NSSet<NSString *> *)keys {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"FunctionList" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    id dataSource = data[key];
    if (dataSource && [dataSource isKindOfClass:NSDictionary.class]) {
        NSMutableDictionary *tDataSource = [NSMutableDictionary dictionaryWithDictionary:dataSource];
        NSMutableArray *tList = [NSMutableArray array];
        NSArray *list = tDataSource[@"list"];
        if (list) {
            for (id item in list) {
                if ([self checkFunctionIsShown:item]) {
                    if (![keys containsObject:item[@"id"]]) {
                        [tList addObject:[NSMutableDictionary dictionaryWithDictionary:item]];
                    }
                }
            }
            tDataSource[@"list"] = tList;
        }
        return tDataSource;
    }
    return nil;
}

- (NSDictionary *)getFunctionDataSource: (NSString *)key withKeys: (NSSet<NSString *> *)keys {
    NSDictionary *dic = [mAppUtils getFunctionDataSource:key];
    NSMutableDictionary *data;
    if (dic) {
        data = [NSMutableDictionary dictionaryWithDictionary:dic];
        NSArray *list = data[@"list"];
        NSMutableArray *tList = [NSMutableArray array];
        for (NSDictionary *item in list) {
            if ([keys containsObject:item[@"id"]]) {
                [tList addObject:item];
            }
        }
        data[@"list"] = tList;
    }
    return data;
}

- (NSDictionary *)getFunctionDataSource: (NSString *)key {
    return [self getFunctionDataSource:key exceptKeys:[NSSet set]];
}

- (BOOL)checkFunctionIsShownWithId: (NSString *)kId {
    //可能涉及的隐藏功能
    NSSet *hideFunctions = [NSSet setWithArray:@[CFTradePassword, CFLifeCardBalance, CFLifeCardTrade, CFLifeCardCharge, CFQRScan, CFChargeFromBankCard, @"traffic-card", @"taxi"]]; // , @"pay", @"phone-charge"
    //需要隐藏的城市和核算机构
    NSSet *citiesAndOrganizations = [NSSet setWithArray:@[@"150100", @"150200", @"150300", @"150400", @"150500", @"150600", @"150700", @"150800", @"150900", @"152200", @"152500", @"152900", @"BT00", @"ERDS", @"EE00", @"TL00"]];
    
    NSString *lifeCardCity = [mUserDefaults objectForKey:CKeyLifeCardCity];
    NSString *selectCity = WholeCountryCode;//默认全国
    HCommunityModeClass *currentCommunityModel = [mAppCache cachedObjectForKey:HCurrentCommunityModel];
    if (currentCommunityModel) {
        selectCity = currentCommunityModel.hCityId;
    }
    return ![hideFunctions containsObject:kId] || (![citiesAndOrganizations containsObject:lifeCardCity] && ![citiesAndOrganizations containsObject:selectCity]);
}

- (BOOL)checkFunctionIsShown: (NSDictionary *)item {
    if ([item isKindOfClass:NSDictionary.class]) {
        NSString *kId = item[@"id"];
        return [self checkFunctionIsShownWithId:kId];
    }
    return NO;
}

- (NSDictionary *)findBankDiscount: (NSString *)name {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"DiscountBank" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    if (data) {
        NSArray *keys = [data keysSortedByValueUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {return YES;}];
        for (NSString *key in keys) {
            if (key.length <= name.length) {
                NSUInteger index = name.length - key.length;
                NSString *endStr = [name substringFromIndex:index];
                
                if ([key isEqualToString:endStr]) {
                    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:data[key]];
                    dic[@"name"] = [name substringToIndex:index];
                    return dic;
                }
            }
        }
    }
    return nil;
}

- (NSDictionary *) getBankDiscount: (int)discountType {
    switch (discountType) {
        case BankDiscountBS:
            return [self findBankDiscount:@"-包商卡"];
            break;
        case BankDiscountMS:
            return [self findBankDiscount:@"-民生卡"];
            break;
        default:
            break;
    }
    return nil;
}

- (void) doBankDiscountIcon: (NSDictionary *)data withImageView: (UIImageView *)imageView withIconName: (NSString *) iconName {
    imageView.alpha = 1;
    NSString *icon = data[iconName];
    if (icon) {
        imageView.image = [UIImage imageNamed:icon];
    } else {
        imageView.alpha = 0;
    }
}

- (NSString *)formatHTML: (NSString *)desc {
    NSString *_desc = [NSString stringWithFormat:@"<html><head><meta name='viewport' content='width=device-width, initial-scale=1'><style>img{width: 100%%;height: auto;} p{width: 100%%;word-wrap:break-word;} body{margin:0px;padding:0px;word-wrap:break-word;font-size:15px;}</style></head><body>%@</body></html>", desc];
    return _desc;
}

- (BOOL)checkBankCardHasBind: (NSString *)_cardNo withBankCode: (NSString *)_bankCode withBankName: (NSString *)_bankName  {
    NSString *cardNo = _cardNo;
    if (cardNo && cardNo.length >= 4) {
        cardNo = [cardNo substringFromIndex:cardNo.length - 4];
    } else {
        return NO;
    }
    NSDictionary *bankInfo = [mAppCache cachedObjectForKey:CKeyForBankList];
    NSArray *agreementList = [bankInfo objectForKey:@"agreementList"];
    agreementList = agreementList ? agreementList : [[bankInfo objectForKey:@"SvcBody"] objectForKey:@"agreementList"];
    agreementList = agreementList ? agreementList : bankInfo[@"cardList"];
    if (agreementList) {
        for (NSDictionary *cardInfo in agreementList) {
            NSString *compareCardNo = cardInfo[@"cardNo"];
            compareCardNo = compareCardNo ? compareCardNo : cardInfo[@"bankCardNo"];
            NSString *compareBankCode = cardInfo[@"bankCode"];
            NSString *compareBankName = cardInfo[@"bankName"];
            
            if ([cardNo isEqualToString:compareCardNo] && ((_bankCode && [_bankCode isEqualToString:compareBankCode]) || (_bankName && [compareBankName isEqualToString:_bankName]))) {
                return YES;
            }
        }
    }
    return NO;
    //    NSString *replaceStr = @" ";
    //    NSMutableString *transStr = [[NSMutableString alloc] initWithString:_cardNo];
    //    NSRange range = [transStr rangeOfString:replaceStr];
    //    while (range.location!=NSNotFound) {
    //        [transStr deleteCharactersInRange:range];
    //        range = [transStr rangeOfString:replaceStr];
    //    }
    //
    //    BOOL hasBindFlag = NO;
    //    NSDictionary *bankInfo = [mAppCache cachedObjectForKey:CKeyForBankList];
    //    if (bankInfo) {
    //        NSArray *agreementList = [bankInfo objectForKey:@"agreementList"];
    //        agreementList = agreementList ? agreementList : [[bankInfo objectForKey:@"SvcBody"] objectForKey:@"agreementList"];
    //        if (agreementList) {
    //            for (NSDictionary *cardInfo in agreementList) {
    //                NSString *cardNo = cardInfo[@"cardNo"];
    //                NSString *bindMobile = cardInfo[@"bindMobile"];
    //                NSString *bankCode = cardInfo[@"bankCode"];
    //                if (transStr && transStr.length > 4 && [[transStr substringFromIndex:transStr.length - 4] isEqualToString:cardNo] && _bankCode && [_bankCode isEqualToString:bankCode] && _bindMobile && [_bindMobile isEqualToString:bindMobile]) {
    //                    hasBindFlag = YES;
    //                    break;
    //                }
    //            }
    //        }
    //    }
    //    return hasBindFlag;
}

- (UITapGestureRecognizer *)addTapGesture:(UIView *)view withTarget: (id) target withSelector: (SEL) selector {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:target action:selector];
    tapGesture.cancelsTouchesInView = NO;
    [view addGestureRecognizer:tapGesture];
    return tapGesture;
}

- (BOOL)checkRealNameInfo:(int)compareType userName:(NSString *)userName idCardNum:(NSString *)idCard {
    NSString *isSendRealName = [mUserDefaults objectForKey:HUserIsSendRealName];
    if ([SENDREALNAME isEqualToString:isSendRealName]) {
        if (![userName isNotEmpty] || ![idCard isNotEmpty]) {
            return NO;
        }
        NSString *userIdCard = [_Des TripleDES:[mUserDefaults objectForKey:HUserIdCardNum] encryptOrDecrypt:kCCDecrypt key:[SystemConfigUtil calculateDefaultDESKEY] andIV:[SystemConfigUtil calculateDefaultDESIV]];
        NSString *realName = [_Des TripleDES:[mUserDefaults objectForKey:HUserRealName] encryptOrDecrypt:kCCDecrypt key:[SystemConfigUtil calculateDefaultDESKEY] andIV:[SystemConfigUtil calculateDefaultDESIV]];
        if (0 == compareType) {
            //0:精确匹配
            return [userName isEqualToString:realName] && [idCard isEqualToString:userIdCard];
        } else if (1 == compareType) {
            //1:身份证号精确匹配,姓名模糊匹配
            return [idCard isEqualToString:userIdCard] && [self blurCompare:realName withStarStr:userName];
        } else if (2 == compareType) {
            //2:身份证号模糊匹配,姓名精确匹配
            return [realName isEqualToString:userName] && [self blurCompare:userIdCard withStarStr:idCard];
        } else if (3 == compareType) {
            //3:身份证号模糊匹配,姓名模糊匹配
            return [self blurCompare:realName withStarStr:userName] && [self blurCompare:userIdCard withStarStr:idCard];
        } else if (4 == compareType) {
            //4:姓名模糊匹配
            return [self blurCompare:realName withStarStr:userName];
        } else if (5 == compareType) {
            //5:姓名模糊匹配 实名化,用于加油卡充值添加银行卡
            NSString *fuelName = [mUserDefaults stringForKey:HFuelFillingCardName];
            return [self blurCompare:userName withStarStr:fuelName];
        } else {
            return YES;
        }
    } else {
        NSString *fuelName = [mUserDefaults stringForKey:HFuelFillingCardName];
        if (5 == compareType) {
            //5:姓名模糊匹配 未实名化,用于加油卡充值添加银行卡
            return [self blurCompare:userName withStarStr:fuelName];
        }
    }
    return YES;
}

- (BOOL)blurCompare: (NSString *)originStr withStarStr:(NSString *) starStr {
    if (!originStr || !starStr || originStr.length != starStr.length) {
        return NO;
    }
    for (int i = 0; i < originStr.length; i++) {
        unichar c1 = [originStr characterAtIndex:i];
        unichar c2 = [starStr characterAtIndex:i];
        if (c2 == '*') {
            continue;
        }
        if (c1 != c2) {
            return NO;
        }
    }
    return YES;
}


#pragma mark - 添加银行卡/新城市卡
- (BOOL) addBankCardInfoWithType:(NSString *)addType userName:(NSString *)userName idCardNum:(NSString *)idCard idType:(NSString *)idType{
    
    NSString *isSendRealName = [mUserDefaults objectForKey:HUserIsSendRealName];
    NSString *userIdCard = [_Des TripleDES:[mUserDefaults objectForKey:HUserIdCardNum] encryptOrDecrypt:kCCDecrypt key:[SystemConfigUtil calculateDefaultDESKEY] andIV:[SystemConfigUtil calculateDefaultDESIV]];
    //[hEncrypt desDecryptWithKeyAndIV:[mUserDefaults objectForKey:HUserIdCardNum]];
    NSString *realName = [_Des TripleDES:[mUserDefaults objectForKey:HUserRealName] encryptOrDecrypt:kCCDecrypt key:[SystemConfigUtil calculateDefaultDESKEY] andIV:[SystemConfigUtil calculateDefaultDESIV]];
    if ([addType isEqualToString:@"addBankCard"]) {
        //添加银行卡
        if (isSendRealName ==nil || [isSendRealName isEqualToString:DIDNOTSENDREALNAME] || [isSendRealName isEqualToString:@""]) {
            return YES;
        } else if([isSendRealName isEqualToString:SENDREALNAME]) {
            NSString *name = realName;
            NSString *idCardNum = userIdCard;
            if ([userName isEqualToString:name] && [idCardNum isEqualToString:idCard]) {
                return YES;
            } else {
                return NO;
            }
        }
        return NO;
    } else if ([addType isEqualToString:@"addNewCityCard"]) {
        //添加新城市卡
        if (isSendRealName ==nil || [isSendRealName isEqualToString:DIDNOTSENDREALNAME]  || [isSendRealName isEqualToString:@""]) {
            return YES;
        } else if([isSendRealName isEqualToString:SENDREALNAME]) {
            NSString *name = realName;
            NSString *idCardNum = userIdCard;
//            NSString *idtype = [mUserDefaults objectForKey:HUserIdType];
            if ([userName isEqualToString:name] && [idCardNum isEqualToString:idCard]) {
                return YES;
            } else {
                return NO;
            }
            return NO;
        }
    } else if([addType isEqualToString:@""]) {
        //加油卡添加银行卡
        NSString *fuleFillingCardName = [mUserDefaults objectForKey:HFuelFillingCardName];
        
        if (isSendRealName ==nil || [isSendRealName isEqualToString:DIDNOTSENDREALNAME] || [isSendRealName isEqualToString:@""]) {
            
            DLog(@"===>保存的名字%@",fuleFillingCardName);
            
            if (fuleFillingCardName == nil || [fuleFillingCardName isEqualToString:@""]) {
                [mUserDefaults setObject:userName forKey:HFuelFillingCardName];
                [mUserDefaults synchronize];
                return YES;
            }else{
                NSString *nameString = [mUserDefaults objectForKey:HFuelFillingCardName];
                
                DLog(@"===>%@",nameString);
                if (nameString.length == userName.length) {
                    NSMutableArray *stringArray = [NSMutableArray arrayWithCapacity:0];
                    for (int i =0; i< nameString.length; i++) {
                        NSString *ca = [nameString substringWithRange:NSMakeRange(i, 1)];
                        if ([ca isEqualToString:@"*"]) {
                            NSString *string = [nameString substringWithRange:NSMakeRange(i, 1)];
                            [stringArray addObject:string];
                        }
                    }
                    
                    for (NSString *string in stringArray) {
                        NSRange range = [nameString rangeOfString:string];
                        userName = [userName stringByReplacingCharactersInRange:range withString:@""];
                    }
                    nameString = [nameString stringByReplacingOccurrencesOfString:@"*" withString:@""];
                    if ([userName isEqualToString:nameString]) {
                        DLog(@"一致");
                        return YES;
                    }else{
                        return NO;
                    }
                }else{
                    return NO;
                }
                
            }
            return NO;
        } else {
            NSString *nameString = realName;
            if (nameString.length == userName.length) {
                NSMutableArray *stringArray = [NSMutableArray arrayWithCapacity:0];
                for (int i =0; i< userName.length; i++) {
                    NSString *ca = [userName substringWithRange:NSMakeRange(i, 1)];
                    if ([ca isEqualToString:@"*"]) {
                        NSString *string = [nameString substringWithRange:NSMakeRange(i, 1)];
                        [stringArray addObject:string];
                    }
                }
                userName = [userName stringByReplacingOccurrencesOfString:@"*" withString:@""];
                for (NSString *string in stringArray) {
                    NSRange range = [nameString rangeOfString:string];
                    nameString = [nameString stringByReplacingCharactersInRange:range withString:@""];
                }
                if ([userName isEqualToString:nameString]) {
                    DLog(@"一致");
                    return YES;
                }else{
                    return NO;
                }
            }else{
                return NO;
            }
        }
    }
    return NO;
}

-(void)saveDateInCacheWith:(NSString *)name idCard:(NSString *)idCard{
    
    [mAppCache storeString:name forKey:HUserRealName block:^(LocalCache *cache, NSString *key) {
        
    }];
    
    [mAppCache storeString:idCard forKey:HUserIdCardNum block:^(LocalCache *cache, NSString *key) {
        
    }];
    
}

// 修改是否修改实名信息等
- (void)changeIsSendUserName{
    NSString *isSendRealName = [mUserDefaults objectForKey:HUserIsSendRealName];
    if (![SENDREALNAME isEqualToString:isSendRealName]) {
        NSString *name  = [mAppCache cachedStringForKey:HUserRealName];
        NSString *cardNum = [mAppCache cachedStringForKey:HUserIdCardNum];
        if (name && cardNum) {
            [mUserDefaults setObject:SENDREALNAME forKey:HUserIsSendRealName];
            [mUserDefaults setObject:[_Des TripleDES:name encryptOrDecrypt:kCCEncrypt key:[SystemConfigUtil calculateDefaultDESKEY] andIV:[SystemConfigUtil calculateDefaultDESIV]] forKey:HUserRealName];
            [mUserDefaults setObject:[_Des TripleDES:cardNum encryptOrDecrypt:kCCEncrypt key:[SystemConfigUtil calculateDefaultDESKEY] andIV:[SystemConfigUtil calculateDefaultDESIV]] forKey:HUserIdCardNum];
            [mUserDefaults synchronize];
        }
    }
}

- (void)changeTabIndex: (int) index {
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
//    if ([vc isKindOfClass:KYDrawerController.class]) {
//        KYDrawerController *kVc = (KYDrawerController *)vc;
//        [kVc setDrawerState:DrawerStateClosed animated:NO];
//        UITabBarController *tabVc = (UITabBarController *)kVc.mainViewController;
//        [tabVc setSelectedIndex:index];
//    }
}

- (NSString *)deviceIPAdress {
    NSString *address = @"192.168.12.198";
    
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) { // 0 表示获取成功
        
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone  Wifi环境获取iP地址方法</span>
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    if(address != NULL && [address length] != 0 ){
                        break;
                    }
                }
            }
            // Not a loopback device.
            // network flow
            if (strncmp(temp_addr->ifa_name, "lo", 2)){
                
            }
            //pdp_ip0   2G 3G 4G 获取iP地址方法</span>
            if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"pdp_ip0"]) {
                // Get NSString from C String
                address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
//                if(address != NULL && [address length] != 0 ){
//                    
//                    return  address;
//                }
            }
            temp_addr = temp_addr->ifa_next;
            
        }
    }
    
    freeifaddrs(interfaces);
//    NSLog(@"手机的IP是:%@", address);
    return  address;
}

- (BOOL) isCouponProduction: (DistrictDetailsModel *)dataModel {
    BOOL flag = false;
    NSArray *productCategoryList = dataModel.productCategoryIdList;
    for (NSDictionary *item in productCategoryList) {
        NSString *type = item[@"productCategoryType"];
        if ([CategoryTypeCoupon isEqualToString:type]) {
            flag = true;
            break;
        }
    }
    return flag;
}

- (NSDictionary *)findBelongStore:(NSArray *)storeList {
    if (!storeList) {
        return nil;
    }
    NSDictionary *store;
    if (storeList && storeList.count > 0) {
        for (NSDictionary *storeItem in storeList) {
            if ([@"01" isEqualToString:storeItem[@"relationType"]]) {
                store = storeItem;
                break;
            }
        }
    }
    return store;
}

- (void)changeCity: (NSString *)cityId withName:(NSString *)cityName {
    if (cityId && cityName) {
        [mNotificationCenter postNotificationName:HCurrentCityChanged object:@{@"objectId": cityId}];
        
        HCommunityModeClass *currentCommunityModel = [HCommunityModeClass new];
        currentCommunityModel.hCityName = cityName;
        currentCommunityModel.hCityId = cityId;
        currentCommunityModel.hCommunityID = cityId;
        currentCommunityModel.hCommunityName = cityName;
        
        if ([mUserDefaults boolForKey:HUserLogin]) {
            NSDictionary *relationDic = @{@"uid":[mUserDefaults objectForKey:HCurrentUid],@"communityId":currentCommunityModel.hCommunityID,@"default":@"1"};
//            [mDataBase insertCommunityList:currentCommunityModel complection:^(NSError *error) {}];
//            [mDataBase insertUserAndCommunityRelationList: relationDic complection:^(NSError *error) {}];
        }
        
        [mAppCache storeObject:currentCommunityModel forKey:HCurrentCommunityModel block:nil];
        
        //更改城市Hcityid因为网站注册用户登录时不返回城市，在此存储后使用
        [mUserDefaults setObject:currentCommunityModel.hCityId forKey:Hcityid];
        [mUserDefaults setObject:currentCommunityModel.hCityName forKey:HCurrentLocationAddress];
        [mUserDefaults synchronize];
        
//        HCityModelClass *cityModel = [HCityModelClass new];
//        cityModel.hCityName = cityName;
//        cityModel.hCityID = cityId;
//        [[NSNotificationCenter defaultCenter] postNotificationName:HChangeCity object:cityModel];
//        [[NSNotificationCenter defaultCenter] postNotificationName:HReSetCommunity object:cityModel];
    }
}

@end
