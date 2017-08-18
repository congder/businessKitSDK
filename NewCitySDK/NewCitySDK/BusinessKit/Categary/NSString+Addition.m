//
//  NSString+HW.m
//  smartcity
//
//  Created by kongjun on 13-11-1.
//  Copyright (c) 2013年 Shenghuo. All rights reserved.
//

#import "NSString+Addition.h"

@implementation NSString (Addition)

- (int)wordsCount
{
    int i,n = [self length], l = 0, a = 0, b = 0;
    unichar c;
    for(i = 0;i < n; i++)
    {
        c = [self characterAtIndex:i];
        if(isblank(c))
        {
            b++;
        }else if(isascii(c))
        {
            a++;
        }else{
            l++;
        }
    }
    if(a == 0 && l == 0) return 0;
    return l + (int)ceilf((float)(a + b) / 2.0);
}

- (NSString *)URLEncodedString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (CFStringRef)self,
                                                                           NULL,
                                                                           CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                           kCFStringEncodingUTF8));
    return result;
}

- (NSString *)URLDecodedString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                           (CFStringRef)self,
                                                                                           CFSTR(""),
                                                                                           kCFStringEncodingUTF8));
    return result;
}

- (NSString *)encodeStringWithUTF8
{
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1);
    const char *c =  [self cStringUsingEncoding:encoding];
    NSString *str = [NSString stringWithCString:c encoding:NSUTF8StringEncoding];

    return str;
}

- (NSUInteger)byteLengthWithEncoding:(NSStringEncoding)encoding
{
    if (!self)
    {
        return 0;
    }
    
    const char *byte = [self cStringUsingEncoding:encoding];
    return strlen(byte);
}

- (NSString *)formatDateWithFormatter:(NSString *)formatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:formatter];
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:formatter];
    return [dateFormatter2 stringFromDate:date];
}

- (NSString *)chineseFormatterDateWithMonth:(NSString *)currMonth{
    NSUInteger intCase = currMonth.integerValue;
    NSString *month;
    switch (intCase) {
        case 1:
            month = @"一月";
            break;
        case 2:
            month = @"二月";
            break;
        case 3:
            month = @"三月";
            break;
        case 4:
            month = @"四月";
            break;
        case 5:
            month = @"五月";
            break;
        case 6:
            month = @"六月";
            break;
        case 7:
            month = @"七月";
            break;
        case 8:
            month = @"八月";
            break;
        case 9:
            month = @"九月";
            break;
        case 10:
            month = @"十月";
            break;
        case 11:
            month = @"十一月";
            break;
        case 12:
            month = @"十二月";
            break;
        default:
            break;
    }
    return month;
}
//获取以"|"分割后的字符串，如“a|b”中的"a"
-(NSString *)   firstComponentSeparatorByVerticalLineString{
    NSArray *array=[self componentsSeparatedByString:@"|"];
    return [array objectAtIndex:0];
}


- (NSComparisonResult)compareVersion:(NSString *)version
{
    return [self compare:version options:NSNumericSearch];
}

- (NSComparisonResult)compareVersionDescending:(NSString *)version
{
    switch ([self compareVersion:version])
    {
        case NSOrderedAscending:
        {
            return NSOrderedDescending;
        }
        case NSOrderedDescending:
        {
            return NSOrderedAscending;
        }
        default:
        {
            return NSOrderedSame;
        }
    }
}

