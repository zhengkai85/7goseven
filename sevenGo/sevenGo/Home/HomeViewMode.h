//
//  HomeViewMode.h
//  sevenGo
//
//  Created by zhengkai on 17/9/18.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeMode.h"
#import "ReactiveCocoa.h"

#define HomeType_banner      @"banner_list"
#define HomeType_headline    @"headline_list"
#define HomeType_bid         @"bid_list"
#define HomeType_designer    @"designer_list"
#define HomeType_brand       @"brand_list"
#define HomeType_scm         @"scm_list"
#define HomeType_market      @"market_list"
#define HomeType_event       @"event_list"
#define HomeType_recommend   @"recommend_list"

@interface HomeViewMode : NSObject

+ (instancetype)viewModel;

- (RACSignal *)refreshDataSignal;


@property (nonatomic, strong) NSArray *arrBanner;
@property (nonatomic, strong) NSArray *arrHeadline;
@property (nonatomic, strong) NSArray *arrBid;
@property (nonatomic, strong) NSArray *arrDesigner;
@property (nonatomic, strong) NSArray *arrBrand;
@property (nonatomic, strong) NSArray *arrScm;
@property (nonatomic, strong) NSArray *arrMarket;
@property (nonatomic, strong) NSArray *arrEvent;
@property (nonatomic, strong) NSArray *arrRecommend;
@property (nonatomic, strong) NSDictionary *dicHeard;

@end


