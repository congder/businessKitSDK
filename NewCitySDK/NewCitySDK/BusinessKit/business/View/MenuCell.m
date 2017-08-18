//
//  MenuCell.m
//  SmartCommunity
//
//  Created by apple on 15/5/19.
//  Copyright (c) 2015年 shenghuo. All rights reserved.
//

#import "MenuCell.h"
#import "ImageManager.h"
#import "MacroDefine.h"
#import "UIImageView+WebCache.h"
@interface MenuCell()
@property(strong, nonatomic) UIView *bottomLine;
@end

@implementation MenuCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization cod
    _logoImageView.clipsToBounds = YES;
    
    UIColor *color = mColor(clearColor);
    _numberTextField.layer.borderColor = [color CGColor];
    
    _bottomLine = UIView.new;
    _bottomLine.backgroundColor = mRGBColor(249, 249, 249);
    [self addSubview:_bottomLine];
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.trailing.equalTo(self);
        make.height.equalTo(@10);
        make.leading.equalTo(self.logoImageView);
    }];
}

- (void)setDisModel:(DistrictDetailsModel *)disModel
{
    _disModel = disModel;
    if ([_disModel.number intValue] == 0) {
        _subBtn.hidden = NO;
    }else{
        _subBtn.hidden = NO;
    }
    NSDictionary *bankDisconunt = [mAppUtils findBankDiscount:_disModel.name];
    if (bankDisconunt) {
        _dishesLabel.text     = bankDisconunt[@"name"];
        [mAppUtils doBankDiscountIcon:bankDisconunt withImageView:self.discountIcon withIconName:@"icon1"];
    } else {
        _dishesLabel.text     = _disModel.name;
        self.discountIcon.alpha = 0;
    }
    _numberTextField.text = _disModel.number;
    
    NSString *sealNum;
    if (nil != _disModel.productSoldNo || [@"" isEqualToString:_disModel.productSoldNo]) {
        sealNum = _disModel.productSoldNo;
    }else{
        sealNum = @"0";
    }
    _sealNumLb.text = [NSString stringWithFormat:@"已售:%@",sealNum];
    UIImage *defaultImage = [UIImage imageNamed:@"hDefaultBg"];
    if (disModel.photo_url.length > 0) {
        NSURL *url = [NSURL URLWithString:disModel.photo_url];
        if (url) {
            [_logoImageView sd_setImageWithURL:url placeholderImage:defaultImage];
        } else {
            _logoImageView.image = defaultImage;
        }
    } else {
        _logoImageView.image = defaultImage;
    }
}

- (void)layoutSubviews
{
    _numberTextField.userInteractionEnabled = NO;
}

- (void)setIndexRow:(NSString *)indexRow
{
    _indexRow = indexRow;
    _disModel.indexPathRow = indexRow;
}

- (void)hideSealNumLb {
    _addBtn.hidden = YES;
    _subBtn.hidden = YES;
    _numberTextField.hidden = YES;
    _sealNumConstraints.constant = -28;
}
- (void)showSealNumLb {
    _addBtn.hidden = NO;
    _subBtn.hidden = NO;
    _numberTextField.hidden = NO;
    _sealNumConstraints.constant = 7;
}

- (void)hideBottomLine {
    self.bottomLine.alpha = 0;
}

- (void)showBottomLine {
    self.bottomLine.alpha = 1;
}

- (void)leadingBottomLine {
    [_bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.trailing.equalTo(self);
        make.height.equalTo(@10);
        make.width.equalTo(self.contentView.frame.size.width);
        make.leading.equalTo(self);
    }];
}

- (void)leadingEqualLogoBottomLine {
    [_bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.trailing.equalTo(self);
        make.height.equalTo(@10);
        make.width.equalTo(self.contentView.frame.size.width);
    }];
}

//加菜
- (IBAction)addBtnClicked:(id)sender
{
    BOOL addFlag = true;
    [_subBtn setImage:[UIImage imageNamed:@"reduce"] forState:UIControlStateNormal];
    if (_delegate && [_delegate respondsToSelector:@selector(amountAddNum:indexPath:isHidden:)]) {
        addFlag = [_delegate amountAddNum:[((NSString *) _priceLabel.text) stringByReplacingOccurrencesOfString:@"￥" withString:@""] indexPath:_disModel.indexPathRow isHidden:YES];
    }
    if (addFlag) {
        _disModel.number = [NSString stringWithFormat:@"%d",[_disModel.number intValue] +1];
        _numberTextField.text = _disModel.number;
    }
}

//减菜
- (IBAction)subtractBtnClicked:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if ([_disModel.number intValue] == 0) {
        return;
    }
    _disModel.number = [NSString stringWithFormat:@"%d",[_disModel.number intValue] -1];
    _numberTextField.text = _disModel.number;
    if (_delegate && [_delegate respondsToSelector:@selector(subNum:indexPath:isHidden:)]) {
        if ([_disModel.number intValue] == 0) {
            [button setImage:[UIImage imageNamed:@"reduce2"] forState:UIControlStateNormal];

            [_delegate subNum:[((NSString *) _priceLabel.text) stringByReplacingOccurrencesOfString:@"￥" withString:@""] indexPath:_disModel.indexPathRow isHidden:NO];
        } else {
            [button setImage:[UIImage imageNamed:@"reduce"] forState:UIControlStateNormal];

            [_delegate subNum:[((NSString *) _priceLabel.text) stringByReplacingOccurrencesOfString:@"￥" withString:@""] indexPath:_disModel.indexPathRow isHidden:YES];
        }
    }
}

- (void)drawRect:(CGRect)rect {
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:200/255.0 green:199/255.0 blue:204/255.0 alpha:1].CGColor);
//    CGContextSetLineWidth(context, 1);
//    CGContextMoveToPoint(context, 0, rect.size.height);
//    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
//    CGContextStrokePath(context);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
