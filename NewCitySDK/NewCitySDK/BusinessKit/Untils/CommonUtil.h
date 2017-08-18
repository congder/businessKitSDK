//
//  CommonUtil.h
//  xBankCore
//
//  Created by 半饱 on 15/6/29.
//  Copyright (c) 2015年 com.hiaward. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonUtil : NSObject
#pragma  mark - 公共处理
/*!
*  @brief  打印log日志，如果是发布版本则不打印，否则打怨
*
*  @param log 需要打印的日志
*/
+ (void)showLog:(NSString *)log,...;

/*!
 *  @brief  弹出Alert对话框
 *
 *  @param title   Alert标题
 *  @param message Alert的信息内容
*  @param viewController 需要显示的viewController
 */
+ (void)showAlert:(NSString *)title withMessage:(NSString *)message;

#pragma mark - 字符串处理
/*!
 *  @brief  判断字符串是否为空
 *
 *  @param string 需要判断的字符串
 *
 *  @return 如果是空串或者是nil 返回YES,否则返回NO
 */
+ (BOOL)isNilOrEmpty:(NSString *)string;
/*!
 *  @brief  将传入的字符串转换成拼音
 *
 *  @param chinaString 需要转换的字符串
 *
 *  @return 如果chinaString为空则返回空字符串，如果是英文返回是原文，如果是中文则返回中文拼音
 */
+(NSString *)spellByString:(NSString*)chinaString;
/*!
 *  @brief  将的对象转换成json字符串
 *
 *  @param obj 需要转换的对象
 *
 *  @return 如果obj为空对象则返回空字符串，否则返回json字符串
 */
+(NSString *)JSONWithObject:(id)obj;
/*!
 *  @brief  将传入的字符串转换成对象
 *
 *  @param jsonString 需要转换的字符串
 *
 *  @return 如果jsonString为空则返回nil，否则返回对应的NSDictionary或NSArray
 */
+(id)objectWithJSON : (NSString *)jsonString;
#pragma mark - File文件处理
/*!
 *  @brief  获取主目录下的文件路径
 *
 *  @param fileName 需要获取路径的文件名
 *
 *  @return 获取主目录下的文件全路径，如果文件名为空，则返回应用程序主目录路径
 */
+ (NSString *)fileMainBundleName:(NSString *)fileName;

/*!
 *  @brief  获取Libary/Cache目录全路径
 *
 *  @return 返回Libary/Cache目录
 */
+ (NSString *)fileLibCacheDirectory;

/*!
 *  @brief  获取Doctment文件目录全路径
 *
 *  @return 返回Doctment文件目录全路径
 */
+ (NSString *)fileDocumentsDirectory;

/*!
 *  @brief  获取临时文件夹中的文件路径
 *
 *  @param filename 需要获取到的文件路径
 *
 *  @return 返回需要获取到的文件全路径
 */
+ (NSString*)fileTempDirectoryWithFile:(NSString *)filename;

/*!
 *  @brief 写入数据至文件
 *
 *  @param filePath 需要写入文件的详细路径
 *  @param data     需要写入文件的数据
 *
 *  @return 写入文件成功则返回YES,否则返回NO
 */
+ (BOOL)fileWriteToPath:(NSString *)filePath data:(NSData*)data;
/*!
 *  @brief 根据文件路径删除文件
 *
 *  @param filePath 需要删除的详细路径
 *
 *  @return 删除成功返回YES,否则返回NO
 */
+ (BOOL)fileDelete:(NSString *)filePath;

#pragma mark - NSDate操作
/*!
 *  @brief  获取formatString里面有几段
 *
 *  @param formatString 格式化时间字符串
 *
 *  @return 返回有几段，如：yyyy时返回1,yyyyMM返回2,否则返回3
 */
+ (NSInteger)componentByFormatString:(NSString *)formatString;

/*!
 *  @brief  指定的时间与指定的时间格式化成字符串
 *
 *  @param date   需要格式化的时间
 *  @param format 时间的格式化
 *
 *  @return 返回时间按指定的时间格式化成字符串
 */
+ (NSString *)dateToString:(NSDate *)date formate:(NSString *)format;
/*!
 *  @brief  指定的时间与指定的时间格式化成字符串
 *
 *  @param string   需要l转换的时间
 *  @param format 时间的格式化
 *
 *  @return 将字符串转换成Date对象
 */
