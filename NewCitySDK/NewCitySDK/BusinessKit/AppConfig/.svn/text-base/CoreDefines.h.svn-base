#pragma mark - 公共定义
//是否是iPad
#define ISIPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//定义空字符串
#define  STRINGEMPTY @""
//项目安全码
#define  SAFECODE @"HIAWARD_APP"
//成功标志
#define  SUCCESSFLAG @"S"
//失败标志
#define  ERRORFLAG @"E"
//警告标志 ，执行完成并没有执行成功
#define  WARNINGFLAG @"W"
//字密字符串
#define  G_KEYCHAR @"HIAWARD-APP"
// 分隔符 '-'
#define G_SeparatorShortLine @"-"
//是否是发布版本
#define  G_ISRELEASE YES
//拍照保存的前缀
#define G_CAMERAFIX_NAME @"HIAWARD_"
//提示标签头
#define  G_ALERTTITLE @"温馨提示"
//默认导航背景颜色32adf0
#define G_NAVIGATIONDEFAULTBACKCOLOR  [UIColor colorWithRed:0x32/255.f green:0xad/255.f blue:0xf0/255.f alpha:1.f]
//默认导航标题颜色
#define  G_NAVIGATIONDEFAULTTITLECOLOR [UIColor whiteColor]
//RSA加密文件名
#define  G_ENCRYPT_RSA_KEYFILE @""

//版本编号为7.x以上版本
#define G_SYSTEMVERSION_7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.f)
//版本编号为8.x
#define G_SYSTEMVERSION_8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.f)

#pragma mark  - Date字段定义

#define G_DateYYYY @"yyyy"

#define G_DateMM @"MM"

#define G_DateYYYYMM @"yyyy-MM"

#define G_DateYYYYMMDD @"yyyy-MM-dd"

#define G_DateMMDD @"MM-dd"

#pragma mark - UserDefaults变量定义
//设置配置文件定义
#define  SETTINGCONFIG_USERDEFAULTS  @"SETTINGCONFIG_USERDEFAULTS"

#pragma TODO 宏定义
#define STRINGIFY(S) #S
#define DEFER_STRINGIFY(S) STRINGIFY(S)
#define PRAGMA_MESSAGE(MSG) _Pragma(STRINGIFY(message(MSG)))
#define FORMATTED_MESSAGE(AUT,MSG) "[TODO-" AUT"-" DEFER_STRINGIFY(__COUNTER__) "] " MSG " \n" \
DEFER_STRINGIFY(__FILE__) " line " DEFER_STRINGIFY(__LINE__)
//AUT 作者     MSG 备注信息
#if DEBUG
#define TODO(AUT,MSG)  PRAGMA_MESSAGE(FORMATTED_MESSAGE(AUT,MSG))
#else
#define TODO(AUT,MSG)
#endif
