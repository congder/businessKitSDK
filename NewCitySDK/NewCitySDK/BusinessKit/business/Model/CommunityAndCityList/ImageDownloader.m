//
//  ImageDownloader.m
//  SmartCommunity
//
//  Created by mac on 15/6/30.
//  Copyright (c) 2015年 shenghuo. All rights reserved.
//

#import "ImageDownloader.h"

@implementation ImageDownloader

#pragma mark - 加载图片
- (void)startDownloadImage:(NSString *)imageUrl
{
    self.imageUrl = imageUrl;
    UIImage *image = [self loadLocalImage:imageUrl];
    if (image == nil) {
        // 沙盒中没有，下载
        // 异步下载,分配在程序进程缺省产生的并发队列
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            // 多线程中下载图像
            NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
            
            // 缓存图片
            [imageData writeToFile:[self imageFilePath:imageUrl] atomically:YES];
            
            // 回到主线程完成UI设置
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //将下载的图像，存入newsItem对象中
                UIImage * image = [UIImage imageWithData:imageData];
                self.newsItem.newsPic = image;
                //使用block实现回调，通知图像下载完成
                if (_completionHandler) {
                    _completionHandler();
                }
            });
        });
    }
}

- (UIImage *)loadLocalImage:(NSString *)imageUrl
{
    self.imageUrl = imageUrl;
    NSString *filePath = [self imageFilePath:imageUrl];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    if (image != nil) {
        return image;
    }
    return nil;
}

- (NSString *)imageFilePath:(NSString *)imageUrl
{
    // 获取caches文件夹路径
    NSString * cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    // 创建DownloadImages文件夹
    NSString * downloadImagesPath = [cachesPath stringByAppendingPathComponent:@"DownloadImages"];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:downloadImagesPath]) {
        [fileManager createDirectoryAtPath:downloadImagesPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    //拼接图像文件在沙盒中的路径,因为图像URL有"/",要在存入前替换掉,随意用"_"代替
    NSString * imageName = [imageUrl stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    NSString * imageFilePath = [downloadImagesPath stringByAppendingPathComponent:imageName];
    return imageFilePath;
}

@end