#pragma mark - 处理金额小数点
-(NSString*)prodContentString
{
    if (self) {
        NSMutableString *mutableString = [[NSMutableString alloc] initWithString:self];
        // 判断是否存在“-”号
        NSRange range = [mutableString rangeOfString:@"-"];
        if (self.length>2) {
            if (range.location==NSNotFound) {
                [mutableString insertString:@"." atIndex:mutableString.length-2];
                //            DLog(@"转换金额---%@",prodContentString);
                return mutableString;
            }else{
                if (self.length==3) {
                    [mutableString insertString:@"0." atIndex:mutableString.length-2];
                    //            DLog(@"转换金额---%@",prodContentString);
                    return mutableString;
                }else{
                    [mutableString insertString:@"." atIndex:mutableString.length-2];
                    //            DLog(@"转换金额---%@",prodContentString);
                    return mutableString;
                }
            }
        }else if (self.length==1){
            if (range.location==NSNotFound) {
                return [NSString stringWithFormat:@"0.0%@",mutableString];
            }else{
                [mutableString deleteCharactersInRange:range];
                return [NSString stringWithFormat:@"-0.0%@",mutableString];
            }
        }
        else if (self.length==2){
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

//严格效验身份证
-(BOOL)strictValidateIdentityCardId

{
    if (!self) {
        return NO;
    }
    //判断位数
    
    if ([self length] != 15 && [self length] != 18) {
        
        return NO;
        
    }
    
    NSString *carid = self;
    
    long lSumQT =0;
    
    //加权因子
    
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    
    //校验码
    
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    
    //将15位身份证号转换成18位
    
    NSMutableString *mString = [NSMutableString stringWithString:self];
    
    if ([self length] == 15) {
        
        [mString insertString:@"19" atIndex:6];
        
        long p = 0;
        
        const char *pid = [mString UTF8String];
        
        for (int i=0; i<=16; i++) {
            
            p += (pid[i]-48) * R[i];
        }
        
        int o = p%11;
        
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        
        [mString insertString:string_content atIndex:[mString length]];
        
        carid = mString;
        
    }
    
    
    
    //判断地区码
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:@"北京" forKey:@"11"];
    
    [dic setObject:@"天津" forKey:@"12"];
    
    [dic setObject:@"河北" forKey:@"13"];
    
    [dic setObject:@"山西" forKey:@"14"];
    
    [dic setObject:@"内蒙古" forKey:@"15"];
    
    [dic setObject:@"辽宁" forKey:@"21"];
    
    [dic setObject:@"吉林" forKey:@"22"];
    
    [dic setObject:@"黑龙江" forKey:@"23"];
    
    [dic setObject:@"上海" forKey:@"31"];
    
    [dic setObject:@"江苏" forKey:@"32"];
    
    [dic setObject:@"浙江" forKey:@"33"];
    
    [dic setObject:@"安徽" forKey:@"34"];
    
    [dic setObject:@"福建" forKey:@"35"];
    
    [dic setObject:@"江西" forKey:@"36"];
    
    [dic setObject:@"山东" forKey:@"37"];
    
    [dic setObject:@"河南" forKey:@"41"];
    
    [dic setObject:@"湖北" forKey:@"42"];
    
    [dic setObject:@"湖南" forKey:@"43"];
    
    [dic setObject:@"广东" forKey:@"44"];
    
    [dic setObject:@"广西" forKey:@"45"];
    
    [dic setObject:@"海南" forKey:@"46"];
    
    [dic setObject:@"重庆" forKey:@"50"];
    
    [dic setObject:@"四川" forKey:@"51"];
    
    [dic setObject:@"贵州" forKey:@"52"];
    
    [dic setObject:@"云南" forKey:@"53"];
    
    [dic setObject:@"西藏" forKey:@"54"];
    
    [dic setObject:@"陕西" forKey:@"61"];
    
    [dic setObject:@"甘肃" forKey:@"62"];
    
    [dic setObject:@"青海" forKey:@"63"];
    
    [dic setObject:@"宁夏" forKey:@"64"];
    
    [dic setObject:@"新疆" forKey:@"65"];
    
    [dic setObject:@"台湾" forKey:@"71"];
    
    [dic setObject:@"香港" forKey:@"81"];
    
    [dic setObject:@"澳门" forKey:@"82"];
    
    [dic setObject:@"国外" forKey:@"91"];
    
    NSString *sProvince = [carid substringToIndex:2];
    
    if ([dic objectForKey:sProvince] == nil) {
        
        return NO;
        
    }
    
    
    
    //判断年月日是否有效
    
    //年份
    
    int strYear = [[carid substringWithRange:NSMakeRange(6,4)] intValue];
    
    //月份
    
    int strMonth = [[carid substringWithRange:NSMakeRange(10,2)] intValue];
    
    //日
    
    int strDay = [[carid substringWithRange:NSMakeRange(12,2)] intValue];
    
    
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    [dateFormatter setTimeZone:localZone];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    
    if (date == nil) {
        
        return NO;
        
    }
    
    const char *PaperId  = [carid UTF8String];
    
    //检验长度
    
    if( 18 != strlen(PaperId)) return -1;
    
    //校验数字
    
    for (int i=0; i<18; i++) {
        
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) ){
            
            return NO;
            
        }
        
    }
    
    //验证最末的校验码
    
    for (int i=0; i<=16; i++) {
        
        lSumQT += (PaperId[i]-48) * R[i];
        
    }
    
    if (sChecker[lSumQT%11] != PaperId[17] ) {
        
        return NO;
        
    }
    
    return YES;
    
}
+(NSString*)prodContentString:(NSString *)senderString
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

//<小数转整数>
- (NSString *)intAmountByFloatAmount:(NSString *)floatAmount
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
-(NSString*)ProcessingAmountToDecimal:(NSString*)amountString{
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
