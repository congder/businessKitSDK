//
//  AppUtils.h
//  TeamWork
//
//  Created by kongjun on 14-7-10.
//  Copyright (c) 2014年 Shenghuo. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "SVProgressHUD.h"
//#import "SVIndicator.h"
#import "MBProgressHUD.h"
#import "DistrictDetailsModel.h"
@class LocalUserInfoModelClass;

@interface AppUtils : NSObject
+ (id)sharedAppUtilsInstance;

//将图片压缩到合适的大小（最大尺寸1M）
- (NSData *) compressImageToProperSize:(UIImage *)image;

- (void)showHint:(NSString *)hint;

/**
 *  设置tableView分割线的内边距
 *
 *  @param tableView 参数
 */
- (void)tableViewSeparatorInsetZero:(UITableView *)tableView;

/**
 *  设置cell分割线的内边距
 *
 */
- (void)cellSeparatorInsetZero:(UITableViewCell *)cell;

// 检测网络是否活跃
-(BOOL)hasConnectivity;
//
//-(void)sendSocketLocalNotification:(NSString *)alertBody;
//
//- (NSString *)stringWithUUID;
//

///*删除数据库记录*/
//-(void)deleteDBTable;

/**
 *  @brief 获取view所属的ViewController
 *
 *  @param view
 *
 *  @return nil或view所属的ViewController
 */
- (UIViewController *) getCurrentViewController: (UIView*)view;

/**
 *  获取城势卡信息 保存到userdefaults中
 *
 *  @param completionBlock 回调
 */
- (void) getCardInfo: (void (^)(NSError *e))completionBlock;

/**
 *  根据民称获取银行优惠信息
 *
 *  @param 商品民称
 */
- (NSDictionary *) findBankDiscount: (NSString *)name;
- (void) doBankDiscountIcon: (NSDictionary *)data withImageView: (UIImageView *)imageView withIconName: (NSString *) iconName;
- (NSDictionary *) getBankDiscount: (int)discountType;
/**
 * 格式化webview加载的html字符串
 */
- (NSString *)formatHTML: (NSString *)desc;

- (BOOL)checkBankCardHasBind: (NSString *)_cardNo withBankCode: (NSString *)_bankCode withBankName: (NSString *)_bankName;
/**
 * 寻找功能列表
 */
- (NSDictionary *)getFunctionDataSource: (NSString *)key;
- (NSDictionary *)getFunctionDataSource: (NSString *)key withKeys: (NSSet<NSString *> *)keys;
- (NSDictionary *)getFunctionDataSource: (NSString *)key exceptKeys: (NSSet<NSString *> *)keys;
/**
 * 根据id判断该功能是否显示
 */
- (BOOL)checkFunctionIsShownWithId: (NSString *)kId;

/**
 *根据传入的类型进行实名化添加银行卡**
 */
#pragma mark - 添加银行卡校验实名化信息
- (BOOL) addBankCardInfoWithType:(NSString *)addType userName:(NSString *)userName idCardNum:(NSString *)idCard idType:(NSString *)idType;

-(void)saveDateInCacheWith:(NSString *)name idCard:(NSString *)idCard;
//修改是否实名化信息
- (void)changeIsSendUserName;


/**
 * 切换首页tab的index
 */
- (void)changeTabIndex: (int) index;
/**
 * 获取手机ip
 */
- (NSString *)deviceIPAdress;
/**
 * 添加tap手势
 */
- (UITapGestureRecognizer *)addTapGesture:(UIView *)view withTarget: (id) target withSelector: (SEL) selector;

/**
 * @brief 检验实名化信息
 * @param compareType
 * 0:精确匹配
 * 1:身份证号精确匹配,姓名模糊匹配
 * 2:身份证号模糊匹配,姓名精确匹配
 * 3:身份证号模糊匹配,姓名模糊匹配
 * 4:姓名模糊匹配
 * 5:姓名模糊匹配 未实名化,用于加油卡充值添加银行卡
 */
- (BOOL)checkRealNameInfo:(int)compareType userName:(NSString *)userName idCardNum:(NSString *)idCard;

/**
 * @brief 判断是否是优惠券
 */
- (BOOL) isCouponProduction: (DistrictDetailsModel *)dataModel;


/**
 * @brief 查找优惠券店铺中的所属店铺
 */
- (NSDictionary *)findBelongStore:(NSArray *)storeList;

/**
 * @brief 切换城市
 * @param cityId    城市ID
 * @param cityName 城市名称
 */
- (void)changeCity: (NSString *)cityId withName:(NSString *)cityName;
@end
