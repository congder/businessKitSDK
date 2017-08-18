//
//  CommonUtil.m
//  xBankCore
//
//  Created by 半饱 on 15/6/29.
//  Copyright (c) 2015年 com.hiaward. All rights reserved.
//

#import "CommonUtil.h"
#import "CoreDefines.h"
#import "NetworkAPI.h"
@implementation CommonUtil
#pragma  mark - 公共处理

+ (void)showLog:(NSString *)log,... {
#if DEBUG
        assert(log);
        va_list args;
        va_start(args,log);
        NSString *str = [[NSString alloc] initWithFormat:log arguments:args];
        va_end(args);
        DLog(@"Function:%s %@ ",__FUNCTION__, str );
#endif
}
+ (void)showAlert:(NSString *)title withMessage:(NSString *)message {
    NSString *strAlertOK = NSLocalizedString(@"确定",nil);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:strAlertOK
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark - 字符串处理

+ (BOOL)isNilOrEmpty:(NSString *)string {
    if (string == nil || [string isEqual:[NSNull null]]) {
        return YES;
    }
    else {
        if (string.length > 0) {
            return NO;
        }
        else {
            return YES;
        }
    }
}

+(NSString *)spellByString:(NSString*)chinaString {
    if ([self isNilOrEmpty:chinaString]) {
        return STRINGEMPTY;
    }
    NSMutableString *ms = [[NSMutableString alloc] initWithString:chinaString];
    CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO);
    return ms;
}

+(NSString *)JSONWithObject:(id)obj{
    if(!obj) {
        return nil;
    }
    NSData *objData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil];
    NSString *result = [[NSString  alloc] initWithData:objData encoding:NSUTF8StringEncoding];
    return result;
}

+(id)objectWithJSON : (NSString *)jsonString{
    if ([self isNilOrEmpty: jsonString]) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    id resultObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    return resultObj;
}

#pragma mark - File文件处理


+ (NSString *)fileMainBundleName:(NSString *)fileName {
    NSString *stringBundle =[[NSBundle mainBundle] bundlePath];
    return [stringBundle stringByAppendingPathComponent:fileName];
}



+ (NSString *)fileLibCacheDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}



+ (NSString *)fileDocumentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}


+ (NSString*)fileTempDirectoryWithFile:(NSString *)filename {
    NSString *stringPath = NSTemporaryDirectory();
    return [stringPath stringByAppendingPathComponent:filename];
}

+ (BOOL)fileWriteToPath:(NSString *)filePath data:(NSData*)data{
    return [data writeToFile:filePath atomically:YES];
}


+ (BOOL)fileDelete:(NSString *)filePath{
    NSFileManager *filemanager = [NSFileManager defaultManager];
    NSError *error;
    if ([filemanager removeItemAtPath:filePath error:&error] != YES){
        return NO;
    }
    return YES;
}
#pragma mark - NSDate操作

+ (NSInteger)componentByFormatString:(NSString *)formatString {
    NSInteger components = 0;
    NSRange rangOfDay = [formatString rangeOfString:@"d"];
    NSRange rangOfMonth = [formatString rangeOfString:@"M"];
    NSRange rangOfYear = [formatString rangeOfString:@"y"];
    if (rangOfYear.location != NSNotFound) {
        components = 1;	//年
        if (rangOfMonth.location != NSNotFound) {
            components = 2;	//年月
            if (rangOfDay.location != NSNotFound) {
                components = 3;	//年月日
            }
        }
    }
    else {
        components = 3;
    }
    return components;
}

+ (NSString *)dateToString:(NSDate *)date formate:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *stringDate = [formatter stringFromDate:date];
    return stringDate;
}

//将字符串转换NSDate对象
+ (NSDate*)dateByString:(NSString*)string formate:(NSString*)formate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSDate *date = [formatter dateFromString:string];
    return date;
}

+ (NSInteger)yearFromDate:(NSDate*)fromDate{
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:G_DateYYYY];
    NSInteger ym = [[dateFormater stringFromDate:fromDate] intValue];
    return ym;
}

+(NSInteger)monthFromDate:(NSDate*)fromDate{
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:G_DateMM];
    NSInteger ym = [[dateFormater stringFromDate:fromDate] intValue];
    return ym;
}

+ (BOOL) dateCompareWithFirstDate:(NSString *)firstDate withSecondDate:(NSString *)secondDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *first = [formatter dateFromString:firstDate];
    NSDate *second =  [formatter dateFromString:secondDate];
    NSTimeInterval interval = [first timeIntervalSinceDate:second];
    if (interval >= 0) {
        return YES;
    }
    else {
        return NO;
    }
}

