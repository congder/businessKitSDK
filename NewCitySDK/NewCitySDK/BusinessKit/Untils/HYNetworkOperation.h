//
//  HYNetworkOperation.h
//  SmartCommunity
//
//  Created by haoyi on 14/12/14.
//  Copyright (c) 2014年 shenghuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MacroDefine.h"
@interface HYNetworkOperation : NSObject
+ (instancetype)shareInstance;
@end

typedef void(^NetworkOperationCompletion)(id responseData, NSError* error);

@interface HYNetworkOperation (AppDelegate)
-(void)hNetworkInitApp:(NetworkOperationCompletion)completionBlock;
-(void)hNetworkCheckLogin:(NetworkOperationCompletion)completionBlock;
-(void)hNetworkCheckAppUpdate:(NSMutableDictionary *)parameters onCompletionBlock:(NetworkOperationCompletion)completionBlock;
-(void)hNetworkUpdateVersion:(NetworkOperationCompletion)completionBlock;
-(void)hNetworkInitFriendList:(NetworkOperationCompletion)completionBlock;
@end

@interface HYNetworkOperation (HLogin)
@end

@interface HYNetworkOperation (HRegister)
@end

@interface HYNetworkOperation (HResetPwd)
@end

@interface HYNetworkOperation (HFindPwd)
@end


@interface HYNetworkOperation (MainPage)
-(void)hNetworkGetNewsList:(NSDictionary *)parameters onCompletionBlock:(NetworkOperationCompletion)completionBlock;
-(void)hNetworkGetHotGroupList:(NetworkOperationCompletion)completionBlock;
-(void)hNetworkGetCommunityDynamic:(NSDictionary *)parameters onCompletionBlock:(NetworkOperationCompletion)completionBlock;
-(void)hNetworkGetDynamicDetail:(NSString *)dyId onCompletionBlock:(NetworkOperationCompletion)completionBlock;
-(void)hNetworkDelDynamic:(NSString *)dyId onCompletionBlock:(NetworkOperationCompletion)completionBlock;

// 动态获取首页图标
- (void)getDynamicMainFunctionList:(NSDictionary *)paraDic onCompletionBlock:(NetworkOperationCompletion)completionBlock;

@end

@interface HYNetworkOperation (HNewsView)
// 头部广告NewsBannerList
-(void)hNetworkGetNewsBannerList:(NSDictionary *)paraDic onCompletionBlock:(NetworkOperationCompletion)completionBlock;

-(void)hNetworkGetSendDynamic:(NSString *)content onCompletionBlock:(NetworkOperationCompletion)completionBlock;
/**
 *  创建有图片的动态
 *
 *  @param dynamicDic      传递的参数
 *  @param imageDic         传递的图片
 *  @param completionBlock 完成block
 */
- (void)HNetworkCreatDynamic:(NSDictionary *)dynamicDic  imageDic:(NSDictionary *)imageDic onCompletionBlock:(NetworkOperationCompletion)completionBlock;

- (void)hNetworkCheckLikedNewsId:(NSString *)newsId CompletionBlock:(NetworkOperationCompletion)completionBlock;
@end

@interface HYNetworkOperation (HCommentsListVC)
-(void)hNetworkGetMsgsList:(NSDictionary *)parameters onCompletionBlock:(NetworkOperationCompletion)completionBlock;
@end

@interface HYNetworkOperation (HCommunityDyVC)
-(void)hNetworkDynamicCheckLiked:(NSString *)dynamicId onCompletionBlock:(NetworkOperationCompletion)completionBlock;
-(void)hNetworkDynamicLikes:(NSDictionary *)dynamicDic onCompletionBlock:(NetworkOperationCompletion)completionBlock;
@end
@interface HYNetworkOperation (HAlbumVC)
-(void)hNetworkPhotoIndex:(NSDictionary *)photoIndexDic onCompletionBlock:(NetworkOperationCompletion)completionBlock;
@end
@interface HYNetworkOperation (HCommentsList)
-(void)hNetworkDyDelComment:(NSString *)DyId onCompletionBlock:(NetworkOperationCompletion)completionBlock;
@end
@interface HYNetworkOperation (HNewsDeati)
@end

// 公交一卡通
@interface HYNetworkOperation (BusCard)
// 公交公告
- (void)networkGetNoticeList:(NSDictionary *)parameters onCompletionBlock:(NetworkOperationCompletion)completionBlock;
// 消费记录列表
- (void)getConsumeRecordListParameters:(NSDictionary *)paraDic onCompletionBlock:(NetworkOperationCompletion)completionBlock;
// 充值记录查询
- (void)getChargeRecordListParameters:(NSDictionary *)paraDic onCompletionBlock:(NetworkOperationCompletion)completionBlock;



@end

@interface HYNetworkOperation (HAddNewFriend)
@end

@interface HYNetworkOperation (HSearchResult)
@end

@interface HYNetworkOperation (HVerifiedFriend)
@end

@interface HYNetworkOperation (HPersonalData)
@end

// 个人信息修改
@interface HYNetworkOperation (HChangeUserMsg)

// 获取服务端省市区列表
- (void)networkGetProvinceList:(NSDictionary *)parameters onCompletionBlock:(NetworkOperationCompletion)completionBlock;

