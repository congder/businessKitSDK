//
//  ImageDownloader.h
//  SmartCommunity
//
//  Created by mac on 15/6/30.
//  Copyright (c) 2015年 shenghuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DistrictDetailsModel.h"

@interface ImageDownloader : NSObject

@property (nonatomic, copy) NSString * imageUrl;
@property (nonatomic, strong) DistrictDetailsModel * newsItem; //下载图像所属的新闻


//图像下载完成后，使用block实现回调
@property (nonatomic,copy) void (^completionHandler)(void);

//开始下载图像
- (void)startDownloadImage:(NSString *)imageUrl;

//从本地加载图像
- (UIImage *)loadLocalImage:(NSString *)imageUrl;
@end
