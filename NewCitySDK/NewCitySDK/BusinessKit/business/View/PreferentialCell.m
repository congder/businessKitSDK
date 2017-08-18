//
//  PreferentialCell.m
//  BusinessKit
//
//  Created by zevwings on 2017/8/10.
//  Copyright © 2017年 高庆华. All rights reserved.
//

#import "PreferentialCell.h"
#import "Masonry.h"
#import "NSString+Price.h"
#import "UIImageView+WebCache.h"

@interface PreferentialCell ()

@property (strong, nonatomic) UILabel *dishesLabel;
@property (strong, nonatomic) UILabel *originalLabel;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UILabel *sealNumLb;

@property (strong, nonatomic) UIImageView *logoImageView;
@property (strong, nonatomic) UIImageView *discountIcon;

@end

@implementation PreferentialCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {

    self.dishesLabel = [[UILabel alloc] init];
    [_dishesLabel setFont:[UIFont systemFontOfSize:14.0]];
    [_dishesLabel setTextColor:[UIColor colorWithWhite:50.0 / 255.0 alpha:1.0]];
    [self addSubview:_dishesLabel];
    
    self.originalLabel = [[UILabel alloc] init];
    [_originalLabel setFont:[UIFont systemFontOfSize:12.0]];
    [self addSubview:_originalLabel];
    
    self.priceLabel = [[UILabel alloc] init];
    [_priceLabel setFont:[UIFont systemFontOfSize:16.0]];
    [self addSubview:_priceLabel];
    
    self.sealNumLb = [[UILabel alloc] init];
    [_sealNumLb setTextColor:[UIColor colorWithWhite:50.0 / 255.0 alpha:1.0]];
    [_sealNumLb setFont:[UIFont systemFontOfSize:12.0]];
    [self addSubview:_sealNumLb];
    
    self.logoImageView = [[UIImageView alloc] init];
    [_logoImageView.layer setCornerRadius:5.0];
    [self addSubview:_logoImageView];
    
    self.discountIcon = [[UIImageView alloc] init];
    [_discountIcon setHidden:YES];
    [self addSubview:_discountIcon];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(18);
        make.centerY.equalTo(self);
        make.width.equalTo(@100);
        make.height.equalTo(_logoImageView.mas_width).multipliedBy(0.7);
    }];
    
    [_dishesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_logoImageView.mas_right).offset(12);
        make.top.equalTo(_logoImageView.mas_top).offset(0);
        make.right.equalTo(self).offset(-12);
        make.height.equalTo(@20);
    }];
    
    [_originalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_logoImageView.mas_right).offset(12);
        make.centerY.equalTo(_logoImageView);
        make.right.equalTo(self).offset(-12);
    }];
    
    [_sealNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-18);
        make.height.equalTo(_originalLabel.mas_height);
    }];

    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_logoImageView.mas_right).offset(12);
        make.bottom.equalTo(_logoImageView.mas_bottom).offset(-4);
        make.right.equalTo(self).offset(-12);
    }];

    [_discountIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(_logoImageView);
        make.height.equalTo(_logoImageView).multipliedBy(0.5);
        make.width.equalTo(_discountIcon.mas_height);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Setter / Getter

- (void)setDishes:(NSString *)dishes {
    [self.dishesLabel setText:dishes];
}

- (void)setOriginl:(NSString *)originl {
    NSString *string = [NSString stringWithFormat:@"原价：￥%@", [NSString prodContentString:originl]];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSUInteger length = [string length];
    
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:[UIColor colorWithWhite:155.0 / 255.0 alpha:1.0]
                       range:NSMakeRange(0, 3)];
    
    [attrString addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:12.0]
                       range:NSMakeRange(0, 3)];

    [attrString addAttribute:NSForegroundColorAttributeName
                       value:[UIColor colorWithWhite:155.0 / 255.0 alpha:1.0]
                       range:NSMakeRange(3, length - 3)];
    
    [attrString addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:12.0]
                       range:NSMakeRange(3, length - 3)];

    [self.originalLabel setAttributedText:attrString];

}

- (void)setPrice:(NSString *)price {
    
    NSString *string = [NSString stringWithFormat:@"现价：￥%@", [NSString prodContentString:price]];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSUInteger length = [string length];
    
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:[UIColor colorWithWhite:155.0 / 255.0 alpha:1.0]
                       range:NSMakeRange(0, 3)];
    
    [attrString addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:14.0]
                       range:NSMakeRange(0, 3)];
    
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:[UIColor colorWithRed:246.0 / 255.0 green:114.0 / 255.0 blue:124.0 / 255.0 alpha:1.0]
                       range:NSMakeRange(3, length - 3)];
    
    [attrString addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:14.0]
                       range:NSMakeRange(3, length - 3)];

    [self.priceLabel setAttributedText:attrString];

}

- (void)setSealNum:(NSString *)sealNum {
    
    if (sealNum == nil || [sealNum isEqualToString:@""]) {
        self.sealNumLb.text = [NSString stringWithFormat:@"已售：%@", @"0"];
    } else {
        self.sealNumLb.text = [NSString stringWithFormat:@"已售：%@",sealNum];
    }
}

- (void)setLogoUrl:(NSString *)logoUrl {
    NSURL *url = [NSURL URLWithString:logoUrl];
    [self.logoImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"h_default_background"]];
}

@end
