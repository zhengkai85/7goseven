//
//  BMProductObj.h
//  sevenGo
//
//  Created by zhengkai on 2017/11/21.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMProductObj : NSObject
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *now_price;
@property (nonatomic, strong)NSString *state;
@property (nonatomic, strong)NSString *start_time;
@property (nonatomic, strong)NSString *end_time;
@property (nonatomic, strong)NSArray *image_list;
@end
