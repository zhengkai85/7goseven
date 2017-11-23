//
//  VideoTitleTableViewCell.h
//  sevenGo
//
//  Created by zhengkai on 2017/9/28.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoDetailViewMode.h"

@interface VideoTitleTableViewCell : UITableViewCell

- (void)setViewMode:(VideoDetailViewMode*)viewModel
             height:(CGFloat)heigh;
@end
