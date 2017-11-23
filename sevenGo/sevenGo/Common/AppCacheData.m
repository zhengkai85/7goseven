//
//  AppDiskData.m
//  huimin
//
//  Created by zhengkai on 16/4/8.
//  Copyright © 2016年 zhengkai. All rights reserved.
//

#import "AppCacheData.h"

static AppCacheData *data;

@interface AppCacheData ()
@property (atomic, strong) NSString *cacheOpen_id;
@property (atomic, strong) NSString *cacheU_id;
@property (nonatomic, strong) YYCache *yyCache;
@end

static NSString * userMessage           = @"UserMessage";

@implementation AppCacheData
+ (AppCacheData*)shareCachData {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        data = [[AppCacheData alloc] init];
        [data getAllUserMessage];
    });
    return data;
}

- (void)clearData {
    self.cacheOpen_id = @"";
    self.cacheU_id = @"";
    self.userMode = nil;
    [self.yyCache removeAllObjects];
}


static NSString * strOpenId           = @"open_id";
- (NSString*)getOpen_id {
    if([self.cacheOpen_id isNoEmpty]) {
        return self.cacheOpen_id;
    }
    YYCache *yyCache = [YYCache cacheWithName:userMessage];
    self.cacheOpen_id = (NSString*)[yyCache objectForKey:strOpenId];
    return self.cacheOpen_id;
}

- (void)setOpen_id:(NSString *)str {
    self.cacheOpen_id = str;
    YYCache *yyCache = [YYCache cacheWithName:userMessage];;
    [yyCache setObject:str forKey:strOpenId];
    
}

static NSString * strU_Id           = @"u_id";

- (NSString*)getU_id {
    if([self.cacheU_id isNoEmpty]) {
        return self.cacheU_id;
    }
    YYCache *yyCache = [YYCache cacheWithName:userMessage];
    self.cacheU_id = (NSString*)[yyCache objectForKey:strU_Id];
    return self.cacheU_id;
}

- (void)setU_id:(NSString*)str {
    self.cacheU_id = str;
    YYCache *yyCache = [YYCache cacheWithName:userMessage];;
    [yyCache setObject:str forKey:strU_Id];
}


static NSString * strAllUserMessage           = @"allUserMessage";

- (UserViewMode*)getAllUserMessage {
    if(self.userMode) {
        return self.userMode;
    }
    YYCache *yyCache = [YYCache cacheWithName:userMessage];
    NSString *str = (NSString*)[yyCache objectForKey:strAllUserMessage];
    self.userMode = [UserViewMode modelWithDictionary:[str jsonValueDecoded]];
    return self.userMode;
}

- (void)setAllUserMessage:(UserViewMode*)mode {
    self.userMode = mode;
    YYCache *yyCache = [YYCache cacheWithName:userMessage];;
    [yyCache setObject:[mode modelToJSONString] forKey:strAllUserMessage];
}



@end
