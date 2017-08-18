//
//  DistrictCellV2.m
//  SmartCommunity
//
//  Created by 陈洋 on 16/1/8.
//  Copyright © 2016年 shenghuo. All rights reserved.
//

#import "DistrictCellV2.h"
#import "ImageManager.h"
#import "MacroDefine.h"
#import "TTTAttributedLabel.h"

#import "Masonry.h"
#import "UIImageView+WebCache.h"
#define DEFAULT_MARGIN 10
@interface DistrictCellV2() {
    UIImage *loadingImage;
    float sepMarginTop;
    float sepMarginTopWithCoupon;
    CAShapeLayer *shapeLayer;
    BOOL showCoupon;
}
@property (nonatomic, assign) BOOL didSetupConstraints;
@property (strong, nonatomic) UIView *container; //分割线
@property (strong, nonatomic) UIView *sepView; //分割线
@end
@implementation DistrictCellV2
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self main];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self main];
    }
    return self;
}

-(void) main {
    sepMarginTop = 5;
    sepMarginTopWithCoupon = 33;
    loadingImage = [UIImage imageNamed:@"hDefaultBg"];
    self.districtImageView = UIImageView.new;
    self.container = UIView.new;
    self.nameLabel = UILabel.new;
    self.addressIcon = UIImageView.new;
    self.addressLabel = UILabel.new;
    self.distanceLabel = UILabel.new;
    self.avgPriceLabel = UILabel.new;
    self.couponIcon = UIImageView.new;
    self.couponLabel = UILabel.new;
    self.sepView  = UIView.new;
    
    [self.contentView addSubview:self.districtImageView];
    [self.contentView addSubview:self.container];
    
    [self.container addSubview:self.nameLabel];
    [self.container addSubview:self.addressIcon];
    [self.container addSubview:self.addressLabel];
    [self.container addSubview:self.distanceLabel];
    [self.container addSubview:self.avgPriceLabel];
    
    [self.contentView addSubview:self.couponIcon];
    [self.contentView addSubview:self.couponLabel];
    [self.contentView addSubview:self.sepView];
    
    [self styleUI];
}

-(void) styleUI {
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    self.nameLabel.textColor = mRGBToColor(0x323232);
    
    self.addressIcon.image = [UIImage imageNamed:@"cLocation"];
    self.addressIcon.contentMode = UIViewContentModeScaleAspectFit;
    
    self.addressLabel.font = [UIFont systemFontOfSize:13];
    self.addressLabel.textColor = mRGBToColor(0x8d8b88);
    self.addressLabel.numberOfLines = 1;
    
    self.avgPriceLabel.textColor = mRGBToColor(0xf75555);
    self.avgPriceLabel.font = [UIFont systemFontOfSize:13];
    self.avgPriceLabel.textAlignment = NSTextAlignmentRight;
    
    self.distanceLabel.font = [UIFont systemFontOfSize:13];
    self.distanceLabel.textColor = mRGBToColor(0x8d8b88);
   // self.distanceLabel.backgroundColor = [UIColor redColor];
    self.distanceLabel.textAlignment = NSTextAlignmentRight;
    

    self.couponIcon.image = [UIImage imageNamed:@"cNewCoupon"];
    self.districtImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.districtImageView.clipsToBounds = YES;
    
    self.couponLabel.textColor = mRGBToColor(0x323232);
    self.couponLabel.font = [UIFont systemFontOfSize:13];
    
    self.sepView.backgroundColor = mRGBColor(240, 240, 240);
    
//
//    shapeLayer = [CAShapeLayer layer];
//    [shapeLayer setBounds:self.bounds];
//    [shapeLayer setPosition:self.center];
//    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
//    
//    // 设置虚线颜色为blackColor
//    [shapeLayer setStrokeColor:mRGBColor(224, 224, 224).CGColor];
//    
//    // 3=线的宽度 1=每条线的间距
//    [shapeLayer setLineDashPattern:
//     [NSArray arrayWithObjects:[NSNumber numberWithInt:4],
//      [NSNumber numberWithInt:2],nil]];
//    
//    // Setup the path
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathMoveToPoint(path, NULL, DEFAULT_MARGIN, 112);
//    CGPathAddLineToPoint(path, NULL, mScreenWidth - DEFAULT_MARGIN, 112);
//    
//    [shapeLayer setPath:path];
//    CGPathRelease(path);
}

- (void) hideCouponInfo {
//    if (!showCoupon) {
//        return;
//    }
    showCoupon = NO;
    [self.districtImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(@10);
        make.left.equalTo(self.contentView).offset(@10);
        //make.leading.equalTo(self.contentView).offset(DEFAULT_MARGIN);
        make.size.equalTo(CGSizeMake(90, 85));
    }];
    
    [self.sepView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.districtImageView.mas_bottom).offset(sepMarginTop+9);
    }];
    
    [shapeLayer removeFromSuperlayer];
    _couponIcon.hidden = YES;
    _couponLabel.hidden = YES;
}

