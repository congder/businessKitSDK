//
//  NSString+Price.h
//  BusinessKit
//
//  Created by zevwings on 2017/8/10.
//  Copyright © 2017年 高庆华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Price)

+ (NSString*)prodContentString:(NSString *)senderString;

// 小数转整数
+ (NSString *)intAmountByFloatAmount:(NSString *)floatAmount;
// 保留两位小数
+ (NSString*)processingAmountToDecimal:(NSString*)amountString;

@end
