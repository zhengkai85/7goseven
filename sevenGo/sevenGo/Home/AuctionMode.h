//
//  AuctionMode.h
//  sevenGo
//
//  Created by zhengkai on 2017/12/2.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuctionMode : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *start_time;
@property (nonatomic,strong) NSString *end_time;
@property (nonatomic,strong) NSArray *image_list;
@property (nonatomic,strong) NSString *bid_times;
@end