+ (NSString *) dateCutNormalDate: (NSString *) date {
    NSString *d = date;
    if (date != nil && ![date isKindOfClass:[NSNull class]] && date.length > 10) {
        d = [date substringToIndex:10];
    }
    return d;
}

+ (NSString *) dateCutDate: (NSString *) date {
    NSString *d = date;
    if (date != nil && ![date isKindOfClass:[NSNull class]] && date.length > 19) {
        d = [date substringToIndex:19];
    }
    return d;
}

#pragma mark - UIImage处理
+ (UIImage *)resourceImage:(NSString *)imageFullName {
    NSString *bundlePath = [[NSBundle mainBundle] resourcePath];
    NSString *imagePath = [bundlePath stringByAppendingPathComponent:imageFullName];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}

+ (UIImage *)transformToSize:(UIImage*)image size:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

+ (NSString *)imageNameByImageUrl:(NSString *)imageUrl {
    NSArray *subStrArray = [imageUrl componentsSeparatedByString:@"/"];
    NSString *fullName = [subStrArray lastObject];
    NSArray *iconSubStrs = [fullName componentsSeparatedByString:@"."];
    NSString *iconName = [iconSubStrs objectAtIndex:0];
    return iconName;
}

+ (UIImage *)colorizeImage:(UIImage *)baseImage withColor:(UIColor *)theColor {
    UIGraphicsBeginImageContext(baseImage.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, baseImage.size.width, baseImage.size.height);
	
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSaveGState(ctx);
    CGContextClipToMask(ctx, area, baseImage.CGImage);
    
    [theColor set];
    CGContextFillRect(ctx, area);
    
    CGContextRestoreGState(ctx);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextDrawImage(ctx, area, baseImage.CGImage);
	
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}


+ (UIImage *)createReflectionWithImage:(UIImage *)img andSize:(CGSize)size andReflection:(CGFloat)reflectionFraction {
    
    
    CGImageRef CGImage =[img CGImage];
    
    int reflectionHeight = size.height * reflectionFraction*2;
    
    // create a 2 bit CGImage containing a gradient that will be used for masking the
    // main view content to create the 'fade' of the reflection.  The CGImageCreateWithMask
    // function will stretch the bitmap image as required, so we can create a 1 pixel wide gradient
    CGImageRef gradientMaskImage = NULL;
    
    // gradient is always black-white and the mask must be in the gray colorspace
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    // create the bitmap context
    CGContextRef gradientBitmapContext = CGBitmapContextCreate(nil, 1, reflectionHeight,
                                                               8, 0, colorSpace, kCGImageAlphaNone);
    
    //    CGAffineTransform transform =CGAffineTransformMakeRotation(-M_PI);
    //    CGContextConcatCTM(gradientBitmapContext, transform);
    //    CGContextScaleCTM (gradientBitmapContext, 1.0, -1.0);
    
    // define the start and end grayscale values (with the alpha, even though
    // our bitmap context doesn't support alpha the gradient requires it)
    CGFloat colors[] = {0.0,1.0,1.0, 1.0};
    
    // create the CGGradient and then release the gray color space
    CGGradientRef grayScaleGradient = CGGradientCreateWithColorComponents(colorSpace, colors, NULL, 2);
    CGColorSpaceRelease(colorSpace);
    
    // create the start and end points for the gradient vector (straight down)
    CGPoint gradientStartPoint = CGPointMake(0, reflectionHeight);
    CGPoint gradientEndPoint = CGPointZero;
    
    // draw the gradient into the gray bitmap context
    CGContextDrawLinearGradient(gradientBitmapContext, grayScaleGradient, gradientStartPoint,
                                gradientEndPoint, kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(grayScaleGradient);
    
    // add a black fill with 50% opacity
    CGContextSetGrayFillColor(gradientBitmapContext, 0.0, 0.5);
    CGContextFillRect(gradientBitmapContext, CGRectMake(0, 0, 1, reflectionHeight));
    
    // convert the context into a CGImageRef and release the context
    gradientMaskImage = CGBitmapContextCreateImage(gradientBitmapContext);
    CGContextRelease(gradientBitmapContext);
    
    // create an image by masking the bitmap of the mainView content with the gradient view
    // then release the  pre-masked content bitmap and the gradient bitmap
    CGImageRef reflectionImage = CGImageCreateWithMask(CGImage, gradientMaskImage);
    CGImageRelease(gradientMaskImage);
    
    CGSize size1 = CGSizeMake(size.width, size.height + reflectionHeight);
    
    UIGraphicsBeginImageContext(size1);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawImage(context, CGRectMake(0, reflectionHeight/2, size.width, reflectionHeight/2), reflectionImage);
    CGContextSaveGState(context);
    
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -reflectionHeight);
    
    CGContextDrawImage(context, CGRectMake(0, reflectionHeight/2, size.width, reflectionHeight/2), CGImage);
    CGContextRestoreGState(context);
    
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRelease(reflectionImage);
    
    return result;
}

