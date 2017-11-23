//
//  VideoTypeViewMode.m
//  sevenGo
//
//  Created by zhengkai on 17/9/11.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "VideoTypeViewMode.h"
#import "VideoNet.h"


@interface VideoTypeViewMode ()
@property (strong, nonatomic) RACSignal *refreshDataSignal;
@property (nonatomic, strong) NSArray<VideoTypeViewMode *> *types;
@end

@implementation VideoTypeViewMode

+ (instancetype)viewModel {
    return [[VideoTypeViewMode alloc] init];
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"videoTypeId":@"id"};
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.refreshDataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [VideoNet getVideoTypeBlock:^(id posts, NSInteger code, NSString *errorMsg) {
                NSArray *arr = posts[@"data"];
                NSMutableArray *muArr = [[NSMutableArray alloc] initWithCapacity:arr.count];
                for(NSDictionary *dic in arr) {
                    VideoTypeViewMode *mode = [VideoTypeViewMode modelWithDictionary:dic];
                    [muArr addObject:mode];
                }
                self.types = [[NSArray alloc] initWithArray:muArr];
                code ? [subscriber sendCompleted] : [subscriber sendError:[NSError errorWithDomain:errorMsg code:code userInfo:nil]];
            }];
            return nil;
        }];

        
    }
    return self;
}

- (NSArray *)allDatas {
    return self.types;
}


@end
