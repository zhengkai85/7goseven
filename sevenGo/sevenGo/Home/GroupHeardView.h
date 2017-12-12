//
//  GroupHeardView.h
//  sevenGo
//
//  Created by zhengkai on 2017/9/26.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeMode.h"

@interface GroupHeardView : UIView

- (void)setViewMode:(HomeMode*)mode
             height:(CGFloat)heigh;

@property (nonatomic, strong)void(^gotoDetailBlock)(void);
@end
