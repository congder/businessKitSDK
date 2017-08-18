//
//  HEncryptClass.h
//  SmartCommunity
//
//  Created by HY on 14/10/29.
//  Copyright (c) 2014年 shenghuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OpenSSLRSAWrapper.h"

@interface HEncryptClass : NSObject
+ (id)sharedHEncryptClassInstance;

/**
 *  对参数进行处理，低安全级的，只使用UDID加密的
 *
 *  @param allParameters   请求所有需要的参数
 *  @param encryptKeys     需要加密的字段
 *  @param completionBlock 完成后的block处理
 */
- (void)udidEncryptParameter:(NSDictionary *)allParameters encryptKeys:(NSArray *)encryptKeys onCompletion:(void (^)(NSDictionary *params))completionBlock;

/**
 *  对参数进行处理， 中安全级别的，使用token + udid 进行加密处理
 *
 *  @param allParaDic      请求所有需要的参数
 *  @param encryptkeys     需要加密的字段
 *  @param completionBlock 完成后的block处理
 */
- (void)tokenEncryptParameter:(NSDictionary *)allParaDic encryptKey:(NSArray *)encryptkeys onCompletion:(void (^)(NSDictionary *params))completionBlock;
- (void)newTokenEncryptParameter:(NSDictionary *)allParaDic encryptKey:(NSArray *)encryptkeys onCompletion:(void (^)(NSDictionary *params))completionBlock;
- (NSString *)desDecryptWithKeyAndIV: (NSString *)plainText;
- (NSString *)desDecryptWithKeyAndIV: (NSString *)plainText withEnToken: (NSString *)enToken;

-(NSMutableDictionary *)encryptUid;

-(void)encryptUdidAndUid:(NSMutableDictionary *)parametersDic;
-(void)encryptAppInitParameter:(void (^)(NSMutableDictionary *dic))completionBlock;
-(void)encryptAppVersionUpdateParameter:(NSMutableDictionary *)paraDic onCompletionBlock:(void (^)(NSMutableDictionary *dic))completionBlock;
-(void)encryptUserCheckLoginParameter:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptAppRegionLbsParameter:(NSDictionary*)limit onCompletion:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptAppRegionCityListParameter:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptAppRegionCommunityListParameter:(NSDictionary*)limit onCompletion:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptAppSetDefaultCommunityParameter:(NSString*)communityID onCompletion:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptAppGetNewsListParameter:(NSDictionary*)limit onCompletion:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptAppGetDyDetailParameter:(NSString*)dyId onCompletion:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptAppDeleteDyParameter:(NSString*)dyId onCompletion:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptAppGetHotGroupListParameter:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptAppGetCommunityDynamicParameter:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptAppDynamicCheckLikedParameter:(NSString*)dynamicId onCompletion:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptAppDynamicLikesParameter:(NSDictionary*)dynamicDic onCompletion:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptAppGetNewsBannerListParameter:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptAppGetNewsCommentListParameter:(NSDictionary*)limitDic onCompletion:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptAppGetMsgsListParameter:(NSDictionary*)limit onCompletion:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptAppPhotoIndexParameter:(NSDictionary*)paraDic onCompletion:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptAppDynamicDelCommentParameter:(NSString*)dyId onCompletion:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptAppDynamicAddCommentParameter:(NSDictionary*)limit onCompletion:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptSendNewsCommentParameter:(NSString*)newsID andContent:(NSString*)content onCompletion:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptsendDynamicParameter:(NSString*)content onCompletion:(void (^)(NSDictionary *dic))completionBloc;
/**
 *  对创建动态的参数加密
 *
 *  @param parameter       参数
 *  @param completionBlock 完成block
 */
- (void)encryptCreateDynamicParameter:(NSDictionary *)parameter onCompletion:(void (^)(NSDictionary *dic))completionBlock;

