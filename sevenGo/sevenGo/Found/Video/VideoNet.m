//
//  VideoNet.m
//  sevenGo
//
//  Created by zhengkai on 17/9/11.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "VideoNet.h"
#import "AFAppDotNetAPIClient.h"

@implementation VideoNet
+ (void)getVideoTypeBlock:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {

    NSDictionary *dic = @{@"method" : Method_Get};
    [AFAppDotNetAPIClient dealWithNet:@"video_category"
                                param:dic
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                                    block(posts,code,errorMsg);
                                }];    

}

+ (void)getVideoList:(NSString*)videoTypeId
                page:(NSInteger)page
               Block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    
    NSDictionary *dic = @{@"id" : videoTypeId,
                          @"page" : [NSNumber numberWithInteger:page],
                          @"method" : Method_Get,
                          };
    [AFAppDotNetAPIClient dealWithNet:[NSString stringWithFormat:@"video/%@",videoTypeId]
                                param:dic
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                                    block(posts,code,errorMsg);
                                }];
}

+ (void)getVideoDetail:(NSString*)videoId
                 Block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    
    NSDictionary *dic = @{@"id" : videoId,
                          @"method" : Method_Get,
                          };
    [AFAppDotNetAPIClient dealWithNet:[NSString stringWithFormat:@"video_detail/%@",videoId]
                                param:dic
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                                    block(posts,code,errorMsg);
                                }];
}

+ (void)getVideoRecommendBlock:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    NSDictionary *dic = @{@"position" : @"4",
                          @"method" : Method_Get,
                          };
    [AFAppDotNetAPIClient dealWithNet:@"video_recommend"
                                param:dic
                           isShowLoad:NO
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                                    block(posts,code,errorMsg);
                                }];
}
@end
