//
//  VideoViewMode.m
//  sevenGo
//
//  Created by zhengkai on 17/9/11.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "VideoViewMode.h"
#import "VideoNet.h"

//@class cover_url;

@interface VideoViewMode ()
@property (nonatomic, strong) RACSignal *refreshDataSignal;
@property (nonatomic, strong) RACSignal *loadMoreDataSignal;
@property (nonatomic, strong) RACSignal *refreshRecommendSignal;

@property (nonatomic, strong) NSMutableArray<VideoViewMode *> *videos;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) VideoViewMode *mode;
@end

@implementation VideoViewMode


+ (instancetype)viewModel {
    return [[VideoViewMode alloc] init];
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"videoID":@"id",
             @"cover_url":@"cover_url.thumb",
             @"playCount":@"view",
             @"creater_nickName":@"user.nickname",
             @"creater_avatar":@"user.avatar128"};
}


- (instancetype)initWithVideoTypeID:(NSString*)videoID {
    
    if (self = [super init]) {
        self.page = 1;
        self.videos = [[NSMutableArray alloc] init];
        self.refreshDataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            self.page = 1;
            [VideoNet getVideoList:videoID
                              page:self.page
                             Block:^(id posts, NSInteger code, NSString *errorMsg) {
                                 NSArray *arr = posts[@"data"];
                                 if(arr.count == 0) {
                                     code = 0;
                                 }
                                 [self.videos removeAllObjects];
                                 for(NSDictionary *dic in arr) {
                                     VideoViewMode *mode = [VideoViewMode modelWithDictionary:dic];
                                     [self.videos addObject:mode];
                                 }
                                 code ? [subscriber sendCompleted] : [subscriber sendError:[NSError errorWithDomain:errorMsg code:code userInfo:nil]];
                             }];
            return nil;
        }];
        
        
        self.loadMoreDataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            self.page ++;
            [VideoNet getVideoList:videoID
                              page:self.page
                             Block:^(id posts, NSInteger code, NSString *errorMsg) {
                                 NSArray *arr = posts[@"data"];
                                 if(arr.count == 0) {
                                     code = 0;
                                 }
                                 for(NSDictionary *dic in arr) {
                                     VideoViewMode *mode = [VideoViewMode modelWithDictionary:dic];
                                     [self.videos addObject:mode];
                                 }
                                 code ? [subscriber sendCompleted] : [subscriber sendError:[NSError errorWithDomain:errorMsg code:code userInfo:nil]];
                             }];
            return nil;
        }];
    
    }
    return self;
}

- (instancetype)initWithRecommend {
    if (self = [super init]) {
        self.refreshRecommendSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [VideoNet getVideoRecommendBlock:^(id posts, NSInteger code, NSString *errorMsg) {
                NSArray *arr = posts[@"data"];
                if(arr.count == 0) {
                    code = 0;
                }
                for(NSDictionary *dic in arr) {
                    VideoViewMode *mode = [VideoViewMode modelWithDictionary:dic];
                    [self.videos addObject:mode];
                }
                code ? [subscriber sendCompleted] : [subscriber sendError:[NSError errorWithDomain:errorMsg code:code userInfo:nil]];
            }];
            return nil;
        }];
    }
    return self;
}

- (NSString*)viewCount {
    return [NSString stringWithFormat:@"%@次播放",self.playCount];
}

- (NSString*)commetCount {
    return [NSString stringWithFormat:@"%@次评论",self.comment];
}

- (NSArray *)listDatas {
    return self.videos;
}

- (NSArray *)recommendDatas {
    return self.videos;
}

@end
