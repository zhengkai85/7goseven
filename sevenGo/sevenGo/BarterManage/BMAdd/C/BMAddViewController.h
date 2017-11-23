//
//  BMAddViewController.h
//  sevenGo
//
//  Created by zhengkai on 2017/11/21.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "RootViewController.h"

typedef enum : NSUInteger {
    BidType_mode = 1,   //样板
    BidType_batch = 2,  //批量
    BidType_meeting = 3,//拍卖会
} BidType;

@interface BMAddViewController : RootViewController
- (instancetype)initWithBid:(BidType)type;
@end
