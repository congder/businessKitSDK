//
//  CategoryUtils.h
//  smartcity
//
//  Created by kongjun on 13-11-1.
//  Copyright (c) 2013年 Shenghuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIViewController (HUD)

- (void)showHudInView:(UIView *)view hint:(NSString *)hint;

- (void)hideHud;

- (void)showHint:(NSString *)hint;

@end
