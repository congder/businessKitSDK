//
//  NSString+Price.m
//  BusinessKit
//
//  Created by zevwings on 2017/8/10.
//  Copyright © 2017年 高庆华. All rights reserved.
//

#import "NSString+Price.h"

@implementation NSString (Price)

+ (NSString*)prodContentString:(NSString *)senderString
{
    if (senderString!=nil) {
        NSMutableString *mutableString = [[NSMutableString alloc] initWithString:senderString];
        // 判断是否存在“-”号
        NSRange range = [mutableString rangeOfString:@"-"];
        if (senderString.length>2) {
            if (range.location==NSNotFound) {
                [mutableString insertString:@"." atIndex:mutableString.length-2];
                //            DLog(@"转换金额---%@",prodContentString);
                return mutableString;
            }else{
                if (senderString.length==3) {
                    [mutableString insertString:@"0." atIndex:mutableString.length-2];
                    //            DLog(@"转换金额---%@",prodContentString);
                    return mutableString;
                }else{
                    [mutableString insertString:@"." atIndex:mutableString.length-2];
                    //            DLog(@"转换金额---%@",prodContentString);
                    return mutableString;
                }
            }
        }else if (senderString.length==1){
            if (range.location==NSNotFound) {
                return [NSString stringWithFormat:@"0.0%@",mutableString];
            }else{
                [mutableString deleteCharactersInRange:range];
                return [NSString stringWithFormat:@"-0.0%@",mutableString];
            }
        }
        else if (senderString.length==2){
            if (range.location==NSNotFound) {
                return [NSString stringWithFormat:@"0.%@",mutableString];
            }else{
                [mutableString deleteCharactersInRange:range];
                return [NSString stringWithFormat:@"-0.%@",mutableString];
            }
        }else{
            return @"";
        }
    }else{
        return @"";
    }
}

// 小数转整数
+ (NSString *)intAmountByFloatAmount:(NSString *)floatAmount
{
    if (floatAmount!=nil) {
        NSRange range = [floatAmount rangeOfString:@"."];
        //        DLog(@"%lu--%lu",(unsigned long)range.location,(unsigned long)range.length);
        
        if (range.location!=NSNotFound) {
            // 有小数点
            double amount = [floatAmount doubleValue]*100;
            NSString *returnAmount = [NSString stringWithFormat:@"%.0f",amount];
            return returnAmount;
        }else{
            // 没有小数点
            long long amount = [floatAmount longLongValue]*100;
            NSString *returnAmount = [NSString stringWithFormat:@"%lld",amount];
            return returnAmount;
        }
    }else{
        return @"";
    }
    return nil;
}
#pragma mark - 保留两位小数
+ (NSString*)processingAmountToDecimal:(NSString*)amountString{
    if(amountString!=nil&&![amountString isKindOfClass:[NSNull class]]){
        NSRange range = [amountString rangeOfString:@"."];
        if (range.location==NSNotFound) {//没有小数点
            return amountString;
        }else{//有小数点
            if (amountString.length-range.location>2) {
                NSString*returnString=[amountString substringToIndex:range.location+3];
                return returnString;
            } else {
                NSString*returnString=[NSString stringWithFormat:@"%@0",amountString];
                return returnString;
            }
        }
        return @"";
    }else{
        return @"";
    }
}

@end
