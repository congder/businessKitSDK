//
//  DistrictMapTableViewCell.m
//  SmartCommunity
//
//  Created by Xiaowen Ji on 06/12/15.
//  Copyright © 2015 shenghuo. All rights reserved.
//

#import "DistrictMapTableViewCell.h"
#import "ImageManager.h"

@implementation DistrictMapTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(NSDictionary *)data {
    NSString *loc = [NSString stringWithFormat:@"%@,%@", data[@"longitude"], data[@"latitude"]];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = 180;
    NSString *mapUrl;
    if ([data[@"longitude"]isEqualToString :@""]&&[data[@"latitude"] isEqualToString:@""]) {
        mapUrl = [NSString stringWithFormat:@"http://api.map.baidu.com/staticimage?width=320&height=180&scale=2&zoom=10&markerStyles=l,A,0xff0000"];
//        DLog(@"百度地图请求kong%@",mapUrl);
    }else{
     mapUrl = [NSString stringWithFormat:@"http://api.map.baidu.com/staticimage?width=%.0f&height=%.0f&scale=2&zoom=18&markerStyles=l,A,0xff0000&center=%@&markers=%@", width, height, loc, loc];
//         DLog(@"百度地图请求%@",mapUrl);
    }
    
   
    [[ImageManager sharedManager] imageForURL:mapUrl onCompletion:^(UIImage *image, NSError *error) {
        if (!error) {
            self.mapImageView.image = image;
        }
    }];
    
    NSString *address = [NSString stringWithFormat:@"%@%@%@",[[data objectForKey:@"address"] objectForKey:@"city"],[[data objectForKey:@"address"] objectForKey:@"region"],[[data objectForKey:@"address"] objectForKey:@"address"]];
    self.addressLabel.text = address;
}

+ (NSString *) getMapAddress: (NSDictionary *) detailDict {
    NSString *address = [NSString stringWithFormat:@"%@",[[detailDict objectForKey:@"address"] objectForKey:@"address"]];
    return address;
}

@end
