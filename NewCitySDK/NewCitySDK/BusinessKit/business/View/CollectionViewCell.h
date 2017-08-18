//
//  CollectionViewCell.h
//  collectionView
//
//  Created by Echo on 2017/6/2.
//  Copyright © 2017年 Echo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;

@property (weak, nonatomic) IBOutlet UILabel *itemTitleLb;

@end
