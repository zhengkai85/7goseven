//
//  AppDiskData.h
//  huimin
//
//  Created by zhengkai on 16/4/8.
//  Copyright © 2016年 zhengkai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserViewMode.h"

#define CacheData ([AppCacheData shareCachData])
@interface AppCacheData : NSObject

+ (AppCacheData*)shareCachData;

- (void)clearData;

- (void)setOpen_id:(NSString*)str;
- (NSString*)getOpen_id;

- (void)setU_id:(NSString*)str;
- (NSString*)getU_id;

- (void)setAllUserMessage:(UserViewMode*)mode;
- (UserViewMode*)getAllUserMessage;

//finish:(void (^)())block {

@property (atomic, strong) UserViewMode *userMode;

@end
