//
//  VideoView.h
//  THPlayer
//
//  Created by zhengkai on 2017/9/28.
//  Copyright © 2017年 inveno. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTPlayer.h"
#import "VideoViewMode.h"

@interface VideoView : UIView
- (void)reloadData;
@property (strong, nonatomic)HTPlayer *htPlayer;
@property (strong, nonatomic)VideoViewMode *model;
@end
