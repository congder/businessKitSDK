//
//  NSString+Regular.h
//  smartcity
//
//  Created by kongjun on 13-11-1.
//  Copyright (c) 2013年 Shenghuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Regular)

- (BOOL)isValidateEmail;//邮箱符合性验证。
- (BOOL)isNumber;//全是数字。
- (BOOL)isEnglishWords;//验证英文字母。
- (BOOL)isValidatePassword;//验证密码：6—18位，只能包含字符、数字和 下划线。
- (BOOL)isChineseWords;//验证是否为汉字。
- (BOOL)isInternetUrl;//验证是否为网络链接。
- (BOOL)isPhoneNumber;//验证是否为电话号码。正确格式为：XXXX-XXXXXXX，XXXX-XXXXXXXX，XXX-XXXXXXX，XXX-XXXXXXXX，XXXXXXX，XXXXXXXX
- (BOOL)isPhoneNumber_backup;

- (BOOL)isElevenDigitNum;//判断是否为11位的数字
- (BOOL)isIdentifyCardNumber;//验证15或18位身份证。
- (BOOL)isNotEmpty;//判断去除空格后是否为空
- (BOOL)isContainsEmoji;//判断是否输入emoji表情

//密码验证最少8位，数字｜字母｜符号三者选2
- (BOOL)passwordCheckStrength;
//最后一位为"."
- (BOOL)checkLastCharaterIsDot;
//验证二位小数
- (BOOL)checkTwoPlaceDecimal;
//将一般字符串转为银行号格式
-(NSString *)normalNumToBankNum:(NSString*)normalNum;
//校验银行卡号格式
- (BOOL)isIdentifyBankCardNumber:(NSString*)cardNum;
//时间戳转时间
-(NSString*)timechangeWithTimest;
-(NSString*)timechangeWithSquareList;
-(NSDate *)NSStringDateToNSDate;
@end
