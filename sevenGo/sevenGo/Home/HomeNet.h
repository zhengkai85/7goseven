//
//  HomeNet.h
//  sevenGo
//
//  Created by zhengkai on 17/9/18.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeNet : NSObject

+ (void)getHomeList:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;


//1-样版拍（默认）、2-批量拍、3-拍卖会
+ (void)getBidListClass:(NSInteger)selClass
                  block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;

//banner  banner2
+ (void)getBanner:(NSString*)name
            block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;


@end
