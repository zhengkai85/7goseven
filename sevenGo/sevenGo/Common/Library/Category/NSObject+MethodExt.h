//
//  NSObject+MethodExt.h
//  ND91U
//
//  Created by 颜志炜 on 14-1-14.
//  Copyright (c) 2014年 nd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^performBlock)(void);

@interface NSObject (MethodExt)

/**
 *    延时使用一个block来执行
 *
 *    @param block 需要被执行的block
 *    @param delay 延时时间
 */
- (void)performBlock:(performBlock)block
          afterDelay:(NSTimeInterval)delay;

/**
 *    拉长动画时间使用一个block来执行
 *
 *    @param duration 需要被执行的block
 */
- (void)performBlock:(performBlock)block
            duration:(NSTimeInterval)duration;


/**
 *    确保该对象实例一定是NSDictionary对象
 *
 *    @param needAssert 非NSDictionary对象的时候是否触发断言
 *
 *    @return 返回YES如果对象是NSDictionary类型，否则返回NO
 */
- (BOOL)makesureDictionary:(BOOL)needAssert;


/**
 *    对象不为空
 */
- (BOOL)isNoEmpty;

/**
 *    对象为空
 */
- (BOOL)isEmpty;

@end
