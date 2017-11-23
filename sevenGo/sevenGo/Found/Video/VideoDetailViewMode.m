//
//  VideoDetailViewMode.m
//  sevenGo
//
//  Created by zhengkai on 2017/9/29.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "VideoDetailViewMode.h"
#import "VideoNet.h"

@interface VideoDetailViewMode()
@property (nonatomic, strong) VideoDetailViewMode *mode;
@property (nonatomic, strong) RACSignal *refreshDetailDataSignal;

@end

@implementation VideoDetailViewMode

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"videoID":@"id",
             @"cover_url":@"cover_url.thumb",
             @"playCount":@"view",
             @"creater_nickName":@"user.nickname",
             @"creater_avatar":@"user.avatar128"};
}

- (NSString*)viewCount {
    return [NSString stringWithFormat:@"%@次播放",self.playCount];
}

- (instancetype)initWithVideoID:(NSString*)videoID {
    if (self = [super init]) {
        self.refreshDetailDataSignal =  [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [VideoNet getVideoDetail:videoID
                               Block:^(id posts, NSInteger code, NSString *errorMsg) {
                                   NSDictionary *data = posts[@"data"];
                                   self.mode = [VideoDetailViewMode modelWithDictionary:data];
                                   code ? [subscriber sendCompleted] : [subscriber sendError:[NSError errorWithDomain:errorMsg code:code userInfo:nil]];
                               }];
            return nil;
        }];
    }
    return self;
}

- (VideoDetailViewMode*)detailMode {
    return self.mode;
}
@end
