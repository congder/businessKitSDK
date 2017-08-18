//
//  BundleTools.m
//  NewCitySDK
//
//  Created by weibin on 2017/8/17.
//  Copyright © 2017年 weibin. All rights reserved.
//

#import "BundleTools.h"
#define BUNDLE_NAME @"NewCitySDK.framework"
@implementation BundleTools

+ (NSBundle *)getBundle{
    return [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:BUNDLE_NAME ofType:nil]];
}

@end
