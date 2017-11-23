//
//  MyNet.h
//  sevenGo
//
//  Created by zhengkai on 2017/10/18.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyNet : NSObject

/**
 获取用户基本信息（实时）
 */
+ (void)userDataBlock:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;


@end