#pragma mark 地址操作

// 读取地址列表
- (void)networkGetAddressList:(NSDictionary *)paraDic onCompletionBlock:(NetworkOperationCompletion)completionBlock;

// <读取默认地址>
- (void)networkGetDefaultsAddress:(NSDictionary *)paraDic onCompletionBlock:(NetworkOperationCompletion)completionBlock;

//<添加>
- (void)networkAddAddress:(NSDictionary *)paraDic onCompletionBlock:(NetworkOperationCompletion)completionBlock;
// <更改地址>
- (void)updateAddress:(NSDictionary *)paraDic onCompletionBlock:(NetworkOperationCompletion)completionBlock;


@end

@interface HYNetworkOperation (HChangeCityList)
@end

@interface HYNetworkOperation (HSetCurrentLocation)
@end

@interface HYNetworkOperation (HOfficeHolderVC)
-(void)hNetworkUserOfficeHolder:(NetworkOperationCompletion)completionBlock;
@end

@interface HYNetworkOperation (HAddSHTCardVC)
-(void)hNetworkAccountCardCheck:(NSString *)cardId onCompletionBlock:(NetworkOperationCompletion)completionBlock;
@end

@interface HYNetworkOperation (HAddCardIdentifyingCode)
-(void)hNetworkAccountCardSendMsg:(NSString *)cardId onCompletionBlock:(NetworkOperationCompletion)completionBlock;
-(void)hNetworkAccountCardBind:(NSDictionary *)paraDic onCompletionBlock:(NetworkOperationCompletion)completionBlock;
@end

@interface HYNetworkOperation (HMyShtCardVC)
-(void)hNetworkAccountCardList:(NetworkOperationCompletion)completionBlock;
-(void)hNetworkAccountCardUnbind:(NSString *)cardId onCompletionBlock:(NetworkOperationCompletion)completionBlock;
-(void)hNetworkAccountCardBalance:(NSString *)cardId onCompletionBlock:(NetworkOperationCompletion)completionBlock;

@end

@interface HYNetworkOperation(HUserManager)

/**
 *  添加好友
 */
- (void)hNetworkAccountAddUser:(NSDictionary *)paramDic onCompletionBlock:(NetworkOperationCompletion)completion;

- (void)hNetWorkAccountSearchUserInfo:(NSDictionary *)paramsDic onCompletionBlock:(NetworkOperationCompletion)completionBlock;

/**
 *  请求添加的新好友列表
 */
- (void)hNetworkAccountAskFriendList:(NSDictionary *)paramDic onCompletionBlock:(NetworkOperationCompletion)completion;

/**
 *  对请求添加好友的确认与忽略处理
 */
- (void)hNetworkAccountConfirmFriend:(NSDictionary *)paramDic onCompletionBlock:(NetworkOperationCompletion)completion;

/**
 *  修改用户备注名
 */
- (void)hNetworkSetUserRemark:(NSDictionary *)paraDic onCompletionBlock:(NetworkOperationCompletion)completion;

@end

@interface HYNetworkOperation (billInfoManager)
- (void)HNetworkBillListCardId:(NSString *)cardId onCompletionBlock:(NetworkOperationCompletion)completionBlock;

- (void)HNetworkBillDetail:(NSDictionary *)paraDic onCompletionBlock:(NetworkOperationCompletion)completionBlock;
/**
 *  账单支付
 */
- (void)HNetWorkBillPay:(NSDictionary *)paraDic onCompletionBlock:(NetworkOperationCompletion)block;
@end

@interface HYNetworkOperation (HTradeListVC)
- (void)HNetworkTradeList:(NSDictionary *)paraDic onCompletionBlock:(NetworkOperationCompletion)completionBlock;

@end


@interface HYNetworkOperation (GroupManager)
/**
 *  获取群组列表
 */
- (void)HNetworkGroupList:(NSDictionary *)paraDic onCompletionBlock:(NetworkOperationCompletion)completionBlock;

/**
 *  群组创建
 */
- (void)HNetworkGroupCreate:(NSDictionary *)paraDic onCompletionBlock:(NetworkOperationCompletion)completion;
/**
 *  群组详情
 */
- (void)HNetworkGroupDetail:(NSDictionary *)paramDic onCompletionBlock:(NetworkOperationCompletion)completion;

/**
 *  群组添加用户
 */
- (void)hNetworkGroupAddUser:(NSDictionary *)paramDic onCompletionBlock:(NetworkOperationCompletion)completion;

/**
 *  群组删除用户
 */
- (void)hNetworkGroupDeleteUser:(NSDictionary *)paramDic onCompletionBlock:(NetworkOperationCompletion)completion;

/**
 *  群组名称修改
 */
- (void)HNetworkGroupNameModify:(NSDictionary *)paramDic onCompletionBlock:(NetworkOperationCompletion)completion;

/**
 *  群组设置
 */
- (void)HNetworkGroupSetting:(NSDictionary *)paramDic onCompletionBlock:(NetworkOperationCompletion)completion;

/**
 *  退出群组
 */
- (void)HNetworkQuitGroup:(NSDictionary *)paramDic onCompletionBlock:(NetworkOperationCompletion)completion;
@end


