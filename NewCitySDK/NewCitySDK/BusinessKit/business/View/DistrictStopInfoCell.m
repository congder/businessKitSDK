//
//  DistrictStopInfo.m
//  SmartCommunity
//
//  Created by Echo on 16/5/6.
//  Copyright © 2016年 shenghuo. All rights reserved.
//

#import "DistrictStopInfoCell.h"

@implementation DistrictStopInfoCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setData:(NSDictionary *)data{
    NSLog(@"%@",data);
    if (data[@"parking"] !=nil) {
        self.stopInfoLb.text = data[@"parking"];
    }else{
        self.stopInfoLb.text = @"暂无信息";
    }
    
}
+ (CGFloat)measuredHeight:(NSString *)text {
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 50;
    //    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:0 attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16.f]} context:nil];
    CGSize sizeToFit = [text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];//shadongbao
    
    return sizeToFit.height + 62;
}

@end
