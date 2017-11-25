//
//  BMOrderObj.h
//  sevenGo
//
//  Created by zhengkai on 2017/11/24.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMOrderObj : NSObject
@property (nonatomic, strong)NSString *goods_title;
@property (nonatomic, strong)NSString *price;
@property (nonatomic, assign)NSInteger status; //订单状态：1-新订单,2-已付款,3-已发货,4-已成交,5-已取消
@end
