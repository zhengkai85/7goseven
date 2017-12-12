//
//  RecommendTableViewCell.h
//  sevenGo
//
//  Created by zhengkai on 2017/9/26.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuctionViewMode.h"

@interface RecommendTableViewCell : UITableViewCell

- (void)setViewMode:(AuctionViewMode*)viewModel
             height:(CGFloat)height
              index:(NSInteger)index;
@end
