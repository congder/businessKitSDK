//
//  PreferentialCell.h
//  BusinessKit
//
//  Created by zevwings on 2017/8/10.
//  Copyright © 2017年 高庆华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreferentialCell : UITableViewCell

@property (strong, nonatomic) NSString *dishes;
@property (strong, nonatomic) NSString *originl;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *sealNum;

@property (strong, nonatomic) NSString *logoUrl;
@property (strong, nonatomic) NSString *discount;

@end
