//
//  VideoNet.h
//  sevenGo
//
//  Created by zhengkai on 17/9/11.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoNet : NSObject

+ (void)getVideoTypeBlock:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;

+ (void)getVideoList:(NSString*)videoTypeId
                page:(NSInteger)page
               Block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;

+ (void)getVideoDetail:(NSString*)videoId
                 Block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;

+ (void)getVideoRecommendBlock:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;

@end
