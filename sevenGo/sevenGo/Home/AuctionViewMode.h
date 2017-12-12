//
//  AuctionViewMode.h
//  sevenGo
//
//  Created by zhengkai on 2017/12/2.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@interface AuctionViewMode : NSObject

- (RACSignal *)refreshDataSignal;



@property (nonatomic, strong)NSMutableArray *arrMode;
@property (nonatomic, strong)NSMutableArray *arrBatch;
@property (nonatomic, strong)NSMutableArray *arrMetting;
@property (nonatomic, strong)NSString *banner1Img;
@property (nonatomic, strong)NSString *banner2Img;

@end
