//
//  AuctionTableViewCell.h
//  sevenGo
//
//  Created by zhengkai on 2017/12/2.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "RootTableViewCell.h"
#import "AuctionViewMode.h"

@interface AuctionTableViewCell : RootTableViewCell
- (void)setViewMode:(AuctionViewMode*)viewModel
                row:(NSInteger)row
               type:(NSInteger)type;

@end
