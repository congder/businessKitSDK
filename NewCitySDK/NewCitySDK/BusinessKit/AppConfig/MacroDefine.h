//
//  MacroDefine.h
//  smartcity
//
//  Created by kongjun on 13-10-21.
//  Copyright (c) 2013年 Shenghuo. All rights reserved.
//


//#import "AppDelegate.h"
//#import "AFHTTPClientForiOS6OrLower.h"
//#import "AFHTTPClientUtil.h"
#import "AppUtils.h"
#import "SystemConfigUtil.h"
#import "HEncryptClass.h"
//#import "HUserManagementClass.h"
//#import "DataBaseUtil.h"
//#import "HAppCache.h"
//#import "ImageManager.h"
//#import "HYNetworkOperation.h"
//#import "NSString+StringSize.h"
//#import "UIImageView+WebCache.h"
//#import "NSDate+Category.h"
//#import "NSDateFormatter+Category.h"
//#import "HObjectToJson.h"
//#import "HGetAllFriends.h"
#import "HYNetworkOperation.h"
#import "Masonry.h"

/*--------------------------------开发中常用到的宏定义--------------------------------------*/

#define IOS_VERSION_7_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)? (YES):(NO))

//系统目录
#define kDocuments  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

#define isIos7      ([[[UIDevice currentDevice] systemVersion] floatValue])
#define StatusbarSize ((isIos7 >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)?20.f:0.f)
#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]

//magical Record short hand
#define MR_SHORTHAND
//图片最大上传大小
#define kMaxImageUploadSize (200*1024)
#define KMaxLongImageUploadSize (1024*1024)
#define kMESImageQuality 0.8 //图片压缩比例

#define kBundleId   [[NSBundle mainBundle] bundleIdentifier]


#define UMENG_APPKEY @"5729a64ce0f55abe2e0007f5"
//#define UMENG_APPKEY @"572960fb67e58e59050019b6"  //appstore umeng app key
#define UMENG_channelId @"Dev-SmartCity"
//
#define HServerDESKEY  @"FhzhyeXDqghfve4jRGg4PJizwJwkCSQD"

/********************用于更新app版本************************/
#define kAppVersion @"version_teamwork"
#define kAppVersionForceUpdate @"versionForceUpdate_teamwork"
#define kAppDownloadUrl  @"downloadUrl_teamwork"
#define kRemoteVersionsPlistURL @"http://tw.ztgame.com/down/TeamWorkVersion.plist"
#define kRemoteVersionUpdateURL @"http://tw.ztgame.com/down"


///****************navigation push进来,用户pop回哪个界面**********************/

typedef enum {
    HPopToRootView,
    HPopView,
    HPopToOther
}HPopToView;

//----------方法简写-------
#define mAppDelegate        ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define mWindow             [[[UIApplication sharedApplication] windows] lastObject]
#define mKeyWindow          [[UIApplication sharedApplication] keyWindow]
#define mUserDefaults       [NSUserDefaults standardUserDefaults]
#define mNotificationCenter [NSNotificationCenter defaultCenter]
#define mAFHTTPClient(urlString)       [AFHTTPClientUtil sharedClient:urlString]
#define mAPIClient          [AFAppDotNetAPIClient sharedClient]
#define mSystemConfigUtil   [SystemConfigUtil sharedSystemConfigUtil]
#define mAFHTTPClientForiOS6OrLower(urlString) [AFHTTPClientForiOS6OrLower sharedClient:urlString]
#define mAppUtils           [AppUtils sharedAppUtilsInstance]


#define mAppCache           [LocalCache sharedCache]
#define mDataBase           [DataBaseUtil shareInstance]
#define hEncrypt            [HEncryptClass sharedHEncryptClassInstance]
#define hUserManagement     [HUserManagementClass shareInstance];
#define hNetWorkOperation   [HYNetworkOperation shareInstance]
#define hGetAllFriends      [HGetAllFriends shareInstance]
//----------页面设计相关-------

//----------本地化相关--------

#define mLocalization(key, ...)     [NSString stringWithFormat: [[NSBundle mainBundle] localizedStringForKey:key value:@"" table:@"Localization"], ##__VA_ARGS__, nil]