#pragma mark -  UIColor处理
/**
 *  @brief  转字符串转换成UIColor值
 *
 *  @param stringColor 需要转换的颜色值
 */
+ (UIColor *)convertToColor:(NSString*)stringColor {
    unsigned int c;
    if ([stringColor characterAtIndex:0] == '#') {
        [[NSScanner scannerWithString:[stringColor substringFromIndex:1]] scanHexInt:&c];
    } else {
        [[NSScanner scannerWithString:stringColor] scanHexInt:&c];
    }
    return [UIColor colorWithRed:((c & 0xff0000) >> 16)/255.0 green:((c & 0xff00) >> 8)/255.0 blue:(c & 0xff)/255.0 alpha:1.0];
}

#pragma mark - bytes
+ (NSString *)bytesConvert:(float)bytes {
	NSString *result;
	if (bytes == 1) {
		result = @"1 byte";
	}
	else if(bytes < 1024){
		result = [NSString stringWithFormat:@"%f bytes",bytes];
	}
	else if(bytes < (1024 * 1024 * 0.1)){
		result = [CommonUtil stringForNumber:bytes / 1024.0 asUnits:@"KB"];
	}
	else if(bytes < 1024.0 * 1024.0 * 1024.0 * 0.1){
		result = [CommonUtil stringForNumber:bytes / (1024.0 * 1024.0) asUnits:@"MB"];
	}
	else {
		result = [CommonUtil stringForNumber:bytes / (1024.0 * 1024.0) asUnits:@"MB"];
	}
	return result;
}

+(NSString *)stringForNumber:(float)num asUnits:(NSString *)units
{
    NSString *  result;
    float      fractional;
    float      integral;
    
    fractional = modff(num, &integral);
    if ( (fractional < 0.1) || (fractional > 0.9) ) {
        result = [NSString stringWithFormat:@"%.2f %@", round(num), units];
    } else {
        result = [NSString stringWithFormat:@"%.2f %@", num, units];
    }
    return result;
}

#pragma mark - Http请求处理
+ (NSString *)httpErrorWithCode:(int)code{
    NSString *strError =STRINGEMPTY;
    
    switch (code) {
        case 400:
        {
            strError =@"HttpError400";
        }
            break;
            
        case 404:
        {
            strError =@"HttpError404";
        }
            break;
            
        case 500:{
            strError =@"HttpError500";
        }
            break;
            
        case 502:{
            strError = @"HttpError502";
        }
            break;
            
        case -1001:{
            strError =@"HttpError1001";
        }
            break;
        case -1004:{
            strError =@"HttpError1004";
        }
            break;
            
        case -1009:{
            strError =@"HttpError1009";
        }
            break;
            
        default:
        {
            strError =@"末知错误！";
        }
            break;
    }
    
    return strError;
    
}

+ (void)clearURLCacheForRequest:(NSURLRequest *)request
{
	float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
	if (systemVersion >= 6.0) {
		[[NSURLCache sharedURLCache] removeCachedResponseForRequest:request];
	}
}

+(NSString*) convertServerURL:(NSString *)serverUrl  withBaseURL:(NSString*)baseURL{
    if (G_ISRELEASE) {
        serverUrl = [NSString stringWithFormat:@"%@%@",baseURL,serverUrl];
    }
    else {
        NSArray *settingConfigArray = [CommonUtil findUserDefaultsWithKey:SETTINGCONFIG_USERDEFAULTS];
        if (settingConfigArray) {
            NSDictionary *tempDict = [settingConfigArray objectAtIndex:[settingConfigArray count] - 1];
            NSString *ssl = @"http://";
            if ((BOOL)[tempDict objectForKey:@"ssl"]) {
                ssl= @"https://";
            }
            serverUrl = [NSString stringWithFormat:@"%@%@%@",ssl,[tempDict objectForKey:@"url"],serverUrl];
        }
        else {
            serverUrl = [NSString stringWithFormat:@"%@%@",baseURL,serverUrl];//;
        }
    }
    return serverUrl;
}


#pragma mark - UserDefaults相关的操作
+ (BOOL)saveUserDefaultsWithValue:(id)defaultValue withKey : (NSString *)defaultKey {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:defaultValue forKey:defaultKey];
    BOOL saveFlag = [userDefaults synchronize];
    return saveFlag;
}

+ (id) findUserDefaultsWithKey:(NSString *)defaultKey {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    id keyValue = [userDefaults objectForKey:defaultKey];
    return keyValue;
}

@end
