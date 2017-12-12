//
//  AuctionViewMode.m
//  sevenGo
//
//  Created by zhengkai on 2017/12/2.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "AuctionViewMode.h"
#import "AuctionMode.h"
#import "HomeNet.h"

@interface AuctionViewMode ()
@property (strong, nonatomic) RACSignal *refreshDataSignal;
@end

@implementation AuctionViewMode
- (instancetype)init {
    
    if(self = [super init]) {
        
        
        self.arrMode = [[NSMutableArray alloc] init];
        self.arrBatch = [[NSMutableArray alloc] init];
        self.arrMetting = [[NSMutableArray alloc] init];
        
            [HomeNet getBidListClass:1
                               block:^(id posts, NSInteger code, NSString *errorMsg) {
                                   if(code == 200) {
                                       NSArray *arrData = (NSArray*)posts[@"data"];
                                       [self fillToArray:self.arrMode frome:arrData];
                                       
                                   }
                               }];
            
            [HomeNet getBidListClass:2
                               block:^(id posts, NSInteger code, NSString *errorMsg) {
                                   if(code == 200) {
                                       NSArray *arrData = (NSArray*)posts[@"data"];
                                       [self fillToArray:self.arrBatch frome:arrData];

                                   }
                               }];
            
            [HomeNet getBidListClass:3
                               block:^(id posts, NSInteger code, NSString *errorMsg) {
                                   if(code == 200) {
                                       NSArray *arrData = (NSArray*)posts[@"data"];
                                       [self fillToArray:self.arrMetting frome:arrData];
                                   }
                               }];
            
            [HomeNet getBanner:@"banner" block:^(id posts, NSInteger code, NSString *errorMsg) {
                if(code == 200) {
                    NSDictionary *dicData = (NSDictionary*)posts[@"data"];
                    NSArray *arr = dicData[@"list"];
                    if(arr.count > 0) {
                        NSDictionary *dic = arr[0];
                        self.banner1Img = dic[@"pic"];
                    }
                }
            }];
            
            [HomeNet getBanner:@"banner2" block:^(id posts, NSInteger code, NSString *errorMsg) {
                if(code == 200) {
                    NSDictionary *dicData = (NSDictionary*)posts[@"data"];
                    NSArray *arr = dicData[@"list"];
                    if(arr.count > 0) {
                        NSDictionary *dic = arr[0];
                        self.banner2Img = dic[@"pic"];
                    }
                }
            }];
    }
    return self;
}

- (void)fillToArray:(NSMutableArray*)toArr
              frome:(NSArray*)fromeArr
{
    [toArr removeAllObjects];
    for(NSDictionary *dic in fromeArr) {
        AuctionMode *mode = [AuctionMode modelWithDictionary:dic];
        NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
        if([mode.end_time longLongValue] > interval) {
            [toArr addObject:mode];
        }
    }
}
@end
