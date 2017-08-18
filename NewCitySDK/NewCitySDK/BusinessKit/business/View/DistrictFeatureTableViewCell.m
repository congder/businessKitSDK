//
//  DistrictFeatureTableViewCell.m
//  SmartCommunity
//
//  Created by Xiaowen Ji on 07/12/15.
//  Copyright © 2015 shenghuo. All rights reserved.
//

#import "DistrictFeatureTableViewCell.h"

@implementation DistrictFeatureTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(NSDictionary *)data {
    _dmts.text = [self storeInfo:[data objectForKey:@"special"]];
}

+ (CGFloat)measuredHeight:(NSString *)text {
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 50;
    //    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:0 attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16.f]} context:nil];
    CGSize sizeToFit = [text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];//shadongbao
    
    return sizeToFit.height + 62;
}

//数据处理
- (NSString *)storeInfo:(NSString *)string
{
    NSString *telNum = string;
    if ([telNum isKindOfClass:[NSNull class]] || [telNum isEqualToString:@""]) {
        telNum = @"暂无数据";
    }
    return telNum;
}

@end
