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
@end
