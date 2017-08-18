//
//  CouponMoreTableViewCell.m
//  SmartCommunity
//
//  Created by 陈洋 on 16/1/10.
//  Copyright © 2016年 shenghuo. All rights reserved.
//

#import "CouponMoreTableViewCell.h"

@interface CouponMoreTableViewCell()
@end

@implementation CouponMoreTableViewCell
- (void)awakeFromNib {
    UIView *line = UIView.new;
    line.backgroundColor = mColor(clearColor);
    [self addSubview:line];
    [line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.leading.equalTo(self);
        make.trailing.equalTo(self);
        make.height.equalTo(@0.6);
    }];
}
@end
