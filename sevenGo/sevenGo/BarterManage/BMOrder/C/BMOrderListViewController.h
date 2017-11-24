//
//  BMOrderListViewController.h
//  sevenGo
//
//  Created by zhengkai on 2017/11/23.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "RootContainViewController.h"

typedef enum : NSUInteger {
    OrderState_ing = 1,   //新订单
    OrderState_finish = 3, //已结拍
    OrderState_flow = 4,   //已流拍
    OrderState_fail = 6,   //已失败
    OrderState_Up = 2,     //待上架
    OrderState_Down = 5,   //已下架
} OrderState;

@interface BMOrderListViewController : RootContainViewController

@end
