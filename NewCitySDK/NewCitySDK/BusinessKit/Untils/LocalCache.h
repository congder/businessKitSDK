//
//  LocalCache.h
//  
//
//  Created by Woodrow Zhang on 6/30/13.
//  Copyright (c) 2012 lyz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class LocalCache;
typedef void (^LocalCacheObjectBlock)(LocalCache *cache, NSString *key);

@interface LocalCache : NSObject 
- (id)initWithCacheFolderName:(NSString *)cacheRootFolder;
+ (id)sharedCache;

- (id)cachedObjectForKey:(NSString *)key;
- (UIImage *)cachedImageForKey:(NSString*)key;
- (NSData*)cachedDataForKey:(NSString*)key;
- (NSString*)cachedStringForKey:(NSString*)key;
- (id)cachedJsonForKey:(NSString*)key;

- (BOOL)storeObject:(id<NSCoding>)object forKey:(NSString *)key block:(LocalCacheObjectBlock)block;
- (BOOL)storeImage:(UIImage *)imageData forKey:(NSString *)key block:(LocalCacheObjectBlock)block;
- (BOOL)storeData:(NSData*)cacheData forKey:(NSString *)key block:(LocalCacheObjectBlock)block;
- (BOOL)storeString:(NSString*)stringData forKey:(NSString *)key block:(LocalCacheObjectBlock)block;
- (BOOL)storeJson:(id)jsonData forKey:(NSString *)key block:(LocalCacheObjectBlock)block;

- (void)removeCacheDataForKey:(NSString *)key;
- (BOOL)isCacheDataExist:(NSString *)key;
- (BOOL)clearAllCacheData;
- (NSDate*)cacheModificationDateOfKey:(NSString*)key;

@end
