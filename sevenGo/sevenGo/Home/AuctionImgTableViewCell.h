//
//  AuctionImgTableViewCell.h
//  sevenGo
//
//  Created by zhengkai on 2017/12/2.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "RootTableViewCell.h"
#import "AuctionViewMode.h"

@interface AuctionImgTableViewCell : RootTableViewCell

- (void)setViewMode:(AuctionViewMode*)viewModel
               type:(NSInteger)type;

@end