#define mNavBarHeight         (self.navigationController.navigationBar.height)
#define mTabBarHeight         (self.tabBarController.tabBar.height)
#define mStatusBarHeight      ([UIApplication sharedApplication].statusBarFrame.size.height)
#define mSlideBarHeight       40.0f
#define mScreenWidth          ([UIScreen mainScreen].bounds.size.width)
#define mScreenHeight         ([UIScreen mainScreen].bounds.size.height)
#define mKeyboardHight        216//iPhone 6之后要注意重新判断
#define mAvatarDefaultSize    @"-70-70"//服务器 返回的头像默认尺寸

#define hCollectionViewSize   mScreenWidth*0.0625
#define hQRCodeMargin         mScreenWidth*0.0625
#define hQRCodeBgViewHeight   (mScreenHeight > 480?mScreenHeight*0.67-50:mScreenHeight*0.67)
#define hQRCodeAvatarSize     55

/***标题字体颜色***/
#define hTitleTextColor     mRGBColor(74 , 74 , 74)
/****按钮默认选取的字体颜色***/
#define hButtonSeleDefaultColor  mRGBColor(65, 131, 248)

#define hLabelWidth           mScreenWidth*0.65
#define hImagePlayerViewHeight 120

#define hReplyTextViewWidth   mScreenWidth - contentPadding - 15

//首页动态最多个数
#define HNumberOfRows                   10
//查询单页个数
#define HOrderChackNumber               10
//控制首页新闻和动态的条数
#define HShowNewsLimit                  @"5"
//控制政务时事等下拉加载的新闻条数
#define HAllLimit                       @"15"

// 首页默认功能列表
#define DefaultFuncList                 @"defaultFuncList"
// 首页功能列表
#define HeaderFuncList                  @"headerfunctionList"

// 首页图标大小
#define ItemWidth   60
#define ItemHeight  60

//验证码倒计时时间
#define HTimeCoutDown 59
//验证码长度控制
#define HCodeLength 6
//社区电话
#define HCommunityPhoneNum @"0433-2616369"

//web请求错误码
#define     STR_CONNECT_SUC              @"0" //成功
#define     STR_CONNECT_UNUSUAL          @"1" //服务异常（udid和社区id为空）
#define     STR_CONNECT_NETERROR         @"2" //网络较差，请稍后重试（没有网络）
#define     STR_CONNECT_SERVERERROR      @"3" //服务器出错，稍后重试（其他任何情况）

#define     STR_CONNECT_SUC_STR           @"成功" //成功
#define     STR_CONNECT_UNUSUAL_STR       @"服务异常"//1 //服务异常（udid和社区id为空）
#define     STR_CONNECT_NETERROR_STR      @"网络较差,请稍后重试"//2 //网络较差，请稍后重试（没有网络）
#define     STR_CONNECT_SERVERERROR_STR   @"服务器出错,稍后重试"//3 //服务器出错，稍后重试（其他任何情况）
#define     STR_CONNECT_NETWORK_TIP_STR   @"网络环境差"




#define mAlertAPIErrorInfo(error)  [mAppUtils showHint:[[error.userInfo objectForKey:ERRORMSG] length]>0?[error.userInfo objectForKey:ERRORMSG] :kNetWorkUnReachableDesc]
#define mAlertMsgAPIErrorInfo(error) \
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[[error.userInfo objectForKey:ERRORMSG] length]>0?[error.userInfo objectForKey:ERRORMSG] :kNetWorkUnReachableDesc delegate:nil \
cancelButtonTitle:@"确定" \
otherButtonTitles:nil]; \
[alert show];

#define nilOrJSONObjectForKey(JSON_, KEY_) [[JSON_ objectForKey:KEY_] isKindOfClass:[NSNull class]] ? @"" : [JSON_ objectForKey:KEY_]

#define mCommonAskAlert(msg)   [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:mLocalization(@"common_cancle") otherButtonTitles:mLocalization(@"common_makesure"), nil];
#define mCommonAlert(msg)   [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:mLocalization(@"common_makesure"), nil];

