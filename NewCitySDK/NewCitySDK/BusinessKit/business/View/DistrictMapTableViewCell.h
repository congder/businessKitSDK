//
//  DistrictMapTableViewCell.h
//  SmartCommunity
//
//  Created by Xiaowen Ji on 06/12/15.
//  Copyright © 2015 shenghuo. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface DistrictMapTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mapImageView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

+ (NSString *) getMapAddress: (NSDictionary *) detailDict;

@end
