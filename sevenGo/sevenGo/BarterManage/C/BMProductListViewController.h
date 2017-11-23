//
//  BMProductListViewController.h
//  sevenGo
//
//  Created by zhengkai on 2017/11/20.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "RootTableViewController.h"

typedef enum : NSUInteger {
    ProductState_ing = 1,   //竞拍中
    ProductState_finish = 3, //已结拍
    ProductState_flow = 4,   //已流拍
    ProductState_fail = 6,   //已失败
    ProductState_Up = 2,     //待上架
    ProductState_Down = 5,   //已下架
} ProductState;

@interface BMProductListViewController : RootTableViewController
- (instancetype)initWithState:(ProductState)state;
@end