//版本号更好地区分不同的UDID
#define APPUDID                         [NSString stringWithFormat:@"%@APPUDID",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]
//一些系统相关的
#define RSA_PUBLICK_KEY                 @"RSA_PUBLICK_KEY"
#define NOTIFICATION_TOKEN              @"NOTIFICATION_TOKEN"
#define PHONE_NUMBER                    @"PHONE_NUMBER"
#define GESTURE_CODE                    @"GESTURE_CODE"
#define PAY_PWD_STATUS                  @"PAY_PWD_STATUS"
#define NEED_ACTIVE_FLAG                @"NEED_ACTIVE_FLAG"
#define USER_ACTIVE_STATUS              @"USER_ACTIVE_STATUS"

//记录升级前的版本号appVesion
#define HTheLastAppVersion              @"theLastAppVersion"

//电影搜索存储数组
#define HHistoryArr                 @"historyArr"

//全国代码
#define WholeCountryCode                @"100000"
//AppInit 接口返回的用户相关数据存储
#define HCurrentUDID                @"udid"
#define HCurrentAccount             @"account"
#define HCurrentSex                 @"sex"
#define HCurrentUid                 @"uid"
#define HCurrentNickname            @"nickname"
#define HCurrentSign                @"sign"
#define HCurrentAvatar              @"userAvatar"
#define HUserAddress                @"userAddress"
#define HCurrentToken               @"token"
#define HCurrentImToken             @"im_token"
#define HUserLogin                  @"userLogin"
#define HResetUdid                  @"resetUdid"
//实名化校验存储用户真实姓名
#define HUserRealName               @"userRealName"
//实名化身份证号码
#define HUserIdCardNum              @"idCardNum"
//实名化证件类型
#define HUserIdType                 @"idType"
//用户是否实名化
#define HUserIsSendRealName         @"userIsSendRealName"

//加油卡返回来的姓名
#define HFuelFillingCardName         @"fuelFillingCardNam"

#define Hcityid                     @"city_id"
#define HLIFECARD                   @"lifeCard"
#define HLIFEUID                    @"lifeUid"
#define HCITY                       @"city"

/****城市变更****/
#define HCurrentCityChanged         @"cityChanged"

#define CHECK_LOGIN_IN if (![mUserDefaults boolForKey:HUserLogin]) {[mAppDelegate presentLoginVc]; return;}

#define HCommunityDyCount           @"communityDyCount"
#define HReplyNoftiyAvatar          @"replyNoftiyAvatar"
//智慧城市相关
#define HCurrentBankCardNum         @"bankCardNum"
#define HCurrentshenghuotongCardNum           @"shenghuotongCardNum"
//系统通知类型
#define HSystemNotifyAddFriend          1
#define HSystemNotifyAddGroup           2
#define HSystemNotifyAddFriendSuc       3
#define HSystemNotifyMemOutGroup        6

#define HSystemNotifyFriendInvited          4       //添加好友-通知被邀请人
#define HSystemNotifyAddFriendRejected      5       //添加好友-通知添加人被拒绝'

#define HSystemNotifyCreateGroupOwer        10      //创建群组————>提示创建者
#define HSystemNotifyCreateGroupOther       11      //创建群组————>提示其他被邀请者
#define HSystemNotifyQuitGroup              12      //退出群组————>提示群组成员
#define HSystemNotifyGroupAdd_invite        13      //添加群组成员————>提示邀请者
#define HSystemNotifyGroupAdd_other         14      //添加群组成员————>提示其他用户
#define HSystemNotifyGroupAdd_invited       15      //添加群组成员————>提示被邀请者
#define HSystemNotifyGroupName_ower         16      //群组名称修改————>提示修改者
#define HSystemNotifyGroupName_other        17      //群组名称修改————>提示其他群成员
#define HSystemNotifyGroupRemark_ower       18      //修改nickname————>提示修改者
#define HSystemNotifyGroupRemark_other      19      //修改nickname————>提示其他群组成员
#define HSystemNotifyCommunityDy            20
#define HSystemNotifyGroupRemoved           21      //被移除提醒——————》提醒被删除人
#define HSystemNotifyCreateGroupNoFriend    22      //通知添加者需要好友验证
#define HSystemNotifyGroupNicknameShow      23      //自动开启群昵称

