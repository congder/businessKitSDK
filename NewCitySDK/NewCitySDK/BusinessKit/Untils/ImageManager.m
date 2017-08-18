//
//  ImageManager.m
//  iOSAppFramework
//
//  Created by kongjun on 14-5-22.
//  Copyright (c) 2014年 Shenghuotong. All rights reserved.
//

#import "ImageManager.h"
#import "UIApplication+NetworkActivityIndicator.h"
#import "LocalCache.h"

#define ImageManagerErrorCode 1111

@interface ImageManager ()
{
    NSMutableDictionary *_imagesToBeLoad;
    NSMutableDictionary *_imagesToBeSave;
    NSMutableDictionary *_queuedOperations;
}

@property (readonly, nonatomic) dispatch_queue_t imageCacheQueue;
@property (readonly, strong, nonatomic) NSOperationQueue *imageLoadQueue;
@property (strong, nonatomic) LocalCache *imageLocalCache;
@end

@implementation ImageManager

@synthesize imageCacheQueue = _imageCacheQueue;
@synthesize imageLoadQueue = _imageLoadQueue;

- (void)imageForURL:(NSString *)sourceURL priority:(NSOperationQueuePriority)queuePriority onCompletion:(CompleteImageBlock)completionBlock
{
    NSError *URlError = [self isImageURlValidated:sourceURL];
    UIImage *toBeSaveImage = nil;
    @synchronized(_imagesToBeSave) {
        toBeSaveImage = [_imagesToBeSave objectForKey:sourceURL];
    }
    UIImage *targetImage = URlError ? nil : toBeSaveImage;
    if (URlError || targetImage) {
        completionBlock(targetImage, URlError);
        return;
    }
    
    @synchronized(_imagesToBeLoad) {
        if ([_imagesToBeLoad objectForKey:sourceURL]) {
            NSMutableArray *completionBlocks = [_imagesToBeLoad objectForKey:sourceURL];
            [completionBlocks addObject:[completionBlock copy]];
            return;
        } else {
            [_imagesToBeLoad setObject:[NSMutableArray arrayWithObject:[completionBlock copy]] forKey:sourceURL];
        }
    }
    
    [self imageFromCacheWithSourceURL:sourceURL onCompletion:^(UIImage *targetImage) {
        if (targetImage) {
            [self imageLoadDidFinished:targetImage error:nil forURl:sourceURL needsToSave:NO];
        } else {
            // load from network
            NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
                NSError *networkErr = nil;
                UIImage *targetImage = [self loadImageFromURl:sourceURL error:&networkErr];
                @synchronized(_queuedOperations) {
                    [_queuedOperations removeObjectForKey:sourceURL];
                }
                [self imageLoadDidFinished:targetImage error:networkErr forURl:sourceURL needsToSave:YES];
            }];
            @synchronized(_queuedOperations) {
                [blockOperation setQueuePriority:queuePriority];
                [self.imageLoadQueue addOperation:blockOperation];
                [_queuedOperations setObject:blockOperation forKey:sourceURL];
            }
        }
    }];
}

- (void)imageForURL:(NSString *)sourceURL onCompletion:(CompleteImageBlock)completionBlock
{
    [self imageForURL:sourceURL priority:NSOperationQueuePriorityNormal onCompletion:completionBlock];
}

- (void)cleanUpImageCache
{
    //    MLog(@"Begin purge images");
    dispatch_queue_t imagePurgeQueue = dispatch_queue_create("Image Purge Queue", NULL);
    dispatch_async(imagePurgeQueue, ^{
        [self.imageLocalCache clearAllCacheData];
    });
}

- (void)cancelLoadImageForURL:(NSString *)sourceURL
{
    @synchronized(_queuedOperations) {
        NSBlockOperation *operation = [_queuedOperations objectForKey:sourceURL];
        if (operation && !operation.isExecuting) {
            [operation cancel];
            [_queuedOperations removeObjectForKey:sourceURL];
            [_imagesToBeLoad removeObjectForKey:sourceURL];
        }
    }
}

#pragma mark - Allocation & Init

