//
//  DistrictIntroTableViewCell.m
//  SmartCommunity
//
//  Created by Xiaowen Ji on 06/12/15.
//  Copyright © 2015 shenghuo. All rights reserved.
//

#import "DistrictIntroTableViewCell.h"

@implementation DistrictIntroTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(NSDictionary *)data {
//    if (data[@"desc"]) {
//        self.introLabel.text = [data[@"desc"] stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
//    }
    self.introLabel.text = data[@"desc"];
}

+ (CGFloat)measuredHeight:(NSString *)text {
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 50;
//    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:0 attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16.f]} context:nil];
     CGSize sizeToFit = [text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];//shadongbao
    
    return sizeToFit.height + 62;
}

- (void)hideTitleIcon {
    _titleLeadingConstraints.constant = -15;
    _iconImage.alpha = 2;
}


- (void)showTitleIcon {
    _titleLeadingConstraints.constant = 8;
    _iconImage.alpha = 1;
}


@end
