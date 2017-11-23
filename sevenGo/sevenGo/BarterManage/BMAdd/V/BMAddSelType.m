//
//  BMAddSelType.m
//  sevenGo
//
//  Created by zhengkai on 2017/11/21.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "BMAddSelType.h"
#import "BMAddViewController.h"

@implementation BMAddSelType


- (instancetype)initWithFrame:(CGRect)frame {
    if(self == [super initWithFrame:frame]) {
        [self createUI];
    }
    
    return self;
}

- (void)createUI {


    UIView *viewBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    viewBg.backgroundColor = [UIColor whiteColor];
    viewBg.alpha = 0.9;
    [self addSubview:viewBg];


    UIButton *btnMenu1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 120)];
    btnMenu1.centerX = SCREEN_WIDTH/4;
    btnMenu1.centerY = SCREEN_HEIGHT/2 + 30;
    [self addSubview:btnMenu1];



    UIButton *btnMenu2 = [[UIButton alloc] initWithFrame:btnMenu1.bounds];
    btnMenu2.centerX = SCREEN_WIDTH/2;
    btnMenu2.centerY = btnMenu1.centerY;
    [self addSubview:btnMenu2];



    UIButton *btnMenu3 = [[UIButton alloc] initWithFrame:btnMenu1.bounds];
    btnMenu3.centerX = SCREEN_WIDTH/4*3;
    btnMenu3.centerY = btnMenu1.centerY;
    [self addSubview:btnMenu3];


    UIButton *btnClose = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 150, 60, 60)];
    [btnClose setImage:[YYImage imageNamed:@"login_out"] forState:UIControlStateNormal];
    btnClose.centerX = SCREEN_WIDTH/2;
    [self addSubview:btnClose];
    [btnClose addTarget:self action:@selector(doClose) forControlEvents:UIControlEventTouchDown];


    [btnMenu1 setImage:[YYImage imageNamed:@"my_barter.png"]
             withTitle:@"样板拍"
              sizeFont:[UIFont systemFontOfSize:13]
            titleColor:COLOR_DETAIL
              forState:UIControlStateNormal];
    [btnMenu1 addTarget:self action:@selector(gotoBidTypeMode) forControlEvents:UIControlEventTouchUpInside];


    [btnMenu2 setImage:[YYImage imageNamed:@"my_supply.png"]
             withTitle:@"批量拍"
              sizeFont:[UIFont systemFontOfSize:13]
            titleColor:COLOR_DETAIL
              forState:UIControlStateNormal];
    [btnMenu2 addTarget:self action:@selector(gotoBidTypeBatch) forControlEvents:UIControlEventTouchUpInside];



    [btnMenu3 setImage:[YYImage imageNamed:@"my_barter.png"]
             withTitle:@"拍卖会"
              sizeFont:[UIFont systemFontOfSize:13]
            titleColor:COLOR_DETAIL
              forState:UIControlStateNormal];
    [btnMenu3 addTarget:self action:@selector(gotoBidTypeMeeting) forControlEvents:UIControlEventTouchUpInside];

}

- (void)gotoBidTypeMode {
    [[GotoAppdelegate sharedAppDelegate] pushViewController:[[BMAddViewController alloc] initWithBid:BidType_mode]];
    [self doClose];
}

- (void)gotoBidTypeBatch {
    [[GotoAppdelegate sharedAppDelegate] pushViewController:[[BMAddViewController alloc] initWithBid:BidType_batch]];
    [self doClose];
}

- (void)gotoBidTypeMeeting {
    [[GotoAppdelegate sharedAppDelegate] pushViewController:[[BMAddViewController alloc] initWithBid:BidType_meeting]];
    [self doClose];
}

- (void)doClose {
    if(self.closeBLock) {
        self.closeBLock();
    }
}

@end
