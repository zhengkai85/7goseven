//
//  VideoViewMode.h
//  sevenGo
//
//  Created by zhengkai on 17/9/11.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@interface VideoViewMode : NSObject

+ (instancetype)viewModel;

- (instancetype)initWithVideoTypeID:(NSString*)videoID;


- (NSArray<VideoViewMode *> *)listDatas;
- (NSString*)viewCount;
- (NSString*)commetCount;
- (RACSignal *)refreshDataSignal;
- (RACSignal *)loadMoreDataSignal;


- (instancetype)initWithRecommend;
- (NSArray<VideoViewMode *> *)recommendDatas;
- (RACSignal *)refreshRecommendSignal;


@property (nonatomic, strong) NSString *videoID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *playCount;
@property (nonatomic, strong) NSString *url_mobile;
@property (nonatomic, strong) NSString *cover_url;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *creater_nickName;
@property (nonatomic, strong) NSString *creater_avatar;
@property (nonatomic, strong) NSString *collection;
@property (nonatomic, strong) NSString *source;
@end
