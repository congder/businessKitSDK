//
//  HYNetworkOperation.m
//  SmartCommunity
//
//  Created by haoyi on 14/12/14.
//  Copyright (c) 2014年 shenghuo. All rights reserved.
//

#import "HYNetworkOperation.h"
#import "APIOperation.h"
#import "HEncryptClass.h"
#import "3Des.h"
// TODO: - 临时保存
#define HAppInit                                @"/app/init"

@implementation HYNetworkOperation

+ (instancetype)shareInstance{
    static HYNetworkOperation *networkOperation;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkOperation = [[HYNetworkOperation alloc] init];
    });
    return networkOperation;
}

#pragma mark -
#pragma mark -AppDelegate
-(void)hNetworkInitApp:(NetworkOperationCompletion)completionBlock{
    
    [hEncrypt encryptAppInitParameter:^(NSDictionary *params){
        [APIOperation GET:HAppInit parameters:params onCompletion:^(id responseData, NSError* error) {
            completionBlock(responseData,error);
        }];
    }];
}
//
//-(void)hNetworkCheckLogin:(NetworkOperationCompletion)completionBlock{
//    [hEncrypt encryptUserCheckLoginParameter:^(NSDictionary *params){
//        [APIOperation GET:HAppUserCheckLogin parameters:params onCompletion:^(NSMutableDictionary *responseData, NSError* error){
//            completionBlock(responseData,error);
//        }];
//    }];
//}
//
//-(void)hNetworkCheckAppUpdate:(NSMutableDictionary *)parameters onCompletionBlock:(NetworkOperationCompletion)completionBlock{
//    [hEncrypt encryptAppVersionUpdateParameter:parameters onCompletionBlock:^(NSMutableDictionary *dic) {
//        [APIOperation GET:HAppVersionUpdate parameters:dic onCompletion:^(id responseData, NSError* error){
//            completionBlock(responseData,error);
//        }];
//    }];
//}
//
//-(void)hNetworkUpdateVersion:(NetworkOperationCompletion)completionBlock
//{
//    DLog(@"%@",[NSString stringWithFormat:@"%@",[mSystemConfigUtil getServerUDID]]);
//    [hEncrypt encryptAppInitParameter:^(NSMutableDictionary *params){
//        [params setObject:[mSystemConfigUtil getServerUDID] forKey:@"udid"];
//        [APIOperation GET:HAppUpdateVersion parameters:params onCompletion:^(id responseData, NSError* error) {
//            completionBlock(responseData,error);
//        }];
//    }];
//}
//
//-(void)hNetworkInitFriendList:(NetworkOperationCompletion)completionBlock{
//    [hEncrypt encryptFriendListParameter:^(NSDictionary *params){
//        [APIOperation GET:HAppFriendList parameters:params onCompletion:^(NSMutableDictionary *responseData, NSError* error) {
//            completionBlock(responseData,error);
//        }];
//    }];
//}
//#pragma mark -
//#pragma mark -MainPage
//-(void)hNetworkGetNewsList:(NSDictionary *)parameters onCompletionBlock:(NetworkOperationCompletion)completionBlock{
//    [hEncrypt encryptAppGetNewsListParameter:parameters onCompletion:^(NSDictionary *params){
//        [APIOperation GET:HAppNewsList parameters:params onCompletion:^(NSMutableDictionary *responseData, NSError* error){
//            completionBlock(responseData,error);
//        }];
//    }];
//}
//
//-(void)hNetworkGetHotGroupList:(NetworkOperationCompletion)completionBlock{
//    [hEncrypt encryptAppGetHotGroupListParameter :^(NSDictionary *params){
//        [APIOperation GET:HAppTeamGetHotList parameters:params onCompletion:^(NSMutableDictionary *responseData, NSError* error){
//            completionBlock(responseData,error);
//        }];
//    }];
//}
//-(void)hNetworkGetCommunityDynamic:(NSDictionary *)parameters onCompletionBlock:(NetworkOperationCompletion)completionBlock{
//    [hEncrypt encryptAppGetNewsListParameter:parameters onCompletion:^(NSDictionary *params){
//        [APIOperation GET:HAppDynamiLlist parameters:params onCompletion:^(NSMutableDictionary *responseData, NSError* error){
//            completionBlock(responseData,error);
//        }];
//    }];
//}
//
//-(void)hNetworkGetDynamicDetail:(NSString *)dyId onCompletionBlock:(NetworkOperationCompletion)completionBlock{
//    [hEncrypt encryptAppGetDyDetailParameter:dyId onCompletion:^(NSDictionary *params){
//        [APIOperation GET:HAppDynamicDetail parameters:params onCompletion:^(NSMutableDictionary *responseData, NSError* error){
//            completionBlock(responseData,error);
//        }];
//    }];
//}
//
//-(void)hNetworkDelDynamic:(NSString *)dyId onCompletionBlock:(NetworkOperationCompletion)completionBlock{
//    [hEncrypt encryptAppDeleteDyParameter:dyId onCompletion:^(NSDictionary *params){
//        [APIOperation GET:HAppDeleteDynamic parameters:params onCompletion:^(NSMutableDictionary *responseData, NSError* error){
//            completionBlock(responseData,error);
//        }];
//    }];
//}
//
//
//#pragma mark -
//#pragma mark - 动态获取首页图标
//- (void)getDynamicMainFunctionList:(NSDictionary *)paraDic onCompletionBlock:(NetworkOperationCompletion)completionBlock
//{
//    [hEncrypt encryptDynamicMainFunction:paraDic onCompletion:^(NSDictionary *dic) {
//        [APIOperation GET:MainDynamicFunctionList parameters:dic onCompletion:^(NSMutableDictionary *responseData, NSError* error){
//            completionBlock(responseData,error);
//        }];
//    }];
//}
//
//#pragma mark -
//#pragma mark -NewsView
//-(void)hNetworkGetNewsBannerList:(NSDictionary *)paraDic onCompletionBlock:(NetworkOperationCompletion)completionBlock
//{
//    [hEncrypt encryptAppGetNewsListParameter:paraDic onCompletion:^(NSDictionary *params){
//        [APIOperation GET:HAppNewsBannerList parameters:params onCompletion:^(NSMutableDictionary *responseData, NSError* error){
//            completionBlock(responseData,error);
//        }];
//    }];
//}
//
//-(void)hNetworkGetSendDynamic:(NSString *)content onCompletionBlock:(NetworkOperationCompletion)completionBlock{
//    [hEncrypt encryptsendDynamicParameter:content onCompletion:^(NSDictionary *params) {
//        [APIOperation GET:HAppCommunityPubDynamic parameters:params onCompletion:^(NSMutableDictionary *responseData, NSError* error){
//            completionBlock(responseData,error);
//        }];
//    }];
//}
//
//- (void)HNetworkCreatDynamic:(NSDictionary *)dynamicDic  imageDic:(NSDictionary *)imageDic onCompletionBlock:(NetworkOperationCompletion)completionBlock{
//    
//    [hEncrypt encryptCreateDynamicParameter:dynamicDic onCompletion:^(NSDictionary *parameter) {
//        NSArray *allKey = [parameter allKeys];
//        NSMutableString *parameterStr = [NSMutableString new];
//        for (NSString *key in allKey) {
//            if (parameterStr.length == 0) {
//                [parameterStr appendString:[NSString stringWithFormat:@"%@=%@", key, [parameter objectForKey:key]]];
//            }else{
//                [parameterStr appendString:[NSString stringWithFormat:@"&%@=%@", key, [parameter objectForKey:key]]];
//            }
//        }
//        
//        NSString *url = [NSString stringWithFormat:@"%@?%@", HAppCommunityCreateDynamic, parameterStr];
//        NSString *strUrl = [url stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
//        
//        [APIOperation uploadMutipleMedia:strUrl parameters:imageDic onCompletion:^(id responseData, NSError *error) {
//            completionBlock(responseData, error);
//        }];
//    }];
//}
//
//- (void)hNetworkCheckLikedNewsId:(NSString *)newsId CompletionBlock:(NetworkOperationCompletion)completionBlock;{
//    [hEncrypt encryptNewsCheckLikesParameter:newsId onCompletionBlock:^(NSDictionary *params) {
//        [APIOperation GET:HAppNewsCheckLike parameters:params onCompletion:^(id responseData, NSError *error) {
//            completionBlock(responseData, error);
//        }];
//    }];
//}
//
//#pragma mark -
//#pragma mark - HCommentsListVC
//-(void)hNetworkGetMsgsList:(NSDictionary *)parameters onCompletionBlock:(NetworkOperationCompletion)completionBlock{
//    [hEncrypt encryptAppGetMsgsListParameter:parameters onCompletion:^(NSDictionary *params){
//        [APIOperation GET:HAppMsgList parameters:params onCompletion:^(NSMutableDictionary *responseData, NSError* error){
//            completionBlock(responseData,error);
//        }];
//    }];
//}
//#pragma mark -
//#pragma mark - HCommunityDyVC
//-(void)hNetworkDynamicCheckLiked:(NSString *)dynamicId onCompletionBlock:(NetworkOperationCompletion)completionBlock{
//     [hEncrypt encryptAppDynamicCheckLikedParameter:dynamicId onCompletion:^(NSDictionary *params) {
//         [APIOperation GET:HAppDynamicCheckLiked parameters:params onCompletion:^(NSMutableDictionary *responseData, NSError* error){
//             completionBlock(responseData,error);
//         }];
//     }];
//}
//
//-(void)hNetworkDynamicLikes:(NSDictionary *)dynamicDic onCompletionBlock:(NetworkOperationCompletion)completionBlock{
//    [hEncrypt encryptAppDynamicLikesParameter:dynamicDic onCompletion:^(NSDictionary *params) {
//        [APIOperation GET:HAppDynamicLikes parameters:params onCompletion:^(NSMutableDictionary *responseData, NSError* error){
//            completionBlock(responseData,error);
//        }];
//    }];
//}
//#pragma mark -
//#pragma mark -HAlbumVC
//-(void)hNetworkPhotoIndex:(NSDictionary *)photoIndexDic onCompletionBlock:(NetworkOperationCompletion)completionBlock{
//    [hEncrypt encryptAppPhotoIndexParameter:photoIndexDic onCompletion:^(NSDictionary *params) {
//        [APIOperation GET:HAppPhotoIndex parameters:params onCompletion:^(NSMutableDictionary *responseData, NSError* error){
//            completionBlock(responseData,error);
//        }];
//    }];
//}
//#pragma mark -
//#pragma mark -HCommentsList
//-(void)hNetworkDyDelComment:(NSString *)DyId onCompletionBlock:(NetworkOperationCompletion)completionBlock{
//    [hEncrypt encryptAppDynamicDelCommentParameter:DyId onCompletion:^(NSDictionary *params) {
//        [APIOperation GET:HAppDynamicDelComment parameters:params onCompletion:^(NSMutableDictionary *responseData, NSError* error){
//            completionBlock(responseData,error);
//        }];
//    }];
//}
//
//#pragma mark -
//#pragma mark -BusCard
////公交公告
//- (void)networkGetNoticeList:(NSDictionary *)parameters onCompletionBlock:(NetworkOperationCompletion)completionBlock
//{
//    [hEncrypt encryptBusCardNoticeList:parameters onCompletion:^(NSDictionary *dic) {
//        [APIOperation GET:GetNoticeList parameters:dic onCompletion:^(id responseData, NSError *error) {
//            completionBlock(responseData,error);
//        }];
//    }];
//}
//
//// 消费记录列表
//- (void)getConsumeRecordListParameters:(NSDictionary *)paraDic onCompletionBlock:(NetworkOperationCompletion)completionBlock
//{
////    [hEncrypt encryptChargeRecordList:paraDic onCompletion:^(NSDictionary *dic) {
//    
//        [APIOperation GET:GetConsumeRecordList parameters:paraDic onCompletion:^(id responseData, NSError *error) {
//            completionBlock(responseData,error);
//        }];
////    }];
//}
//
//// 充值记录查询
//- (void)getChargeRecordListParameters:(NSDictionary *)paraDic onCompletionBlock:(NetworkOperationCompletion)completionBlock
//{
////    [hEncrypt encryptChargeRecordList:paraDic onCompletion:^(NSDictionary *dic) {
//        [APIOperation GET:GetchargeRecordList parameters:paraDic onCompletion:^(id responseData, NSError *error) {
//            completionBlock(responseData,error);
//        }];
////    }];
//}
//
//
//
//
//
//
//
//
//#pragma mark -
//#pragma mark - HAddShtCard
//-(void)hNetworkAccountCardCheck:(NSString *)cardId onCompletionBlock:(NetworkOperationCompletion)completionBlock{
//    [hEncrypt encryptAccountCardCheckParameter:cardId onCompletion:^(NSDictionary *params) {
//        [APIOperation GET:HAppUserAccountCardCheck parameters:params onCompletion:^(NSMutableDictionary *responseData, NSError* error){
//            completionBlock(responseData,error);
//        }];
//    }];
//}
//
//#pragma mark -
//#pragma mark - HAppUserAccountCardSendMsg
//-(void)hNetworkAccountCardSendMsg:(NSString *)cardId onCompletionBlock:(NetworkOperationCompletion)completionBlock
//{
//    [hEncrypt encryptAccountCardCheckParameter:cardId onCompletion:^(NSDictionary *params) {
//        
//        [APIOperation GET:HAppUserAccountCardSendMsg parameters:params onCompletion:^(NSMutableDictionary *responseData, NSError* error){
//            completionBlock(responseData,error);
//        }];
//    }];
//}
//
//#pragma mark -
//#pragma mark - HAppUserAccountCardBind
//-(void)hNetworkAccountCardBind:(NSDictionary *)paraDic onCompletionBlock:(NetworkOperationCompletion)completionBlock
//{
//    [hEncrypt encryptAccountCardBindParameter:paraDic onCompletion:^(NSDictionary *params) {
//        
//        [APIOperation GET:HAppUserAccountCardBind parameters:params onCompletion:^(NSMutableDictionary *responseData, NSError* error){
//            completionBlock(responseData,error);
//        }];
//    }];
//}
//
//#pragma mark -
//#pragma mark - HAppUserAccountCardList
//-(void)hNetworkAccountCardList:(NetworkOperationCompletion)completionBlock{
//    [hEncrypt encryptAccountCardList:^(NSDictionary *params) {
//        
//        [APIOperation GET:HAppUserAccountCardList parameters:params onCompletion:^(NSMutableDictionary *responseData, NSError* error){
//            completionBlock(responseData,error);
//        }];
//    }];
//}
//
//#pragma mark -
//#pragma mark - HAppUserAccountCardUnbind
//-(void)hNetworkAccountCardUnbind:(NSString *)cardId onCompletionBlock:(NetworkOperationCompletion)completionBlock
//{
//    [hEncrypt encryptAccountCardUnbindParameter:cardId onCompletion:^(NSDictionary *params){
//        [APIOperation GET:HAppUserAccountCardUnbind parameters:params onCompletion:^(NSMutableDictionary *responseData, NSError* error){
//            completionBlock(responseData,error);
//        }];
//    }];
//}
//
//-(void)hNetworkAccountCardBalance:(NSString *)cardId onCompletionBlock:(NetworkOperationCompletion)completionBlock{
//    [hEncrypt encryptAccountCardUnbindParameter:cardId onCompletion:^(NSDictionary *params){
//        
//        [APIOperation GET:HAppUserAccountCardBalance parameters:params onCompletion:^(NSMutableDictionary *responseData, NSError* error){
//            completionBlock(responseData,error);
//        }];
//    }];
//}
//
//#pragma mark -
//#pragma mark - HAppUserOfficeHolder
//-(void)hNetworkUserOfficeHolder:(NetworkOperationCompletion)completionBlock{
//    [hEncrypt encryptUserOfficeHolder:^(NSDictionary *params) {
//        [APIOperation GET:HAppUserOfficeHolder parameters:params onCompletion:^(NSMutableDictionary *responseData, NSError* error){
//            completionBlock(responseData,error);
//        }];
//    }];
//}
//@end
//
//@implementation HYNetworkOperation (HUserManager)
//
//- (void)hNetWorkAccountSearchUserInfo:(NSDictionary *)paramsDic onCompletionBlock:(NetworkOperationCompletion)completion{
//    [hEncrypt encryptUserSearchInfo:paramsDic onCompletion:^(NSDictionary *params) {
//       [APIOperation GET:HAppUserSearch parameters:params onCompletion:^(id responseData, NSError *error) {
//           completion(responseData, error);
//       }];
//    }];
//}
//
//- (void)hNetworkAccountAddUser:(NSDictionary *)paramDic onCompletionBlock:(NetworkOperationCompletion)completion{
//    [hEncrypt tokenEncryptParameter:paramDic encryptKey:@[@"fid"] onCompletion:^(NSDictionary *params) {
//       [APIOperation GET:HAppFriendAdd parameters:params onCompletion:^(id responseData, NSError *error) {
//           completion(responseData, error);
//       }];
//    }];
//}
//
///**
// *  请求添加的新好友列表
// */
//- (void)hNetworkAccountAskFriendList:(NSDictionary *)paramDic onCompletionBlock:(NetworkOperationCompletion)completion{
//    [hEncrypt tokenEncryptParameter:paramDic encryptKey:@[] onCompletion:^(NSDictionary *params) {
//        [APIOperation GET:HAppAskFriendList parameters:params onCompletion:^(id responseData, NSError *error) {
//            completion(responseData, error);
//        }];
//    }];
//}
//
///**
// *  对请求添加好友的确认与忽略处理
// */
//- (void)hNetworkAccountConfirmFriend:(NSDictionary *)paramDic onCompletionBlock:(NetworkOperationCompletion)completion{
//    [hEncrypt tokenEncryptParameter:paramDic encryptKey:@[@"fid",@"state"] onCompletion:^(NSDictionary *params) {
//       [APIOperation GET:HAppConfirmFriend parameters:params onCompletion:^(id responseData, NSError *error) {
//           completion(responseData, error);
//       }];
//    }];
//}
//
//- (void)hNetworkSetUserRemark:(NSDictionary *)paraDic onCompletionBlock:(NetworkOperationCompletion)completion{
//    [hEncrypt tokenEncryptParameter:paraDic encryptKey:@[@"fid"] onCompletion:^(NSDictionary *params) {
//       [APIOperation GET:HAppFriendRemark parameters:params onCompletion:^(id responseData, NSError *error) {
//           completion(responseData, error);
//       }];
//    }];
//}
//@end
//
//
//@implementation HYNetworkOperation (HChangeUserMsg)
//
//#pragma mark  获取服务端省市区列表
//- (void)networkGetProvinceList:(NSDictionary *)parameters onCompletionBlock:(NetworkOperationCompletion)completionBlock
//{
//    [APIOperation GET:GetRegionList parameters:parameters onCompletion:^(id responseData, NSError *error) {
//        completionBlock(responseData,error);
//    }];
//}
//
//#pragma mark 读取地址列表
//- (void)networkGetAddressList:(NSDictionary *)paraDic onCompletionBlock:(NetworkOperationCompletion)completionBlock
//{
//    [hEncrypt encryptAddressListParameters:paraDic onCompletion:^(NSDictionary *dic) {
//        [APIOperation GET:GetAddressList parameters:dic onCompletion:^(id responseData, NSError *error) {
//            completionBlock(responseData,error);
//        }];
//    }];
//}
//
//#pragma mark <读取默认地址>
//- (void)networkGetDefaultsAddress:(NSDictionary *)paraDic onCompletionBlock:(NetworkOperationCompletion)completionBlock
//{
//    [hEncrypt encryptDefaultAddressParameters:paraDic onCompletion:^(NSDictionary *dic) {
//        [APIOperation GET:GetDefaultsAddrsss parameters:dic onCompletion:^(id responseData, NSError *error) {
//            completionBlock(responseData,error);
//        }];
//        
//    }];
//}
//
//#pragma mark  保存地址  <添加>
//- (void)networkAddAddress:(NSDictionary *)paraDic onCompletionBlock:(NetworkOperationCompletion)completionBlock
//{
//    [hEncrypt encryptAddressParameters:paraDic onCompletion:^(NSDictionary *dic) {
//        [APIOperation GET:AddAddress parameters:dic onCompletion:^(id responseData, NSError *error) {
//            completionBlock(responseData,error);
//        }];
//    }];
//}
//
//// <更改地址>
//- (void)updateAddress:(NSDictionary *)paraDic onCompletionBlock:(NetworkOperationCompletion)completionBlock
//{
//    
//}
//
//
//@end
//
//
//@implementation HYNetworkOperation(billInfoManager)
//- (void)HNetworkBillListCardId:(NSString *)cardId onCompletionBlock:(NetworkOperationCompletion)completionBlock{
//    [hEncrypt encryptAccountCardUnbindParameter:cardId onCompletion:^(NSDictionary *params) {
//       [APIOperation GET:HAppUserAccountBillList parameters:params onCompletion:^(id responseData, NSError *error) {
//           completionBlock(responseData, error);
//       }];
//    }];
//}
//
//- (void)HNetworkBillDetail:(NSDictionary *)paraDic onCompletionBlock:(NetworkOperationCompletion)completionBlock{
//    [hEncrypt encryptAccountBillDetailParameter:paraDic onCompletion:^(NSDictionary *params) {
//       [APIOperation GET:HAppUserAccountBillDetail parameters:params onCompletion:^(id responseData, NSError *error) {
//           completionBlock(responseData, error);
//       }];
//    }];
//}
//
//- (void)HNetWorkBillPay:(NSDictionary *)paraDic onCompletionBlock:(NetworkOperationCompletion)block{
//    [hEncrypt encryptAccountBillPayParameter:paraDic onCompletion:^(NSDictionary *params) {
//        [APIOperation GET:HAPPUserAccountBillPay parameters:params onCompletion:^(id responseData, NSError *error) {
//            block(responseData, error);
//        }];
//    }];
//}
//@end
//
//@implementation HYNetworkOperation(HTradeListVC)
//- (void)HNetworkTradeList:(NSDictionary *)paraDic onCompletionBlock:(NetworkOperationCompletion)completionBlock{
//    [hEncrypt encryptAccountTradeListParameter:paraDic onCompletion:^(NSDictionary *params) {
//        [APIOperation GET:HAppUserAccountTradeList parameters:params onCompletion:^(id responseData, NSError *error) {
//            completionBlock(responseData, error);
//        }];
//    }];
//}
//@end
//
////群组相关处理
//@implementation HYNetworkOperation(GroupManager)
//
//- (void)HNetworkGroupList:(NSDictionary *)paraDic onCompletionBlock:(NetworkOperationCompletion)completionBlock{
//    [hEncrypt tokenEncryptParameter:paraDic encryptKey:@[] onCompletion:^(NSDictionary *params) {
//        [APIOperation GET:HAppGroupGetList parameters:params onCompletion:^(id responseData, NSError *error) {
//            completionBlock(responseData, error);
//        }];
//    }];
//}
//
//- (void)HNetworkGroupCreate:(NSDictionary *)paraDic onCompletionBlock:(NetworkOperationCompletion)completion{
//    [hEncrypt tokenEncryptParameter:paraDic encryptKey:@[@"fids"] onCompletion:^(NSDictionary *params) {
//        [APIOperation GET:HAppGroupCreate parameters:params onCompletion:^(id responseData, NSError *error) {
//            completion(responseData, error);
//        }];
//    }];
//}
//
//- (void)HNetworkGroupDetail:(NSDictionary *)paramDic onCompletionBlock:(NetworkOperationCompletion)completion{
//    [hEncrypt tokenEncryptParameter:paramDic encryptKey:@[@"team_id"] onCompletion:^(NSDictionary *params) {
//        [APIOperation GET:HAppGroupGetInfo parameters:params onCompletion:^(id responseData, NSError *error) {
//            completion(responseData, error);
//        }];
//    }];
//}
//
//- (void)hNetworkGroupAddUser:(NSDictionary *)paramDic onCompletionBlock:(NetworkOperationCompletion)completion{
//    [hEncrypt tokenEncryptParameter:paramDic encryptKey:@[@"team_id",@"fids"] onCompletion:^(NSDictionary *params) {
//       [APIOperation GET:HAppGroupAddUser parameters:params onCompletion:^(id responseData, NSError *error) {
//           completion(responseData, error);
//       }];
//    }];
//}
//
//- (void)hNetworkGroupDeleteUser:(NSDictionary *)paramDic onCompletionBlock:(NetworkOperationCompletion)completion{
//    [hEncrypt tokenEncryptParameter:paramDic encryptKey:@[@"team_id",@"fids"] onCompletion:^(NSDictionary *params) {
//        [APIOperation GET:HAppGroupDeleteUser parameters:params onCompletion:^(id responseData, NSError *error) {
//            completion(responseData, error);
//        }];
//    }];
//}
//
//
//- (void)HNetworkGroupNameModify:(NSDictionary *)paramDic onCompletionBlock:(NetworkOperationCompletion)completion{
//    [hEncrypt tokenEncryptParameter:paramDic encryptKey:@[@"team_id"] onCompletion:^(NSDictionary *params) {
//        [APIOperation GET:HAppGroupNameModify parameters:params onCompletion:^(id responseData, NSError *error) {
//            completion(responseData, error);
//        }];
//    }];
//}
//
//- (void)HNetworkGroupSetting:(NSDictionary *)paramDic onCompletionBlock:(NetworkOperationCompletion)completion{
//    [hEncrypt tokenEncryptParameter:paramDic encryptKey:@[@"team_id"] onCompletion:^(NSDictionary *params) {
//       [APIOperation GET:HAppGroupInfoSetting parameters:params onCompletion:^(id responseData, NSError *error) {
//           completion(responseData, error);
//       }];
//    }];
//}
//
//- (void)HNetworkQuitGroup:(NSDictionary *)paramDic onCompletionBlock:(NetworkOperationCompletion)completion{
//    [hEncrypt tokenEncryptParameter:paramDic encryptKey:@[@"team_id"] onCompletion:^(NSDictionary *params) {
//        [APIOperation GET:HAppGroupLogout parameters:params onCompletion:^(id responseData, NSError *error) {
//            completion(responseData, error);
//        }];
//    }];
//}
@end
