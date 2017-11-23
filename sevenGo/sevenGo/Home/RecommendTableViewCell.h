//
//  RecommendTableViewCell.h
//  sevenGo
//
//  Created by zhengkai on 2017/9/26.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewMode.h"

@interface RecommendTableViewCell : UITableViewCell

- (void)setViewMode:(HomeViewMode*)viewModel
             height:(CGFloat)height
              index:(NSInteger)index;
@end
