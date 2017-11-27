//
//  BMExtraViewController.h
//  sevenGo
//
//  Created by zhengkai on 2017/11/23.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "RootViewController.h"

@interface BMExtraViewController : RootViewController
- (void)fillData:(NSString*)str ;
+ (NSDictionary*)getAppendMeg:(NSArray*)arr;

@property (nonatomic, strong) NSArray   *arrDataSource;
@property (nonatomic, strong)void(^getMessage)(NSArray *arr);
@end
