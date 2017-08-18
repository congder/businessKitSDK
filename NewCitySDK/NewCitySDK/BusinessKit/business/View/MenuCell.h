//
//  MenuCell.h
//  SmartCommunity
//
//  Created by apple on 15/5/19.
//  Copyright (c) 2015年 shenghuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DistrictDetailsModel.h"

@protocol MenuCellDelegate <NSObject>

- (BOOL)amountAddNum:(NSString *)number indexPath:(NSString *)indexPath isHidden:(BOOL)isHidden;
- (void)subNum:(NSString *)number indexPath:(NSString *)indexPath isHidden:(BOOL)isHidden;
@end

@interface MenuCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextField *numberTextField;
@property (strong, nonatomic) IBOutlet UILabel *dishesLabel;
@property (strong, nonatomic) IBOutlet UILabel *listLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UIImageView *logoImageView;
@property (strong, nonatomic) IBOutlet UIButton *subBtn;
@property (strong, nonatomic) IBOutlet UIButton *addBtn;
//销量的
@property (weak, nonatomic) IBOutlet UIImageView *discountIcon;
@property (strong, nonatomic) IBOutlet UILabel *sealNumLb;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sealNumConstraints;

@property (assign, nonatomic) int number;
@property (strong, nonatomic) NSString *indexRow;
@property (assign, nonatomic) id <MenuCellDelegate> delegate;
@property (strong, nonatomic) DistrictDetailsModel *disModel;

@property (strong, nonatomic) NSString *dataString;

- (void)hideSealNumLb;
- (void)showSealNumLb;
- (void)hideBottomLine;
- (void)showBottomLine;
- (void)leadingBottomLine;
- (void)leadingEqualLogoBottomLine;
@end
