//
//  JSONModel.h
//  iOSAppFramework
//
//  Created by kongjun on 14-5-22.
//  Copyright (c) 2014年 Shenghuotong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMResultSet.h"
#import "NSDictionary+Addition.h"
@interface JSONModel : NSObject <NSCoding, NSCopying, NSMutableCopying> {
    
}

-(id) initWithDictionary:(NSMutableDictionary*) jsonObject;

@end
