//
//  CarouselScrollerView.h
//  SmartCommunity
//
//  Created by 陈洋 on 16/5/17.
//  Copyright © 2016年 shenghuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CarouselScrollerViewDelegate <UIScrollViewDelegate>

@end

@interface CarouselScrollerView : UIScrollView<UIScrollViewDelegate>
@property (strong, nonatomic) NSArray *views;
@property (strong, nonatomic) UIImage *defaultImage;
@property (assign, nonatomic) BOOL *passEvent;
@property (assign, nonatomic) float interval;
@property (assign, nonatomic) int pageIndex;
@property (weak, nonatomic) id<CarouselScrollerViewDelegate> carouselDelegate;

- (instancetype)init: (UIImage *)defaultImage;
- (void)shouldStartShow:(BOOL)shouldStart;
- (void)setImagesData:(NSArray *)images;
- (void)setImages:(NSArray *)images;
- (void)setViews:(NSArray *)views;
@end
