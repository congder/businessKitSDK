//
//  NSString+MD5Addition.m
//  smartcity
//
//  Created by chenlaifang on 13-11-1.
//  Copyright (c) 2013年 wanghuafeng. All rights reserved.
//

#import "NSString+MD5Addition.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString(MD5Addition)

- (NSString *) stringFromMD5{
    
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

- (NSString*) sha256
{
//    const char *cstr = [self UTF8String];
//    NSData *data = [NSData dataWithBytes:cstr length:self.length];
//    
//    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
//    
//    CC_SHA256(data.bytes,data.length, digest);
//    
//    NSData *da=[[NSData alloc]initWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
//    
//    NSData *str=[GTMBase64 encodeData:da];
//    NSString *output=[[NSString alloc]initWithData:str  encoding:NSUTF8StringEncoding];
//    return output;
    
//    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
//    NSData *data = [NSData dataWithBytes:cstr length:self.length];
//    
//    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
//    
//    CC_SHA256(data.bytes, data.length, digest);
//    
//    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
//    
//    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
//        [output appendFormat:@"%02x", digest[i]];
//    
//    return output;
    
    const char *s=[self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData=[NSData dataWithBytes:s length:strlen(s)];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(keyData.bytes, keyData.length, digest);
    NSData *out=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    return hash;
}

@end
