//
//  HeadlineTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 17/9/18.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "HeadlineTableViewCell.h"
#import "MSWeakTimer.h"

@interface HeadlineTableViewCell ()
@property (nonatomic, strong) UILabel *lblTitle;
@property (strong, nonatomic) MSWeakTimer *timer;
@property (nonatomic, assign) CGFloat middle;
@property (nonatomic, strong) HomeViewMode *homeViewMode;
@property (nonatomic, assign) NSInteger index;
@end

@implementation HeadlineTableViewCell



- (void)setViewMode:(HomeViewMode*)viewModel
             height:(CGFloat)height {
    
    self.homeViewMode = viewModel;    
    self.middle = height/2;
    NSInteger tag = 100;
    UIImageView *img = (UIImageView*)[self.contentView viewWithTag:tag];
    if(!img) {
        img  = [[UIImageView alloc] initWithFrame:CGRectMake(8, 0, 50, 14)];
        img.tag = tag++;
        img.centerY = self.middle;
        img.image = [YYImage imageNamed:@"home_toutiao.png"];
        [self.contentView addSubview:img];
    }

    
    if(!self.lblTitle) {
        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(img.right+10,
                                                                  0,
                                                                  SCREEN_WIDTH - img.right - 20,
                                                                  13)];
        self.lblTitle.centerY = self.middle;
        self.lblTitle.textColor = COLOR_TEXT;
        self.lblTitle.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.lblTitle];
        
        if(self.homeViewMode.arrHeadline.count > 0) {
            HomeMode *mode = self.homeViewMode.arrHeadline[self.index++];
            self.lblTitle.text = mode.title;
        }
    }

    
    UIView *lblPlate = (UIView*)[self.contentView viewWithTag:tag];
    if(!lblPlate) {
        lblPlate = [[UIView alloc] initWithFrame:CGRectMake(self.lblTitle.left,
                                                            0,
                                                            self.lblTitle.width,
                                                            self.lblTitle.top)];
        lblPlate.tag ++;
        lblPlate.backgroundColor = self.contentView.backgroundColor;
        [self.contentView addSubview:lblPlate];
    }
    
    self.index = 0;
    
    [self beginGoTimer];
}



- (void)beginGoTimer {
    
    if (self.timer) {
        [self.timer  invalidate];
        self.timer  = nil;
    }
    
    self.timer = [MSWeakTimer scheduledTimerWithTimeInterval:4
                                                      target:self
                                                    selector:@selector(backgroundTimerDidFire)
                                                    userInfo:nil
                                                     repeats:YES
                                               dispatchQueue:dispatch_get_main_queue()];
}

- (void)backgroundTimerDidFire {
    
    if(self.index >= self.homeViewMode.arrHeadline.count) {
        self.index = 0;
    }
    
    [UIView animateWithDuration:0.2f animations:^{
        self.lblTitle.centerY = 0;
    } completion:^(BOOL finished) {
        self.lblTitle.centerY = self.middle;
        
        if(self.homeViewMode.arrHeadline.count > self.index+1) {
            HomeMode *mode = self.homeViewMode.arrHeadline[self.index++];
            self.lblTitle.text = mode.title;
        }
    }];
}
@end
