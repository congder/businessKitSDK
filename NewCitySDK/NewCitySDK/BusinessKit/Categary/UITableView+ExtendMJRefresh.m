//
//  UITableView+ExtendMJRefresh.m
//  SmartCommunity
//
//  Created by 陈洋 on 16/5/10.
//  Copyright © 2016年 shenghuo. All rights reserved.
//
#import "MJRefresh.h"
#import "UITableView+ExtendMJRefresh.h"

@implementation UITableView(ExtendMJRefresh)
- (void)addHeaderWithTarget:(id) target action:(SEL)selector dateKey:(NSString *)dataKey {
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:selector];
    self.mj_header.lastUpdatedTimeKey = dataKey;
    MJRefreshNormalHeader *header = (MJRefreshNormalHeader *)self.mj_header;
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
}
- (void)addHeaderWithTarget:(id) target action:(SEL)selector {
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:selector];
}
- (void)addFooterWithTarget:(id) target action:(SEL)selector {
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:selector];
//    MJRefreshBackNormalFooter
//    MJRefreshAutoNormalFooter
//    ((MJRefreshBackNormalFooter *)(self.mj_footer)).triggerAutomaticallyRefreshPercent = 0;
}
- (void)headerBeginRefreshing {
    if (self.mj_header) {
        if ([self.mj_header isKindOfClass:MJRefreshNormalHeader.class]) {
            MJRefreshNormalHeader *header = (MJRefreshNormalHeader *)self.mj_header;
            
            if(!self.mj_header.lastUpdatedTime) {
                header.lastUpdatedTimeLabel.hidden = YES;
            } else {
                header.lastUpdatedTimeLabel.hidden = NO;
            }
        }
        [self.mj_header beginRefreshing];
    }
}
- (void)headerEndRefreshing {
    if (self.mj_header) {
        [self.mj_header endRefreshing];
    }
}
- (void)footerBeginRefreshing {
    if (self.mj_footer) {
        [self.mj_footer beginRefreshing];
    }
}
- (void)footerEndRefreshing {
    if (self.mj_footer && self.mj_footer.isRefreshing) {
        [self.mj_footer endRefreshing];
    }
}


@end
