//
//  DistrictViewController.h
//  BusinessKit
//
//  Created by cc on 2017/8/8.
//  Copyright © 2017年 高庆华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DistrictViewController: UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSDictionary *allTypeCase;
@property (strong, nonatomic) NSDictionary *distanceCase;
@property (strong, nonatomic) NSDictionary *priceCase;
@property (strong, nonatomic) UITableView *districtTableView; //商铺TableView
@property (copy,nonatomic) NSString *latitude;
@property (copy,nonatomic) NSString *longitude;

- (void)districtHeaderRereshing;
@end
