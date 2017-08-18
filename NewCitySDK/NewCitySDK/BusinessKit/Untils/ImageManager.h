//
//  ImageManager.h
//  iOSAppFramework
//
//  Created by kongjun on 14-5-22.
//  Copyright (c) 2014年 Shenghuotong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^CompleteImageBlock)(UIImage *image, NSError *error);
@interface ImageManager : NSObject
+ (ImageManager *)sharedManager;
//- (void)imageForPath:(NSString *)imagePath onCompletion:(CompleteImageBlock)completionBlock;
- (void)imageForURL:(NSString *)sourceURL onCompletion:(CompleteImageBlock)completionBlock;
- (void)imageForURL:(NSString *)sourceURL priority:(NSOperationQueuePriority)queuePriority onCompletion:(CompleteImageBlock)completionBlock;
- (void)cleanUpImageCache;
- (void)setImageLoadingMaxConcurrentCount:(NSUInteger)count;
- (void)cancelLoadImageForURL:(NSString *)sourceURL;

@end
