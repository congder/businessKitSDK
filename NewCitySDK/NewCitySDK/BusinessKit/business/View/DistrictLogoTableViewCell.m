//
//  DistrictLogoTableViewCell.m
//  SmartCommunity
//
//  Created by Xiaowen Ji on 06/12/15.
//  Copyright © 2015 shenghuo. All rights reserved.
//

#import "DistrictLogoTableViewCell.h"
#import "ImageManager.h"
#import "Masonry.h"

@interface  DistrictLogoTableViewCell() {
}

@end
@implementation DistrictLogoTableViewCell

- (void)awakeFromNib {
    
    self.logoImageView =  CarouselScrollerView.new;
    self.titleLabel = UILabel.new;
    self.bottomBlackView = UIView.new;
    
    self.bottomBlackView.backgroundColor = [UIColor blackColor];
    self.bottomBlackView.alpha = 0.54;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentRight;
    self.titleLabel.numberOfLines = 3;
    
    [self.contentView addSubview:self.logoImageView];
    [self.contentView addSubview:self.bottomBlackView];
    [self.bottomBlackView addSubview:self.titleLabel];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.bottomBlackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.titleLabel).offset(@16);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.centerY.equalTo(self.bottomBlackView);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(NSDictionary *)data {
    NSArray *photoList = data[@"photo_list"];
    NSString *photoUrl = data[@"photo_url"];
    UIImage *defaultImage = [UIImage imageNamed:@"hDefaultBg"];
    self.logoImageView.defaultImage = defaultImage;
    NSMutableArray *array = NSMutableArray.new;
    if (photoList) {
        for (NSDictionary *item in photoList) {
            NSString *url = item[@"url"];
            NSString *imagesSize = item[@"imagesSize"];
            if (url && [@"2" isEqualToString:imagesSize]) {
                NSDictionary *urlDic = @{@"img_url": url, @"stop_time": @"3.2"};
                if ([url isEqualToString:photoUrl]) {
                    [array insertObject:urlDic atIndex:0];
                } else {
                    [array addObject:urlDic];
                }
            }
        }
    } else if(photoUrl) {
        NSDictionary *urlDic = @{@"img_url": photoUrl, @"stop_time": @"3.2"};
        [array addObject:urlDic];
    }
    
    
    [self.logoImageView setImagesData:array];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *bankDisconunt = [mAppUtils findBankDiscount:data[@"name"]];
    if (bankDisconunt) {
        _titleLabel.text     = bankDisconunt[@"name"];
    } else {
        _titleLabel.text     = data[@"name"];
    }
}

@end