-(void)encryptUserSearchParameter:(NSString*)parameter andIsFid:(BOOL)isFid onCompletion:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptAddFriendParameter:(NSString*)friendUid onCompletion:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptDeleteFriendParameter:(NSString*)friendUid onCompletion:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptFriendListParameter:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptChangeUserAvatarParameter:(UIImage*)avatarImg onCompletionBlock:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptChangeUserNickNameParameter:(NSString*)nickName onCompletionBlock:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptNewsLikesParameter:(NSDictionary *)paraDic onCompletionBlock:(void (^)(NSDictionary *dic))completionBlock;
//测试
- (void)encrypAppUser:(NSDictionary *)dic onComletion:(void (^)(NSDictionary *dic))comletionBlock;
/**
 *  检查是否已经点赞
 *
 *  @param articeId        文章ID
 *  @param completionBlock block
 */
-(void)encryptNewsCheckLikesParameter:(NSString *)articeId onCompletionBlock:(void (^)(NSDictionary *dic))completionBlock;

-(void)encryptAppIdentifyingCodeParameter:(NSDictionary *)paraDic onCompletion:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptAppUserRegistryParameter:(NSDictionary *)paraDic onCompletion:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptAppUserLoginParameter:(NSDictionary *)paraDic onCompletion:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptUserCheckphonenumParameter:(NSString*)phoneNum onCompletionBlock:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptResetPwdIdentifyingCodeParameter:(NSDictionary *)paraDic onCompletion:(void (^)(NSDictionary *dic))completionBlock;
#pragma mark - 智慧城市相关
-(void)encryptAccountCardCheckParameter:(NSString*)cardId onCompletion:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptAccountCardBindParameter:(NSDictionary*)paraDic onCompletion:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptAccountCardUnbindParameter:(NSString*)cardId onCompletion:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptAccountTradeListParameter:(NSDictionary*)paraDic onCompletion:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptAccountCardList:(void (^)(NSDictionary *dic))completionBlock;
-(void)encryptUserOfficeHolder:(void (^)(NSDictionary *dic))completionBlock;


-(void)encryptSettingAccountCardpswParameter:(NSDictionary*)paraDic onCompletion:(void (^)(NSDictionary *dic))completionBlock;


#pragma mark -
#pragma mark - 首页
/**
 *  对请求的参数进行传输处理
 *
 *  @param paraDic         请求参数
 *  @param completionBlock  完成block
 */
- (void)encryptDynamicMainFunction:(NSDictionary *)paraDic onCompletion:(void (^)(NSDictionary *dic))completionBlock;


#pragma mark --
#pragma mark - 公交一卡通
/**
 *  对请求的参数进行传输处理
 *
 *  @param paraDic         请求参数
 *  @param completionBlock  完成block
 */
- (void)encryptBusCardNoticeList:(NSDictionary *)paraDic onCompletion:(void (^)(NSDictionary *dic))completionBlock;
- (void)encryptConsumeRecordList:(NSDictionary *)paraDic onCompletion:(void (^)(NSDictionary *dic))completionBlock;
- (void)encryptChargeRecordList:(NSDictionary *)paraDic onCompletion:(void (^)(NSDictionary *dic))completionBlock;

#pragma mark -
#pragma mark -- 地址
/**
 *  对请求的参数进行传输处理
 *
 *  @param paraDic         请求参数
 *  @param completionBlock  完成block
 */
// 读取地址列表
- (void)encryptAddressListParameters:(NSDictionary *)paraDic onCompletion:(void (^)(NSDictionary *dic))completionBlock;
// 读取默认地址
- (void)encryptDefaultAddressParameters:(NSDictionary *)paraDic onCompletion:(void (^)(NSDictionary *dic))completionBlock;
// 保存
- (void)encryptAddressParameters:(NSDictionary *)paraDic onCompletion:(void (^)(NSDictionary *dic))completionBlock;

#pragma mark -- 测试
/**
 *  对请求账单详情的参数进行传输处理
 *
 *  @param paraDic         请求参数
 *  @param completionBlock  完成block
 */
-(void)encryptTestParameter:(NSDictionary *)paraDic onCompletion:(void (^)(NSDictionary *dic))completionBlock;

#pragma mark -- 添加缴费
- (void)encryptAddPayment:(NSDictionary *)dic onComletion:(void (^)(NSDictionary *dic))comletionBlock;