//通知中心名称
#define HChangeCity                 @"changeCity"
#define HChangeCommunity            @"changeCommunity"
#define HReSetCommunity             @"reSetCommunity"
#define HReloadFriendList           @"reloadFriendList"
#define HChangeHeadImage            @"changeHeadImage"
#define HChangeUserSign             @"changeUserSign"
#define HChangeUserDetail           @"changeUserDetail"
#define HChangeUserAddress          @"changeUserAddress"//默认地址
#define QUpdateUserAddress          @"updateUserAddress"
#define QUpAddUserAddress           @"qupdateUserAddress"//新建收货地址
#define QDeleteUserAddress          @"deleteUserAddress"
#define QDeleteDefaultUserAddress   @"deleDefaultUserAddress"//删除默认收货地址

#define HshangQuanReload              @"HshangQuanReload"

#define HRecentContactRemove        @"recentContactRemove"
#define HGroupNameModifySuccess     @"groupNameModifySuccess"
#define HMainPageReload             @"mainPageReload"
#define HInitFriendsList            @"initFriendsList"
#define HDismissBgView              @"dismissBgView"
#define HNotifReloadDyList          @"ReloadDyList"
#define HNotifDeleteDy              @"deleteDy"
#define HNotifReloadDyCell          @"ReloadDyCell"
#define HNotifDyReplyCount          @"dyReplyCount"
#define HDatePara                   @"hello"//用来表示是否有重复的时间

#define LoginOrLogout                @"Login/Logout"
// 更换收货地址
#define QChangeRecevieAddres        @"changeReceiveAddress"

//抽奖进入类型
#define CEntranceNormalPay          @"normal_pay"
#define CEntranceFilmPay            @"film_pay"
#define CEntranceRegister           @"register"
#define CEntranceWalletRecharge     @"wallet_recharge"
#define CEntranceFeesPay            @"fees_pay"

//商圈通知
#define HDisTableViewReload         @"HDisTableViewReload"
#define HDisNumberReload            @"HDisNumberReload"

//单个商品点击数量变更
#define SINGALPRODUCTNUMCHANGE      @"SINGALPRODUCTNUMCHANGE"

// 添加缴费->选取缴费机构通知
#define PaymentAddOrgNotice         @"chooseOrganiztion"
// 欠费账单->缴费成功通知
#define PaymentReloadBillList       @"getNewBillList"
// 查询缴费通知
#define HQueryPayControlBack        @"queryPayControlBack"
#define SDCardNo                    @"SDCardNoAndText"
#define HPayCityList                @"payMentCityList"
#define HPayMentUite                @"payMentUite"
#define HPayRefreshCard             @"RefreshCardNo"
#define HPayWayStr                  @"payWayStr"
#define HPaymentWaterRefreshCity    @"HPaymentWaterRefreshCity"

// 加油卡
#define HFuelCardPayTypeStr         @"fuelCardPayTypeStr"
#define HFuelCardLIFECARD           @"fuelCardLifeCard"
#define HFuelCardSDCardNo           @"fuelCardSDCardNoAndText"
#define HRefreshFuelCardCardNo      @"RefreshFuelCardCardNo"
#define HFuelCardNotice             @"fuelCardNotice"

// 水电缴费类型
#define     OweBillWater            @"billWater"
#define     OweBillTV               @"billTV"
#define     PaymentControlWater     @"paymentWater"
#define     PaymentControlTV        @"paymentTV"
//水费添加单位
#define PAYMENTWATER                @"payment_water"

//特惠通知
#define HPreTableViewReload         @"HPreTableViewReload"
#define HPreNumberReload            @"HPreNumberReload"
#define HPERGETSTOREPRODUCTLIST     @"HPERGETSTOREPRODUCTLIST"
#define HPreTableViewReloaed        @"HPreTableViewReloaed"
// 公交路线查询选择起点终点通知
#define ChooseStartLocation         @"start"
#define ChooseDesLocation           @"destination"

// 我的订单
//查询输入订单状态
#define QueryAllOrders                      @"0"       //全部,一个0可以通过，三个0无数据
#define QueryNoPaymentOrders                @"001"     //待付款
#define QueryNoShippedOrders                @"002"     //待发货
#define QueryShippedOrders                  @"003"     //已发货