- (void) showCouponInfo {
//    if (showCoupon) {
//        return;
//    }
    showCoupon = YES;
    
    [self.districtImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(@10);
        make.left.equalTo(self.contentView).offset(@10);
       // make.leading.equalTo(self.contentView).offset(DEFAULT_MARGIN);
        make.size.equalTo(CGSizeMake(90, 85));
    }];
    
    
    [self.sepView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.districtImageView.mas_bottom).offset(sepMarginTopWithCoupon);
    }];
    
    [[self layer] addSublayer:shapeLayer];
    _couponIcon.hidden = NO;
    _couponLabel.hidden = NO;
}

- (void) refreshCouponUI {
    if (_disModel != nil && [_disModel hasGoodsList]) {
        [self showCouponInfo];
        NSDictionary *firstGoods = _disModel.goodsList[0];
        self.couponLabel.text = firstGoods[@"name"];
        NSDictionary *bankDisconunt = [mAppUtils findBankDiscount:firstGoods[@"name"]];
        if (bankDisconunt) {
            _couponLabel.text     = bankDisconunt[@"name"];
        } else {
            _couponLabel.text     = firstGoods[@"name"];
        }
    } else {
        [self hideCouponInfo];
    }
}

- (void)setDisModel:(DistricModel *)disModel
{
    _disModel = disModel;
    if (disModel) {
        _nameLabel.text = disModel.titleName;
        _addressLabel.text = disModel.address;
        if ([@"" isEqualToString:disModel.distance] || disModel.distance == nil) {
            _distanceLabel.text = @"";
        }else{
            @try {
                double distanceDouble = disModel.distance.doubleValue;
                NSString *distanceStr = @"";
                if(distanceDouble > 1000) {
                    distanceStr = [NSString stringWithFormat:@"%.2fkm", disModel.distance.doubleValue / 1000];
                } else {
                    distanceStr = [NSString stringWithFormat:@"%.0fm", disModel.distance.doubleValue];
                }
                _distanceLabel.text = distanceStr;
            }
            @catch (NSException *exception) {
                _distanceLabel.text = @"";
            }
            @finally {
            }
        }
        UIImage *image = [UIImage imageNamed:@"hDefaultBg"];
        if (disModel.photoUrl.length > 0) {
            [_districtImageView sd_setImageWithURL:[NSURL URLWithString:disModel.photoUrl] placeholderImage:image];
        }else{
            _districtImageView.image = image;
        }
    }
}

-(void) updateConstraints {
    if (!self.didSetupConstraints) {
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        
        [self.districtImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(@10);
            make.left.equalTo(self.contentView).offset(@10);
           // make.leading.equalTo(self.contentView).offset(DEFAULT_MARGIN);
            make.size.equalTo(CGSizeMake(90, 85));
        }];
        
        [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.districtImageView);
            make.left.equalTo(self.districtImageView.mas_right).offset(DEFAULT_MARGIN);
            make.right.equalTo(self.contentView).offset(-DEFAULT_MARGIN);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.container.mas_top);
            make.leading.equalTo(self.container);
            make.trailing.equalTo(self.avgPriceLabel.mas_leading);
        }];
        [self.nameLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        
        [self.addressIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(DEFAULT_MARGIN);
            make.left.equalTo(self.nameLabel.mas_left);
            make.size.equalTo(CGSizeMake(13, 13));
        }];
        
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.addressIcon.mas_right).offset(DEFAULT_MARGIN/2);
            make.top.equalTo(self.addressIcon.mas_top).offset(-2);
            make.bottom.equalTo(self.container);
        }];
        [self.addressLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        
        [self.avgPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.container).offset(-DEFAULT_MARGIN/2);
            make.top.equalTo(self.nameLabel);
        }];
        
        [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.addressLabel.mas_top);
            make.left.greaterThanOrEqualTo(self.addressLabel.mas_right).offset(DEFAULT_MARGIN);
            make.trailing.equalTo(self.container).offset(-DEFAULT_MARGIN/2);
        }];
        [self.distanceLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        
        [self.couponIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.districtImageView.mas_leading);
            make.top.equalTo(self.districtImageView.mas_bottom).offset(10);
            make.size.equalTo(CGSizeMake(16, 16));
        }];
        
        [self.couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.couponIcon.mas_trailing).offset(DEFAULT_MARGIN);
            make.centerY.equalTo(self.couponIcon);
            make.trailing.equalTo(self.couponLabel.superview);
        }];
        
        [self.sepView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.districtImageView.mas_bottom).offset(sepMarginTopWithCoupon);
            make.height.equalTo(@1);
            make.leading.equalTo(self.sepView.superview);
            make.trailing.equalTo(self.sepView.superview);
        }];
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}
@end
