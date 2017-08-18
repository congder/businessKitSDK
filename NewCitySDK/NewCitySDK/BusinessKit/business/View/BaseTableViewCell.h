//
//  DistrictBaseTableViewCell.h
//  SmartCommunity
//
//  Created by Xiaowen Ji on 06/12/15.
//  Copyright © 2015 shenghuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MacroDefine.h"

@interface BaseTableViewCell : UITableViewCell

- (void)setData:(NSDictionary *)data;
- (void)setDataModel:(id)model;

@end
