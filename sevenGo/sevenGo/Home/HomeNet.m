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

@end
