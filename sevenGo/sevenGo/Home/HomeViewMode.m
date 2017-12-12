//
//  HomeViewMode.m
//  sevenGo
//
//  Created by zhengkai on 17/9/18.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "HomeViewMode.h"
#import "HomeNet.h"

@interface HomeViewMode ()
@property (strong, nonatomic) RACSignal *refreshDataSignal;
@end

@implementation HomeViewMode

+ (instancetype)viewModel {
    return [[HomeViewMode alloc] init];
}

- (instancetype)init {
    
    if(self = [super init]) {
        
        self.dicHeard = @{HomeType_bid : [[HomeMode alloc] initWithTitle:@"今日易货" subtitle:@"一款仅一件，用7币置换" url:@"1"],
                          HomeType_designer : [[HomeMode alloc] initWithTitle:@"设计师工作室集群" subtitle:@"专业、艺术、潮流的原创设计师集群" url:@"2"],
                          HomeType_brand : [[HomeMode alloc] initWithTitle:@"品牌服饰集群" subtitle:@"给你一见钟情的品牌！" url:@"3"],
                          HomeType_scm : [[HomeMode alloc] initWithTitle:@"供应链集群" subtitle:@"提供最全面的供应需求产业链" url:@"4"],
                          HomeType_market : [[HomeMode alloc] initWithTitle:@"商城集群" subtitle:@"最有价值的黄金商城信息" url:@"5"],
                          HomeType_recommend : [[HomeMode alloc] initWithTitle:@"7购企业推荐" subtitle:@"只给您更好的，而不是最好的" url:@""],
                          HomeType_mode : [[HomeMode alloc] initWithTitle:@"样版易拍" subtitle:@"一款一件，拍完就没有了" url:@""],
                          HomeType_batch : [[HomeMode alloc] initWithTitle:@"批量找货" subtitle:@"在这里找你需要的" url:@""],
                          HomeType_metting : [[HomeMode alloc] initWithTitle:@"拍卖会" subtitle:@"感受一下现场拍卖的紧张" url:@""],

                          };
        
        [HomeNet getHomeList:^(id posts, NSInteger code, NSString *errorMsg) {
            if(code == 200) {
                NSDictionary *dicData = (NSDictionary*)posts[@"data"];
                self.arrBanner = [self fillModeWithData:dicData Key:HomeType_banner];
                self.arrHeadline = [self fillModeWithData:dicData Key:HomeType_headline];
                self.arrBid = [self fillModeWithData:dicData Key:HomeType_bid];
                self.arrDesigner = [self fillModeWithData:dicData Key:HomeType_designer];
                self.arrBrand = [self fillModeWithData:dicData Key:HomeType_brand];
                self.arrScm = [self fillModeWithData:dicData Key:HomeType_scm];
                self.arrMarket = [self fillModeWithData:dicData Key:HomeType_market];
                self.arrRecommend = [self fillModeWithData:dicData Key:HomeType_recommend];
            }
            
        }];
        
        
        
//        self.refreshDataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//            [HomeNet getHomeList:^(id posts, NSInteger code, NSString *errorMsg) {
//                if(code == 200) {
//                    NSDictionary *dicData = (NSDictionary*)posts[@"data"];
//                    self.arrBanner = [self fillModeWithData:dicData Key:HomeType_banner];
//                    self.arrHeadline = [self fillModeWithData:dicData Key:HomeType_headline];
//                    self.arrBid = [self fillModeWithData:dicData Key:HomeType_bid];
//                    self.arrDesigner = [self fillModeWithData:dicData Key:HomeType_designer];
//                    self.arrBrand = [self fillModeWithData:dicData Key:HomeType_brand];
//                    self.arrScm = [self fillModeWithData:dicData Key:HomeType_scm];
//                    self.arrMarket = [self fillModeWithData:dicData Key:HomeType_market];
//                    self.arrRecommend = [self fillModeWithData:dicData Key:HomeType_recommend];
//                }
//
//            }];
//            
//            return nil;
//        }];
    }
    return self;
}

- (NSArray*)fillModeWithData:(NSDictionary*)dicData
                     Key:(NSString*)key {
    NSArray *arr = dicData[key];
    NSMutableArray *muArr = [[NSMutableArray alloc] initWithCapacity:arr.count];
    for(NSDictionary *dic in dicData[key]) {
        HomeMode *mode = [HomeMode modelWithDictionary:dic];
        [muArr addObject:mode];
    }
    return muArr;
}


//+ (NSDictionary *)modelCustomPropertyMapper {
//    return @{@"videoID":@"id",
//             @"cover_url":@"cover_url.thumb",
//             @"playCount":@"view",
//             @"creater_nickName":@"user.nickname",
//             @"creater_avatar":@"user.avatar128"};
//}


@end

