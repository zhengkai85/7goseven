//
//  UserViewMode.m
//  sevenGo
//
//  Created by zhengkai on 2017/10/19.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "UserViewMode.h"
#import "MyNet.h"

@interface UserViewMode ()


@end

@implementation UserViewMode


//+ (NSDictionary *)modelCustomPropertyMapper {
//    return @{@"videoID":@"id",
//             @"cover_url":@"cover_url.thumb",
//             @"playCount":@"view",
//             @"creater_nickName":@"user.nickname",
//             @"creater_avatar":@"user.avatar128"};
//}


- (instancetype)initWitDic:(NSDictionary*)dic {
    
    if (self = [super init]) {
//        self.refreshDataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//
//            [subscriber sendCompleted];
//            return nil;
//        }];
    }
    return self;
}

- (instancetype)init {
    
    if (self = [super init]) {
//        self.refreshDataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//            [MyNet userDataBlock:^(id posts, NSInteger code, NSString *errorMsg) {
//                if(code == 200) {
//                    NSDictionary *dicData = (NSDictionary*)posts[@"data"];
//
//                }
//                
//                (code == 200) ? [subscriber sendCompleted] : [subscriber sendError:[NSError errorWithDomain:errorMsg code:code userInfo:nil]];
//            }];
//
//            return nil;
//        }];
    }
    return self;
}
@end
