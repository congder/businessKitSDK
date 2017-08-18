//
//  UIImage+load.m
//  NewCitySDK
//
//  Created by weibin on 2017/8/17.
//  Copyright © 2017年 weibin. All rights reserved.
//

#import "UIImage+load.h"
#import "BundleTools.h"
#import <objc/runtime.h>
@implementation UIImage (load)

+(void)load{

    Method m1 = class_getClassMethod([UIImage class], @selector(imageNamed:));
    
    Method m2 = class_getClassMethod([UIImage class], @selector(WB_imageNamed:));
    
    method_exchangeImplementations(m1, m2);
}
+ (UIImage *)WB_imageNamed:(NSString *)name{

    UIImage *image = [UIImage WB_imageNamed:name];
    NSLog(@"456789,我试运行时代码");
    if (image) {
        return image;
    }else{
        return [UIImage imageNamed:name inBundle:[BundleTools getBundle] compatibleWithTraitCollection:nil];
    }

}
//+ (UIImage *)imageNamed:(NSString *)name{
//
//    NSLog(@"加载了imageNamed分类方法");
//    UIImage *image=[UIImage imageNamed:name];
//    
//    if (image == nil) {
//        return [self imageNamed:name inBundle:[BundleTools getBundle] compatibleWithTraitCollection:nil];
//    }else{
//        return image;
//    }
//}
@end
