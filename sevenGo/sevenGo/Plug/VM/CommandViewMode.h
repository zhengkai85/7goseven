//
//  CommandViewMode.h
//  sevenGo
//
//  Created by zhengkai on 2017/9/29.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@interface CommandViewMode : NSObject

- (instancetype)initWithVideoID:(NSString*)videoID;

- (RACSignal *)refreshDataSignal;
- (RACSignal *)loadMoreDataSignal;
- (NSString *)commandTime;
- (NSArray<CommandViewMode *> *)listDatas;


@property (nonatomic, strong) NSString *row_id;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *creater_nickName;
@property (nonatomic, strong) NSString *creater_avatar;
@end
