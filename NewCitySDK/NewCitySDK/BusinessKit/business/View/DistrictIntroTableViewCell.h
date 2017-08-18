//
//  DistrictIntroTableViewCell.h
//  SmartCommunity
//
//  Created by Xiaowen Ji on 06/12/15.
//  Copyright © 2015 shenghuo. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface DistrictIntroTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UIImageView *iconImage;

@property (strong, nonatomic) IBOutlet UIView *middleLine;

@property (strong, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLeadingConstraints;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineLeft;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descTopConstraints;

- (void)hideTitleIcon;

- (void)showTitleIcon;

+ (CGFloat)measuredHeight:(NSString *)text;

@end
