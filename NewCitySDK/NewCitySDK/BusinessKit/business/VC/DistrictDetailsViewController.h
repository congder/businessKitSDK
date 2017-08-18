//
//  DistrictDetailsViewController.h
//  SmartCommunity
//
//  Created by apple on 15/5/19.
//  Copyright (c) 2015年 shenghuo. All rights reserved.
//

#import "CommonViewController.h"
#import "DistricModel.h"
/****乐生活商圈点击商家进入商家详情界面*****/
@interface DistrictDetailsViewController : UIViewController<UIAlertViewDelegate>
@property (nonatomic, strong) DistricModel *districModel;
/****是否是商圈推过来的,默认不是*****/
@property (nonatomic,assign) BOOL isBussinessCircle;
@end
