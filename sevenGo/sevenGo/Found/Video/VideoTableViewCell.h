//
//  VideoTableViewCell.h
//  sevenGo
//
//  Created by zhengkai on 17/9/11.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoViewMode.h"

@interface VideoTableViewCell : UITableViewCell

+ (CGFloat)getCellHeight;

@property (strong, nonatomic) VideoViewMode *viewModel;
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (nonatomic, strong) void(^selectBlock)(void);

@end
