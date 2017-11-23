//
//  VideoDetailViewController.h
//  sevenGo
//
//  Created by zhengkai on 2017/9/26.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "RootViewController.h"
#import "HTPlayer.h"
#import "VideoViewMode.h"

@interface VideoDetailViewController : RootViewController
- (void)setValueHtPlayer:(HTPlayer*)player
                    mode:(VideoViewMode*)mode;
@end