+ (NSDate*)dateByString:(NSString*)string formate:(NSString*)formate;
/*!
 *  @brief  根据指定的时间获取得年份
 *
 *  @param fromDate   指定的时间
 *
 *  @return 获取到的时间年份
 */
+ (NSInteger)yearFromDate:(NSDate*)fromDate;
/*!
 *  @brief  根据指定的时间获取得月份
 *
 *  @param fromDate   指定的时间
 *
 *  @return 获取到的时间月份
 */
+(NSInteger)monthFromDate:(NSDate*)fromDate;
/*!
 *  @brief  两个时间比较大小
 *
 *  @param firstDate  第一个时间
 *  @param secondDate 第二个时间
 *
 *  @return 如果第一个时间大于第二个时间返回YES,否则返回NO
 */
+ (BOOL) dateCompareWithFirstDate:(NSString *)firstDate withSecondDate:(NSString *)secondDate;

//截取时间
+ (NSString *) dateCutNormalDate: (NSString *) date;
+ (NSString *) dateCutDate: (NSString *) date;
#pragma mark - UIImage处理
/*!
 *  @brief 获取根目录下image全路径
 *
 *  @param imageFullName 图片名称
 *
 *  @return 返回应用程序目录下全路径
 */
+ (UIImage *)resourceImage:(NSString *)imageFullName;
/*!
 *  @brief  将UIImage转换成指定大小的图片
 *
 *  @param image   需要转化大小的图片
 *  @param newSize 新的尺寸
 *
 *  @return 返回转化过的图片
 */
+ (UIImage *)transformToSize:(UIImage*)image size:(CGSize)newSize;
/*!
 *  @brief  获取图片url中的图片名称
 *
 *  @param imageUrl 图片url
 *
 *  @return 返回图片名称
 */
+ (NSString *)imageNameByImageUrl:(NSString *)imageUrl;

/*!
 *  @brief  <#Description#>
 *
 *  @param baseImage <#baseImage description#>
 *  @param theColor  <#theColor description#>
 *
 *  @return <#return value description#>
 */
+ (UIImage *)colorizeImage:(UIImage *)baseImage withColor:(UIColor *)theColor;

+ (UIImage *)createReflectionWithImage:(UIImage *)img andSize:(CGSize)size andReflection:(CGFloat)reflectionFraction;
#pragma mark -  UIColor
/*!
 *  @brief  将字符串转换成UIColor值
 *
 *  @param stringColor 需要转换的string字符串，格式如：#33ffee
 *
 *  @return 返回UIColor实例
 */
+ (UIColor *)convertToColor:(NSString*)stringColor;

#pragma mark - bytes
/*!
 *  @brief  将字节数转换具体有多大
 *
 *  @param bytes 字节
 *
 *  @return 返回字节大小
 */
+ (NSString *)bytesConvert:(float)bytes;


#pragma mark - Http请求处理
/*!
 *  @brief  根扰http error code 解析是什么错
 *
 *  @param code 错误码
 *
 *  @return 返回http具体错误
 */
+ (NSString *)httpErrorWithCode:(int)code ;
/*!
 *  @brief  清理指定的urlRequest的缓存
 *
 *  @param request 清理的urlRequest
 */
+ (void)clearURLCacheForRequest:(NSURLRequest *)request;
/*!
 *  @brief  转url转换
 *
 *  @param serverUrl 服务器端地址
 *
 *  @return 完整的url地址
 */
+(NSString*) convertServerURL:(NSString *)serverUrl  withBaseURL:(NSString*)baseURL;
#pragma mark - UserDefaults相关的操作
/*!
 *  @brief  保存值到userDefaults里面去
 *
 *  @param defaultValue  保存的值
 *  @param defaultKey   保存的key
 *
 *  @return w保存成功返回YES,否则返回NO
 */
+ (BOOL)saveUserDefaultsWithValue:(id)defaultValue withKey : (NSString *)defaultKey;
/*!
 *  @brief  获取userDefault里面的数据
 *
 *  @param defaultKey 获取的key
 *
 *  @return 返回根据key获取的值
 */
+ (id) findUserDefaultsWithKey:(NSString *)defaultKey;
@end
