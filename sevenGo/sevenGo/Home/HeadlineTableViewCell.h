//
//  HeadlineTableViewCell.h
//  sevenGo
//
//  Created by zhengkai on 17/9/18.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewMode.h"

@interface HeadlineTableViewCell : UITableViewCell

- (void)setViewMode:(HomeViewMode*)viewModel
             height:(CGFloat)height;
@end
