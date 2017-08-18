//
//  NSString+HW.h
//  smartcity
//
//  Created by kongjun on 13-11-1.
//  Copyright (c) 2013年 Shenghuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Addition)

/**
 *  计算字符串的字数。
 *  @param  string:输入字符串。
 *  return  返回输入字符串的字数。
 */
- (int)wordsCount;

- (NSString *)URLDecodedString;
- (NSString *)URLEncodedString;
- (NSString *)encodeStringWithUTF8;
- (NSUInteger)byteLengthWithEncoding:(NSStringEncoding)encoding;
- (NSString *)   firstComponentSeparatorByVerticalLineString;

- (NSString *)formatDateWithFormatter:(NSString *)formatter;
- (NSString *)chineseFormatterDateWithMonth:(NSString *)currMonth;//将数字月转为汉字月
#pragma mark - 处理金额小数点
- (NSString*)prodContentString;
//严格效验身份证
-(BOOL)strictValidateIdentityCardId;

#pragma mark 格式化金额字符串<整数转小数>分->元
+ (NSString*)prodContentString:(NSString *)mutableString;
//小数转整数>分->元
- (NSString *)intAmountByFloatAmount:(NSString *)floatAmount;
#pragma mark - 保留两位小数
-(NSString*)ProcessingAmountToDecimal:(NSString*)amountString;
@end