#pragma mark -- 水费缴费
- (void)encryptWaterPayment:(NSDictionary *)dic onComletion:(void (^)(NSDictionary *dic))comletionBlock;
#pragma mark -- 电视费缴费
- (void)encryptTelevisonPayment:(NSDictionary *)dic onComletion:(void (^)(NSDictionary *dic))comletionBlock;


#pragma mark - 我的市民卡

#pragma mark -- 交易管理
- (void)encryptTradeManager:(NSDictionary *)dic onComletion:(void (^)(NSDictionary *dic))comletionBlock;
#pragma mark -- 手机号码绑定
- (void)encryptBindingMobile:(NSDictionary *)dic onComletion:(void (^)(NSDictionary *dic))comletionBlock;

#pragma mark -- 出租车交易密码加密
-(void)encryptAppUserPwdParameter:(NSDictionary *)paraDic onCompletion:(void (^)(NSDictionary *dic))completionBlock;

/**
 *  对搜索用户信息接口参数做处理
 *
 *  @param paraDic         参数
 *  @param completionBlock 完成block
 */
- (void)encryptUserSearchInfo:(NSDictionary *)paraDic onCompletion:(void (^)(NSDictionary *dic))completionBlock;


#pragma mark --
/**
 *  对请求账单详情的参数进行传输处理
 *
 *  @param paraDic         请求参数
 *  @param completionBlock  完成block
 */
-(void)encryptAccountBillDetailParameter:(NSDictionary*)paraDic onCompletion:(void (^)(NSDictionary *dic))completionBlock;

/**
 *  支付账单时的账单参数处理
 *
 *  @param paraDic         传输参数
 *  @param completionBlock block
 */
-(void)encryptAccountBillPayParameter:(NSDictionary*)paraDic onCompletion:(void (^)(NSDictionary *dic))completionBlock;


-(void)encryptGetAccountingId: (NSString *)uid onCompletion:(void (^)(id dic, NSError *e))completionBlock;
#pragma mark - 重写加密方法
/*
 paraArray----value值
 keyArray ----Key值
 
 把Dic 拆分为 Array  保证数组count一直
 
 encryptAccountWithUdid  包含udid
 encryptAccountWithNotUdid  不包含udid
 
 如有特殊需要  自己添加方法
 */
- (void)encryptAccountWithUdid:(NSArray *)paraArray dicKeyArray:(NSArray *)keyArray onCompletion:(void (^)(NSDictionary *dic))completionBlock;
- (void)encryptAccountWithNotUdid:(NSArray *)paraArray dicKeyArray:(NSArray *)keyArray onCompletion:(void (^)(NSDictionary *dic))completionBlock;
- (void)encryptAccountWithUdidAndOther:(NSArray *)paraArray dicKeyArray:(NSArray *)keyArray onCompletion:(void (^)(NSDictionary *dic))completionBlock;
- (void)encryptAccountWithUdidAndToken:(NSArray *)paraArray dicKeyArray:(NSArray *)keyArray onCompletion:(void (^)(NSDictionary *dic))completionBlock;
#pragma mark -- 交易密码
- (void)encrypQueryIsTradingPassword:(NSDictionary *)paraDic onCompletion:(void (^)(NSDictionary *dic))completionBlock;
- (void)encryTradingPassword:(NSDictionary *)paraDic onCompletion:(void (^)(NSDictionary *dic))completionBlock;
- (void)updateTradingPassword:(NSDictionary *)paraDic onCompletion:(void (^)(NSDictionary *dic))completionBlock;
- (void)resetTradingPassword:(NSDictionary *)paraDic onCompletion:(void (^)(NSDictionary *dic))completionBlock;

- (void)paymentParamrter:(NSDictionary *)parDic onCompletion:(void (^)(NSDictionary *dic))com;

#pragma mark--电缴费
-(void)encryptdianJiaoFeiParameter:(NSDictionary *)paraDic onCompletion:(void (^)(NSDictionary *dic))completionBlock;
#pragma mark--手机缴费
-(void)encryptshoujiJiaoFeiParameter:(NSDictionary *)paraDic onCompletion:(void (^)(NSDictionary *dic))completionBlock;
@end
