//
//  UITableView+ExtendMJRefresh.h
//  SmartCommunity
//
//  Created by 陈洋 on 16/5/10.
//  Copyright © 2016年 shenghuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView(ExtendMJRefresh)
- (void)addHeaderWithTarget:(id) target action:(SEL)selector dateKey:(NSString *)dataKey;
- (void)addHeaderWithTarget:(id) target action:(SEL)selector;
- (void)addFooterWithTarget:(id) target action:(SEL)selector;
- (void)headerBeginRefreshing;
- (void)headerEndRefreshing;
- (void)footerBeginRefreshing;
- (void)footerEndRefreshing;

@end
