//
//  VideoDetailViewMode.h
//  sevenGo
//
//  Created by zhengkai on 2017/9/29.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@interface VideoDetailViewMode : NSObject

- (instancetype)initWithVideoID:(NSString*)videoID;
- (RACSignal *)refreshDetailDataSignal;
- (NSString*)viewCount;

- (VideoDetailViewMode*)detailMode;

@property (nonatomic, strong) NSString *videoID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *playCount;
@property (nonatomic, strong) NSString *url_mobile;
@property (nonatomic, strong) NSString *cover_url;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *support;
@property (nonatomic, strong) NSString *creater_nickName;
@property (nonatomic, strong) NSString *creater_avatar;
@property (nonatomic, strong) NSString *collection;

@property (nonatomic, assign) BOOL is_collect;
@property (nonatomic, assign) BOOL is_support;
@end