#define QueryCouponAllOrders                @"010"     //优惠券全部
#define QueryCouponUnConsumedOrders         @"011"     //优惠券未消费
#define QueryCouponNoPaymentOrders          @"012"     //优惠券待付款
#define QueryCouponReturnOrders             @"013"     //优惠券退款

//订单创建类型
#define QueryOrderNormalType                @"011"     //普通类型
#define QueryOrderLotteryDrawType           @"012"     //抽奖
#define QueryOrderCouponType                @"013"     //优惠券
//商品类型如果是COUPON则为优惠券
#define CategoryTypeCoupon                  @"COUPON"

//积分规则类型
#define IntegralRuleMember                  @"integralmember"   //会员积分
#define IntegralRuleCard                    @"integralcard"     //城势卡积分

// 订单刷新通知
#define ReloadAllDatas              @"reloadAllOrders"

//
#define BindingBankOfCardExpireCode @"4"

//银行优惠
//包商
#define BankDiscountBS              1
//民生
#define BankDiscountMS              2

//用户修改个人信息时对应的row
#define HUserChangeNickname         1
#define HUserChangeSex              3
#define HUserChangeSign             4
#define HUserChangeAdress           5

//密码强度提示信息
#define kPasswdStrengthTip          @"密码需要为6-25位数字，字母和符号组合中的至少两种"

#define hPrefix                     @"http://shequ.shenghuo.com/r/"
#define hPrefixLength               28

//用户选中哪个tabbar
#define hCurrentSelectIndex         @"currentSelectIndex"
//动态cell相关的参数
#define contentPadding      60//名字 昵称距左边距离
#define HBaseTag            10000
#define gIphone5sRatio  ([UIScreen mainScreen].bounds.size.height)/667
#define loginBtnH  39*gIphone5sRatio
#define HDyImgSize          mScreenWidth*0.234
#define NORMAL_IMG_SPACE    10

#define hLinkShowViewHeight 80
#define hImageTag           10000
#define hServerImgSize      @"150"

#define hSystemFont15       15.0//系统15号字体
#define hDyAvatarSize       35//([UIScreen mainScreen].bounds.size.width)*0.10625
#define hAlbumAvatarSize    50
#define hDyContentFontSize  15.0//动态内容字体的大小
#define hReplyDyFontSize    12.0//动态回复的字体大小
#define hNickNameFontSize   17

//点赞头像间距
#define hDyAvatarDistance  5

//转圈自动dimiss的时间
#define kSVDismissDuration  20

//字符常量
#define kUnSyncTaskStatusString     @"同步..."
#define kUnSyncTaskStatus           @"UnSyncStatus"
#define kNetWorkUnReachableDesc     @"没有可用的网络链接,\n请检查您的网络设置"

//Notification names
#define kTaskLeaderDidChangeForCreateTaskNotification @"TaskLeaderDidChangeForCreateTaskNotification"

//以tag读取View
#define mViewByTag(parentView, tag, Class)  (Class *)[parentView viewWithTag:tag]
#define headerImageTag 0x001

//id对象与NSData之间转换
#define mObjectToData(object)   [NSKeyedArchiver archivedDataWithRootObject:object]
#define mDataToObject(data)     [NSKeyedUnarchiver unarchiveObjectWithData:data]

//度弧度转换
#define mDegreesToRadian(x)      (M_PI * (x) / 180.0)
#define mRadianToDegrees(radian) (radian*180.0) / (M_PI)

//颜色转换
#define mColor(color)    [UIColor  color]

#define mRGBColor(r, g, b)         [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define mRGBAColor(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
//rgb颜色转换（16进制->10进制）
#define mRGBToColor(rgb) [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:1.0]

//时间格式
#define mDateFormatter  @"YY-MM-DD HH:mm:ss"

//简单的以AlertView显示提示信息
#define mAlertView(title, msg) \
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil \
cancelButtonTitle:@"确定" \
otherButtonTitles:nil]; \
[alert show];

//标示是否第一次运行app
#define HIsTheFirstRun                      @"isTheFirstRun"
#define HIsLoginNotCity                     @"hisLoginNotCity"
//标示是否绑定了新城势卡
#define HIsBindingBankOfCard                @"isBindingBankOfCard"

