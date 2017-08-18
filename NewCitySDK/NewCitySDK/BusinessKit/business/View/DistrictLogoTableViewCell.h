//
//  DistrictLogoTableViewCell.h
//  SmartCommunity
//
//  Created by Xiaowen Ji on 06/12/15.
//  Copyright © 2015 shenghuo. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "CarouselScrollerView.h"

@interface DistrictLogoTableViewCell : BaseTableViewCell<UIScrollViewDelegate>

@property (strong, nonatomic) CarouselScrollerView *logoImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIView *bottomBlackView;
@end
