//
//  CommandViewMode.m
//  sevenGo
//
//  Created by zhengkai on 2017/9/29.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "CommandViewMode.h"
#import "PlugNet.h"

@interface CommandViewMode ()
@property (nonatomic, strong) CommandViewMode *mode;
@property (nonatomic, strong) RACSignal *refreshDataSignal;
@property (nonatomic, strong) RACSignal *loadMoreDataSignal;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *datas;

@end
@implementation CommandViewMode

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"creater_nickName":@"user.nickname",
             @"creater_avatar":@"user.avatar128"};
}

- (NSString *)commandTime {
    return [NSString stringWithFormat:@"%@评论",self.create_time];
}

- (instancetype)initWithVideoID:(NSString*)videoID {
    if (self = [super init]) {
        self.datas = [[NSMutableArray alloc] init];
        self.refreshDataSignal =  [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            self.page = 1;
            [PlugNet getCommentListApp:@"Video"
                                   mod:@"video"
                                row_id:[videoID integerValue]
                                  page:self.page
                                 block:^(id posts, NSInteger code, NSString *errorMsg) {
                                     NSArray *arr = posts[@"data"][@"list"];
                                     if(![arr isKindOfClass:[NSArray class]]) {
                                         code = 0;
                                     } else {
                                         if(arr.count == 0) {
                                             code = 0;
                                         }
                                         [self.datas removeAllObjects];
                                         for(NSDictionary *dic in arr) {
                                             CommandViewMode *mode = [CommandViewMode modelWithDictionary:dic];
                                             [self.datas addObject:mode];
                                         }
                                     }
                        

                                     code ? [subscriber sendCompleted] : [subscriber sendError:[NSError errorWithDomain:errorMsg code:code userInfo:nil]];
                                 }];
            return nil;
        }];
        
        self.loadMoreDataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            self.page++;
            [PlugNet getCommentListApp:@"Video"
                                   mod:@"video"
                                row_id:[videoID integerValue]
                                  page:self.page
                                 block:^(id posts, NSInteger code, NSString *errorMsg) {
                                     NSArray *arr = posts[@"data"];
                                     if(arr.count == 0) {
                                         code = 0;
                                     }
                                     for(NSDictionary *dic in arr) {
                                         CommandViewMode *mode = [CommandViewMode modelWithDictionary:dic];
                                         [self.datas addObject:mode];
                                     }
                                     code ? [subscriber sendCompleted] : [subscriber sendError:[NSError errorWithDomain:errorMsg code:code userInfo:nil]];
                                 }];
            return nil;
        }];
    }
    return self;
}

- (NSArray<CommandViewMode *> *)listDatas {
    return self.datas;
}
@end
