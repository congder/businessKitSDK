//
//  DistrictBaseTableViewCell.m
//  SmartCommunity
//
//  Created by Xiaowen Ji on 06/12/15.
//  Copyright © 2015 shenghuo. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MacroDefine.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *)reuseIdentifier {
    return NSStringFromClass(self.class);
}

- (void)setData:(NSDictionary *)data {
    [NSException raise:@"Non implemented method" format:@"Should implement setData: method in subclasses."];
}
- (void)setDataModel:(id)model{
    
    
}
@end
