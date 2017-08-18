//
//  DistrictDetailStoreNameCell.m
//  SmartCommunity
//
//  Created by Echo on 16/5/6.
//  Copyright © 2016年 shenghuo. All rights reserved.
//

#import "DistrictDetailStoreNameCell.h"

@implementation DistrictDetailStoreNameCell


-(void)setData:(NSDictionary *)data{
    
    self.storeNameLb.text = data[@"name"];
    
    float price = [data[@"avg_price"] floatValue];
    self.averagePrice.text = price > 0 ? [NSString stringWithFormat:@"人均:￥ %.2f", price / 100] : @"人均:¥ 0.00";
}

+(float)getStoreNameStringHeight:(NSString *)string{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(150, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]} context:nil];
    return rect.size.height + 30;
    
//    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc]initWithString:string];
//    [attribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, string.length)];
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 143, 0)];
//    label.attributedText = attribute;
//    label.numberOfLines = 0;
//    label.lineBreakMode = NSLineBreakByWordWrapping;
//    [label sizeToFit];
//    return label.frame.size.height + 25;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
