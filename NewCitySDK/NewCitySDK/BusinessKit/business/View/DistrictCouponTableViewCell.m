//
//  DistrictCouponTableViewCell.m
//  SmartCommunity
//
//  Created by 陈洋 on 16/1/5.
//  Copyright © 2016年 shenghuo. All rights reserved.
//

#import "DistrictCouponTableViewCell.h"

@interface DistrictCouponTableViewCell() {
}
@property(strong, nonatomic) UIView *bottomLine;
@end

@implementation DistrictCouponTableViewCell

- (void)awakeFromNib
{
    // Initialization cod
    [super awakeFromNib];
    _bottomLine = UIView.new;
    _bottomLine.backgroundColor = mColor(clearColor);
    [self addSubview:_bottomLine];
    [_bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.leading.equalTo(self.discountIcon);
        make.trailing.equalTo(self);
        make.height.equalTo(@0.6);
    }];
}

- (void)setData:(NSDictionary *)data {
    
    self.couponNameLabel.text = data[@"name"];
    NSDictionary *bankDisconunt = [mAppUtils findBankDiscount:data[@"name"]];
    if (bankDisconunt) {
        _couponNameLabel.text     = bankDisconunt[@"name"];
        [mAppUtils doBankDiscountIcon:bankDisconunt withImageView:self.discountIcon withIconName:@"icon3"];
    } else {
        _couponNameLabel.text     = data[@"name"];
        self.discountIcon.alpha = 0;
    }
    NSString *priceString = data[@"price"];
    if (priceString != nil || [@"" isEqualToString:priceString]) {
         self.couponPrice.text = [NSString stringWithFormat:@"¥%.02f",[priceString floatValue]/100];
    }
    
    NSString *showPrice = data[@"show_price"];
    if (showPrice != nil || [@"" isEqualToString:showPrice]) {
        self.normalPrice.text = [NSString stringWithFormat:@"门市价:¥%0.2f",[showPrice floatValue]/100];
    }
    NSString *sealNum;
    if (data[@"productSoldNo"] || ![@"" isEqualToString:data[@"productSoldNo"]]) {
        sealNum = data[@"productSoldNo"];
    }else{
        sealNum = @"0";
    }
    _sealNumLb.text = [NSString stringWithFormat:@"已售:%@",sealNum];
}

+ (CGFloat)measureHeight:(NSString *)name {
    NSString *shownName = name;
    NSDictionary *bankDisconunt = [mAppUtils findBankDiscount:name];
    if (bankDisconunt) {
        shownName     = bankDisconunt[@"name"];
    } else {
        shownName     = name;
    }
    CGFloat height = [name boundingRectWithSize:CGSizeMake(mScreenWidth - 65, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]} context:nil].size.height + 110;
    return height;
}

- (void)hideBottomLine {
    self.bottomLine.alpha = 0;
}

- (void)showBottomLine {
    self.bottomLine.alpha = 1;
}

- (void)drawRect:(CGRect)rect
{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:200/255.0 green:199/255.0 blue:204/255.0 alpha:1].CGColor);
//    CGContextSetLineWidth(context, 1);
//    CGContextMoveToPoint(context, 0, rect.size.height);
//    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
//    CGContextStrokePath(context);
}

@end