+ (ImageManager *)sharedManager
{
    static ImageManager *_sharedManager = nil;
    if (!_sharedManager) {
        _sharedManager = [[ImageManager alloc] init];
    }
    return _sharedManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        _imagesToBeLoad = [[NSMutableDictionary alloc] init];
        _imagesToBeSave = [[NSMutableDictionary alloc] init];
        _queuedOperations = [[NSMutableDictionary alloc] init];
        _imageLocalCache = [[LocalCache alloc] initWithCacheFolderName:@"ImageCacheFolder"];
    }
    return self;
}

- (dispatch_queue_t)imageCacheQueue
{
    if (!_imageCacheQueue) {
        _imageCacheQueue = dispatch_queue_create("com.lyz.imageCache", NULL);
    }
    return _imageCacheQueue;
}

- (NSOperationQueue *)imageLoadQueue
{
    if (!_imageLoadQueue) {
        _imageLoadQueue = [[NSOperationQueue alloc] init];
        [_imageLoadQueue setMaxConcurrentOperationCount:20];
    }
    return _imageLoadQueue;
}

- (void)setImageLoadingMaxConcurrentCount:(NSUInteger)count
{
    if (count <= 0) {
        [[self imageLoadQueue] setMaxConcurrentOperationCount:20];
    } else {
        [[self imageLoadQueue] setMaxConcurrentOperationCount:count];
    }
    //    MLog(@"Image Loading Max Concurrent Count: %d", count);
}

#pragma mark - Internal methods

- (NSError *)isImageURlValidated:(NSString *)URlString
{
    NSError *err = nil;
    // check URlString = nil, ""
    if (!URlString || [URlString isEqualToString:@""]) {
        err = [NSError errorWithDomain:@"ImageManager"
                                  code:ImageManagerErrorCode
                              userInfo:@{@"errorMsg" : @"Image URl cannot be nil!"}];
    }
    return err;
}

- (UIImage *)loadImageFromURl:(NSString *)URlString error:(NSError **)error
{
    [[UIApplication sharedApplication] toggleNetworkActivityIndicatorVisible:YES];
    NSURL *imageURL = [NSURL URLWithString:URlString];
    NSURLResponse *imageRequestResponse = nil;
    NSMutableURLRequest *imageRequest = [NSMutableURLRequest requestWithURL:imageURL];
    NSData *imageBin = [NSURLConnection sendSynchronousRequest:imageRequest
                                             returningResponse:&imageRequestResponse
                                                         error:error];
    [[UIApplication sharedApplication] toggleNetworkActivityIndicatorVisible:NO];
    
    UIImage *targetImage = *error ? nil : [UIImage imageWithData:imageBin];
    
    return targetImage;
}

- (void)saveImage:(UIImage *)image forURl:(NSString *)URlString
{
    dispatch_async(self.imageCacheQueue, ^{
        @synchronized(_imagesToBeSave) {
            [_imagesToBeSave setObject:image forKey:URlString];
        }
        [self.imageLocalCache storeImage:image forKey:URlString block:^(LocalCache *cache, NSString *key) {
            
        }];
        @synchronized(_imagesToBeSave) {
            [_imagesToBeSave removeObjectForKey:URlString];
        }
    });
}

- (void)imageLoadDidFinished:(UIImage *)image error:(NSError *)error forURl:(NSString *)URlString needsToSave:(BOOL)needsToSave
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSArray *completionBlocks = nil;
        @synchronized(_imagesToBeLoad) {
            completionBlocks = [_imagesToBeLoad objectForKey:URlString];
            [_imagesToBeLoad removeObjectForKey:URlString];
        }
        if (needsToSave && image && !error) {
            [self saveImage:image forURl:URlString];
        }
        for (void(^oneCompeletionBlock)(UIImage *, NSError *) in completionBlocks) {
            oneCompeletionBlock(image, error);
        }
    });
}

- (void)imageFromCacheWithSourceURL:(NSString *)source onCompletion:(void (^)(UIImage *image))completionBlock
{
    dispatch_async(self.imageCacheQueue, ^{
        UIImage *image = [self.imageLocalCache cachedImageForKey:source];
        completionBlock(image);
    });
}

@end