//记录当前经纬度信息
#define HCurrentLocationLongitude           @"currentLocationLongitude"
#define HCurrentLocationLatitude            @"currentLocationLatitude"
#define HCurrentLocationAddress             @"currentLocationAddress"
#define HCurrentLocationPosition            @"currentLocationPosition"
#define HCurrentLocationArea                @"currentLocationArea"

//记录一些用户的信息
#define HUserNickName                       @"userNickName"
#define HPAYCARDSHOW                        @"hshenghuotongCardShow"
//提醒框的title内容
#define ALERTTITLE                           @""

//查询是否设置了交易密码
#define HIsTradingPassWord                   @"isTradingPassWord"

//查询新城市卡公交卡充值卡号
#define BusCardNumCache                      @"busCardNumCache"


/**
 * 好友请求数
 */
#define UserRequestAddNum                   @"userRequestAddNum_%@"


#define ERRORMSG @"errorMsg"
#define ERRORCODE @"errorCode"

//----------设备系统相关---------
#define mRetina   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define mIsiP5    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136),[[UIScreen mainScreen] currentMode].size) : NO)
#define mIsPad    (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define mIsiphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define mIos7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
// device verson
#define CURRENT_SYS_VERSION [[UIDevice currentDevice] systemVersion]
// device verson float value
#define CURRENT_SYS_VERSION_FLOAT [[[UIDevice currentDevice] systemVersion] floatValue]

//设置TableView cell选中时的颜色
#define kTableCellSelectedBGColor [UIColor colorWithRed:235.0/255.0 green:236.0/255.0 blue:238.0/255.0 alpha:1]
//layer border
#define kLayerBorderWidth 0.6f
#define kLayerBorderColor mRGBColor(200, 199, 204)
#define kSysColor   mRGBColor(230, 123, 29)
#define kSysDarkGrayColor   mRGBToColor(0xaaaaaa)
#define kSysGrayColor   mRGBToColor(0xe1e1e1)
#define kSysGray200Color   mRGBToColor(0xe5e5e5)
//#define kSysColor   mRGBColor(255, 136, 31)

//图片默认图像
#define kDefaultImage [UIImage imageNamed:@"Image_timeline_image_loading"]
//默认人物头像
#define kDefaultHeadImage [UIImage imageNamed:@"Image_defaultPerson"]
#define kDefaultPersonAvatar @"Image_defaultPerson"
//字体基本色
#define kDefaultFontColor mRGBColor(46, 117, 182)
//app基本色
#define hAppDefaultColor mRGBColor(230, 123, 29)

#define mSystemVersion   ([[UIDevice currentDevice] systemVersion])
#define mCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
#define mAPPVersion      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define mFirstLaunch     mAPPVersion     //以系统版本来判断是否是第一次启动，包括升级后启动。
#define mFirstRun        @"firstRun"     //判断是否为第一次运行，升级后启动不算是第一次运行

#define SAFE_RELEASE(_obj) if (_obj != nil) {[_obj release]; _obj = nil;}

//--------调试相关-------

//ARC
#if __has_feature(objc_arc)
//compiling with ARC
#else
#define mSafeRelease(object)     [object release];  x=nil
#endif


#if mTargetOSiPhone
//iPhone Device
#endif

#if mTargetOSiPhoneSimulator
//iPhone Simulator
#endif

//获取appDelegate实例。
//UIKIT_STATIC_INLINE AppDelegate *appDelegate()
//{
//    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
//}

//网络是否连接

#define mNetworkReachable  [[Reachability reachabilityForInternetConnection] currentReachabilityStatus]

// 账户管理
#define UpdateTradePwd                  @"update"
#define ForgotTradePwd                  @"forgot"
#define InitialTradePwd                 @"initial"

// ***** 数据库表名

#define kFriendsList    @"FriendList"
//当前用户信息
#define HCurrentUserModel             @"CurrentUserModel"

//当前城市信息
#define HCurrentCityModel             @"CurrentCityModel"

//当前社区信息
#define HCurrentCommunityModel         @"CurrentCommunityModel"

//当前评论消息列表
#define HLocalMsg                      @"localMsg"


