//
//  BannerTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 17/9/18.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "BannerTableViewCell.h"
#import "SDCycleScrollView.h"
#import "HomeViewMode.h"
#import "ReactiveCocoa.h"
#import "Category.h"
@interface BannerTableViewCell ()
@property (nonatomic, strong) SDCycleScrollView *sdView;
@end

@implementation BannerTableViewCell


- (void)setViewMode:(HomeViewMode*)viewModel
             height:(CGFloat)height {
    
    @weakify(self);
    [RACObserve(viewModel, arrBanner) subscribeNext:^(id x) {
        @strongify(self);
        NSArray *arr = viewModel.arrBanner;
        
        if(!arr || [arr isEmpty]) {
            return ;
        }
        NSMutableArray *muArr = [[NSMutableArray alloc] initWithCapacity:arr.count];
        for(HomeMode *mode in arr){
            [muArr addObject:mode.pic];
        }
        
        if(!self.sdView) {
            self.sdView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)
                                                      imageNamesGroup:muArr];
            [self.contentView addSubview:self.sdView];
        } else {
            [self.sdView setImageURLStringsGroup:muArr];
        }
    }];
}



@end
