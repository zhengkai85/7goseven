//
//  VideoTypeViewMode.h
//  sevenGo
//
//  Created by zhengkai on 17/9/11.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@interface VideoTypeViewMode : NSObject

+ (instancetype)viewModel;


- (NSArray<VideoTypeViewMode *> *)allDatas;
- (RACSignal *)refreshDataSignal;


@property (nonatomic, strong) NSString *videoTypeId;
@property (nonatomic, strong) NSString *title;

@end