//电影相关
#define MovieCity                       @"movieCity"
#define MovieCityID                     @"movieCityId"
#define MOVIEINFO                       @"movieInfo"
#define MOVIESEATCHOOSE                 @"movieSeatChoose"
#define MOVIEISCINEMABTN                @"movieIsCinemaBtn"


/***缓存我的订单列表数据位置****/
#define MyOrderListModelArray                @"MyOrderListArray"

//健康
#define HHealthLeftWeb                  @"HHealthLeftWeb"
/***人人保险***/
#define RrbViewWeb                      @"RrbViewWeb"
#define RrbUserAgent                    @"SmartCommunity:xcs"

//优惠券申请退款
#define CouponReturnNotificationName    @"couponReturnOrder"
//退款码值为 returnCode = 0248029; 提示信息
#define COUPONRETURNCODEMESSAGE         @"退款失败，请联系客服 400-863-6600"

//正在创建订单和支付的订单类型
#define CYOrderTypeKey                  @"CYorderType"

#define CachePath(x, y)   [[x lastPathComponent] stringByAppendingPathExtension:[y componentsJoinedByString:@","]]

//Alert Tag
#define SHTAlertTag                     1000
#define LoginAlertTag                   1001
#define BusCardAlertTag                 1002
#define TradingAlertTag                 1003

//业务系统
//app调用app_gw获取商城访问url版本
#define GetBsnSysAccessUrlVersion       @"1.0.0"
#define GenerateUserLonginInfoVersion   @"1.0.0"
#define ReceiveUserLoginInfoVersion     @"1.0.0"
#define ProcessMngContactReqVersion     @"1.0.0"
#define ReceiveMngContactReqRstVersion  @"1.0.0"
//系统名称
//商城h5
#define SysMailName                     @"mall_user_h5"
#define SysMailAdmin                    @"mall_admin"
//app
#define SysAPPName                      @"usr_app"
//业务类型
#define SysTypeNormalMall               @"mall"
#define SysTypeIntegralMall             @"pointshop"

//缓存银行卡列表key
#define CKeyForBankList                 @"KeyForBankList"

//临时明文token存储key，发送http时取消掉
#define CKeyTempClearToken              @"__@CKeyTempClearToken@__"

//支付来源参数key
#define CPaymentKeyForParameter         @"CPaymentKeyForParameter"
//支付来源存储key
#define CPaymentKeyForSource            @"CPaymentKeyForSource"
//商品支付来源
#define CPaymentProductSource           @"CPaymentProductSource"
//电影支付来源
#define CPaymentMovieSource             @"CPaymentMovieSource"
//开放式水费缴费支付来源
#define CPaymentWaterFeeSource          @"CPaymentWaterFeeSource"
//开放式缴费加油卡支付来源
#define CPaymentFuelFeeSource           @"CPaymentFuelFeeSource"
//开放式缴费话费充值支付来源
#define CPaymentTelFeeSource            @"CPaymentTelFeeSource"
//通用支付来源
#define CPaymentCommonSource            @"CPaymentCommonSource"

//功能id宏定义
#define CFMe                            @"me"               //我
#define CFMyLifeCard                    @"myLifeCard"       //我的新城势卡
#define CFMyBankCard                    @"myBankCard"       //我的银行卡
#define CFTradePassword                 @"tradePassword"    //交易密码
#define CFMyOrder                       @"myOrder"          //我的订单
#define CFMyCoupon                      @"myCoupon"         //我的优惠券
#define CFMyIntegral                    @"myIntegral"       //我的积分
#define CFHotLine                       @"hotLine"          //热线电弧
#define CFAboutUs                       @"aboutUs"          //关于我们

#define CFLifeCardNo                    @"lifeCardNo"       //新城势卡号
#define CFLifeCardBalance               @"lifeCardBalance"  //新城势余额
#define CFLifeCardTrade                 @"lifeCardTrade"    //新城势交易管理
#define CFLifeCardMobile                @"lifeCardMobile"   //新城势手机号码
#define CFLifeCardCharge                @"lifeCardCharge"   //新城势账户充值

#define CFQRScan                        @"qrScan"           //扫一扫
#define CFChargeFromBankCard            @"chargeFromBankCard"//新城势卡充值
#define CFDiscovery                     @"discovery"        //发现
#define CFPointMall                     @"point_mall"       //积分商城
#define CFPreferential                  @"preferential"     //特惠

