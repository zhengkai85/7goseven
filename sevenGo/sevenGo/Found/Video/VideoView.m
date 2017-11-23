//
//  VideoView.m
//  THPlayer
//
//  Created by zhengkai on 2017/9/28.
//  Copyright © 2017年 inveno. All rights reserved.
//

#import "VideoView.h"


@interface VideoView ()
@end



@implementation VideoView

- (void)addObserver
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidFinished:)
                                                 name:kHTPlayerFinishedPlayNotificationKey object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullScreenBtnClick:)
                                                 name:kHTPlayerFullScreenBtnNotificationKey object:nil];
}

- (void)reloadData
{
    [self addObserver];
    
    self.backgroundColor = [UIColor whiteColor];
    
    if (_htPlayer) {
        [self toDetial];
    }else{
        [self startPlayVideo:nil];
    }
    
}

-(void)videoDidFinished:(NSNotification *)notice{
    
    if (_htPlayer.screenType == UIHTPlayerSizeFullScreenType){
        
        [self toCell];//先变回cell
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        _htPlayer.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_htPlayer removeFromSuperview];
        [self releaseWMPlayer];
    }];
    
}

-(void)fullScreenBtnClick:(NSNotification *)notice{
    
    UIButton *fullScreenBtn = (UIButton *)[notice object];
    if (fullScreenBtn.isSelected) {//全屏显示
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
    }else{
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [self toCell];
    }
}

-(void)toCell{
    
    [_htPlayer toDetailScreen:self];
}

-(void)toDetial{
    
    [_htPlayer toDetailScreen:self];
}

-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation{
    [_htPlayer toFullScreenWithInterfaceOrientation:interfaceOrientation];
}

//开始播放
-(void)startPlayVideo:(UIButton *)sender{
    
    if (_htPlayer) {
        [_htPlayer removeFromSuperview];
        [_htPlayer setVideoURLStr:_model.url_mobile];
        
    }else{
        _htPlayer = [[HTPlayer alloc]initWithFrame:self.bounds videoURLStr:_model.url_mobile];
    }
    
    _htPlayer.screenType = UIHTPlayerSizeDetailScreenType;
    
    [_htPlayer setPlayTitle:_model.title];
    
    [self addSubview:_htPlayer];
    [self bringSubviewToFront:_htPlayer];
    
    if (_htPlayer.screenType == UIHTPlayerSizeSmallScreenType) {
        [_htPlayer reductionWithInterfaceOrientation:self];
    }
}

-(void)releaseWMPlayer {
    
    [_htPlayer releaseWMPlayer];
    _htPlayer = nil;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
