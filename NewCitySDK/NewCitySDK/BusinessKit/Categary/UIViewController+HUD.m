//
//  CategoryUtils.h
//  smartcity
//
//  Created by kongjun on 13-11-1.
//  Copyright (c) 2013年 Shenghuo. All rights reserved.
//

#import "UIViewController+HUD.h"
#import "MacroDefine.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import <objc/runtime.h>

static const void *HttpRequestHUDKey = &HttpRequestHUDKey;

@implementation UIViewController (HUD)

- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHudInView:(UIView *)view hint:(NSString *)hint{
    MBProgressHUD *oldHUD = [self HUD];
    if (oldHUD) {
        [oldHUD hide:YES];
    }
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
//    HUD.labelText = hint;
//    [view addSubview:HUD];
//    [HUD show:YES];
//    [self setHUD:HUD];
    
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle]pathForResource:@"NewCitySDK.framework" ofType:nil]];
    
    NSString* path = [bundle pathForResource:@"new_loading_black" ofType:@"gif"];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    [image sd_setImageWithURL:[NSURL fileURLWithPath:path]];
    image.layer.cornerRadius = 4;
    HUD.customView = image;
//    HUD.labelText = hint;
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.opacity = 0.2;
    HUD.color = [UIColor clearColor];
    [view addSubview:HUD];
    [HUD show:YES];
    [self setHUD:HUD];
}

- (void)showHint:(NSString *)hint
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = hint;
    hud.detailsLabelFont = [UIFont systemFontOfSize:16];
    hud.margin = 10.f;
    hud.yOffset = IS_IPHONE_5?200.f:250.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

- (void)hideHud{
    MBProgressHUD *hud = [self HUD];
    if (hud) {
        [hud hide:YES];
    }
}

@end
