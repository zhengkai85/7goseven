//
//  AuctionImgTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 2017/12/2.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "AuctionImgTableViewCell.h"

@interface AuctionImgTableViewCell()
@property (nonatomic,strong)IBOutlet UIImageView *imgBanner;
@end

@implementation AuctionImgTableViewCell

- (void)setViewMode:(AuctionViewMode*)viewModel
               type:(NSInteger)type
{
    
    @weakify(self);
    if(type == 0) {
        [RACObserve(viewModel, banner1Img) subscribeNext:^(id x) {
            @strongify(self);
            [self.imgBanner setImageURL:[NSURL URLWithString:viewModel.banner1Img]];
        }];
    } else if(type == 1) {
        [RACObserve(viewModel, banner1Img) subscribeNext:^(id x) {
            @strongify(self);
            [self.imgBanner setImageURL:[NSURL URLWithString:viewModel.banner2Img]];
        }];
    }

}

@end
