//
//  HomeNet.m
//  sevenGo
//
//  Created by zhengkai on 17/9/18.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "HomeNet.h"
#import "AFAppDotNetAPIClient.h"

@implementation HomeNet

+ (void)getHomeList:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    
    NSDictionary *dic = @{@"method" : Method_Get};
    [AFAppDotNetAPIClient dealWithNet:@"dataset_index"
                                param:dic
                           isShowLoad:NO
                           cacheBlock:^(id cache) {
                               block(cache,200,nil);
                           } block:^(id posts, NSInteger code, NSString *errorMsg) {
                               block(posts,code,errorMsg);
                           }];
}

+ (void)getBidListClass:(NSInteger)selClass
                  block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    NSDictionary *dic = @{@"method" : Method_Get,
                          @"class" : [NSNumber numberWithInteger:selClass],
                          };
    [AFAppDotNetAPIClient dealWithNet:@"bid_list"
                                param:dic
                           isShowLoad:NO
                           cacheBlock:^(id cache) {
                               block(cache,200,nil);
                           } block:^(id posts, NSInteger code, NSString *errorMsg) {
                               block(posts,code,errorMsg);
                           }];
}


+ (void)getBanner:(NSString*)name
            block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    NSDictionary *dic = @{@"method" : Method_Get,
                          @"need_html" : [NSNumber numberWithInteger:0],
                          @"path" : @"Bid/Index/index",
                          @"name" : name,
                          };
    
    [AFAppDotNetAPIClient dealWithNet:@"adv"
                                param:dic
                           isShowLoad:NO
                           cacheBlock:^(id cache) {
                               block(cache,200,nil);
                           } block:^(id posts, NSInteger code, NSString *errorMsg) {
                               block(posts,code,errorMsg);
                           }];
    
}
@end
