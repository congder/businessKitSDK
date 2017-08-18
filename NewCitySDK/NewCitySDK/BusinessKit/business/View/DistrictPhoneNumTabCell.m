//
//  DistrictPhoneNumTabCell.m
//  SmartCommunity
//
//  Created by Echo on 2017/7/15.
//  Copyright © 2017年 shenghuo. All rights reserved.
//

#import "DistrictPhoneNumTabCell.h"

@implementation DistrictPhoneNumTabCell

- (void)setData:(NSDictionary *)data {
    if (data != nil) {
            NSString *phone = data[@"telephone"];
            NSString *tel = data[@"telNum"];
            self.phoneLab.text = phone.length == 0 ? tel : phone;
        //NSString *address = [DistrictMapTableViewCell getMapAddress:data];
    }
}

@end