#define CFAddBankCardInfo               @"addBankCardInfo"  //添加银行卡信息
#define CFBankCardName                  @"bankCardName"     //银行卡名称
#define CFBankCardNo                    @"bankCardNo"       //银行卡号
#define CFBankCardUserName              @"bankCardUserName" //证件姓名
#define CFBankCardIdType                @"bankCardIdType"   //证件类型
#define CFBankCardExpire                @"bankCardExpire"   //有效期
#define CFBankCardSafeCode              @"bankCardSafeCode" //安全码
#define CFBankCardIdNo                  @"bankCardIdNo"     //证件号码
#define CFBankCardMobile                @"bankCardMobile"   //手机号

#define CFPersonInfo                    @"personInfo"                 //个人信息
#define CFPersonAvatar                  @"personAvatar"               //个人头像
#define CFPersonRealName                @"personRealName"             //个人认证姓名
#define CFPersonNickname                @"personNickname"             //个人昵称
#define CFPersonAccount                 @"personAccount"              //个人账号
#define CFPersonGender                  @"personGender"               //个人性别
#define CFPersonSign                    @"personSign"                 //个人签名
#define CFPersonAddress                 @"personAddress"              //个人收货地址
#define CFPersonResetPwd                @"personResetPwd"             //个人重置密码

#define CFPaymentValidate               @"paymentValidate"            //订单支付
#define CFPaymentFlowId                 @"paymentFlowId"              //订单编号
#define CFPaymentAmount                 @"paymentAmount"              //订单金额
#define CFPaymentDiscount               @"paymentDiscount"            //优惠金额
#define CFPaymentRealAmount             @"paymentRealAmount"          //实付款
#define CFPaymentOrderTime              @"paymentOrderTime"           //下单时间
#define CFPaymentSmsTip                 @"paymentSmsTip"              //验证码提示
#define CFPaymentSmsValidate            @"paymentSmsValidate"         //短信验证
#define CFPaymentNextStep               @"paymentNextStep"            //支付下一步按钮

#define CFPaymentDetail                 @"paymentDetail"              //付款详情
#define CFPDetailFeeFlowId              @"pDetailFeeFlowId"           //缴费编号
#define CFPDetailLifeFee                @"pDetailLifeFee"             //生活缴费
#define CFPDetailFuelCardNo             @"pDetailFuelCardNo"          //加油卡卡号
#define CFPDetailTelNumber              @"pDetailTelNumber"           //充值号码
#define CFPDetailPayType                @"pDetailPayType"             //支付类型
#define CFPDetailBankCardNo             @"pDetailBankCardNo"          //银行卡号
#define CFPDetailAmount                 @"pDetailAmount"              //需付款

#define CFWaterPaymentInfo              @"waterPaymentInfo"           //水费缴费信息
#define CFWaterPaymentUnit              @"waterPaymentUnit"           //缴费单位
#define CFWaterPaymentId                @"waterPaymentId"             //缴费编号
#define CFWaterPaymentUserName          @"waterPaymentUserName"       //缴费用户姓名
#define CFWaterPaymentUserAddress       @"waterPaymentUserAddress"    //缴费用户地址
#define CFWaterPaymentLeftAmount        @"waterPaymentLeftAmount"     //缴费预存金额
#define CFWaterPaymentArrearage         @"waterPaymentArrearage"      //缴费欠费




//新城势卡所对应城市的核算机构号,保存的key
#define CKeyLifeCardCity                @"CFLifeCardCityKey"

//首页模板类型
#define CHomeTemplateMenu               @"menu_city"
#define CHomeTemplateMenu2X4            @"menu_city_2x4"
#define CHomeTemplateMenu2X5            @"menu_city_2x5"
#define CHomeTemplateScrollHeader       @"scroll_header"
#define CHomeTemplateScrollAD           @"scroll_AD"
#define CHomeTemplateImg1X3             @"img_1x3"
#define CHomeTemplateImg1W2             @"img_1-2"

//记录电影票目前地区key
#define CKeyCurrentMovieRegion          @"CKeyCurrentMovieRegion"
