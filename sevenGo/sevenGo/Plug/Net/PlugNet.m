//
//  CommentNet.m
//  sevenGo
//
//  Created by zhengkai on 2017/9/27.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "PlugNet.h"
#import "AFAppDotNetAPIClient.h"
#import "AppCacheData.h"

@implementation PlugNet

+ (void)getCommentListApp:(NSString*)app
                      mod:(NSString*)mod
                   row_id:(NSInteger)row_id
                     page:(NSInteger)page
                    block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    
    NSDictionary *dic = @{@"app" : app,
                          @"mod" : mod,
                          @"row_id" : [NSNumber numberWithInteger:row_id],
                          @"page" : [NSNumber numberWithInteger:page],
                          @"method" : Method_Get,
                          };
    
    
    [AFAppDotNetAPIClient dealWithNet:@"comment"
                                param:dic
                           isShowLoad:NO
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                                    block(posts,code,errorMsg);
                                }];
}

+ (void)sendCommentApp:(NSString*)app
                   mod:(NSString*)mod
                row_id:(NSInteger)row_id
                   pid:(NSUInteger)pid
               content:(NSString*)content
                 block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    
    NSDictionary *dic = @{@"app" : app,
                          @"mod" : mod,
                          @"row_id" : [NSNumber numberWithInteger:row_id],
                          @"pid" : [NSNumber numberWithInteger:pid],
                          @"content" : content,
                          @"method" : Method_Post,
                          };
    
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    [muDic setObject:[[AppCacheData shareCachData] getOpen_id] forKey:@"open_id"];
    
    [AFAppDotNetAPIClient dealWithNet:@"comment"
                                param:muDic
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                                    block(posts,code,errorMsg);
                                }];
}


+ (void)delComment:(NSInteger)command_id
               app:(NSString*)app
               mod:(NSString*)mod
            row_id:(NSInteger)row_id
             block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
 
    NSDictionary *dic = @{@"id"  : [NSNumber numberWithInteger:command_id],
                          @"app" : app,
                          @"mod" : mod,
                          @"row_id" : [NSNumber numberWithInteger:row_id],
                          @"method" : Method_Del,
                          };
    
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    [muDic setObject:[[AppCacheData shareCachData] getOpen_id] forKey:@"open_id"];
    
    [AFAppDotNetAPIClient dealWithNet:@"comment"
                                param:dic
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                                    block(posts,code,errorMsg);
                                }];
}

+ (void)getCollectListApp:(NSString*)app
                      mod:(NSString*)mod
                     page:(NSInteger)page
                    block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    
    NSDictionary *dic = @{@"app" : app,
                          @"mod" : mod,
                          @"page" : [NSNumber numberWithInteger:page],
                          @"method" : Method_Get,
                          };
    
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    [muDic setObject:[[AppCacheData shareCachData] getOpen_id] forKey:@"open_id"];
    
    [AFAppDotNetAPIClient dealWithNet:@"collect"
                                param:dic
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                                    block(posts,code,errorMsg);
                                }];
}


+ (void)changeCollectMegApp:(NSString*)app
                        mod:(NSString*)mod
                     row_id:(NSInteger)row_id
                      isAdd:(BOOL)add
                      block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    
    NSDictionary *dic = @{@"app" : app,
                          @"mod" : mod,
                          @"row_id" : [NSNumber numberWithInteger:row_id],
                          };
    
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    if(add) {
        [muDic setObject:Method_Post forKey:@"method"];
    } else {
        [muDic setObject:Method_Del forKey:@"method"];
    }
    [muDic setObject:[[AppCacheData shareCachData] getOpen_id] forKey:@"open_id"];
    
    [AFAppDotNetAPIClient dealWithNet:@"collect"
                                param:muDic
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                                    block(posts,code,errorMsg);
                                }];
}

+ (void)getSupportListApp:(NSString*)app
                      mod:(NSString*)mod
                   row_id:(NSInteger)row_id
                    block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    
    NSDictionary *dic = @{@"appname" : app,
                          @"table" : mod,
                          @"method" : Method_Get,
                          };
    
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    [muDic setObject:[[AppCacheData shareCachData] getOpen_id] forKey:@"open_id"];
    
    [AFAppDotNetAPIClient dealWithNet:@"my_support"
                                param:dic
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                                    block(posts,code,errorMsg);
                                }];
}

+ (void)changeSupportApp:(NSString*)app
                   table:(NSString*)table
                  row_id:(NSInteger)row_id
                   isAdd:(BOOL)add
                   block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    
    NSDictionary *dic = @{@"appname" : app,
                          @"table" : table,
                          @"row" : [NSNumber numberWithInteger:row_id],
                          };
    
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    if(add) {
        [muDic setObject:Method_Post forKey:@"method"];
    } else {
        [muDic setObject:Method_Del forKey:@"method"];
    }
    [muDic setObject:[[AppCacheData shareCachData] getOpen_id] forKey:@"open_id"];
    
    [AFAppDotNetAPIClient dealWithNet:@"support"
                                param:muDic
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                                    block(posts,code,errorMsg);
                                }];
    
    
}
@end
