//
//  BMHomeMenuTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 2017/11/20.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "BMHomeMenuTableViewCell.h"
#import "BMOrderContainViewController.h"
#import "GotoRoute.h"

@implementation BMHomeMenuTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIButton *btnMenu1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 100)];
        btnMenu1.centerX = SCREEN_WIDTH/8;
        btnMenu1.centerY = [BMHomeMenuTableViewCell getCellHeight]/2 + 10;
        [self.contentView addSubview:btnMenu1];
        
        UIView *viewLine1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, [BMHomeMenuTableViewCell getCellHeight]/2)];
        viewLine1.centerX = SCREEN_WIDTH/8*2;
        viewLine1.centerY =[BMHomeMenuTableViewCell getCellHeight]/2;
        viewLine1.backgroundColor = COLOR_LINECOLOR;
        [self.contentView addSubview:viewLine1];
        
        UIButton *btnMenu2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 100)];
        btnMenu2.centerX = SCREEN_WIDTH/8*3;
        btnMenu2.centerY = btnMenu1.centerY;
        [self.contentView addSubview:btnMenu2];
        
        UIView *viewLine2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1,[BMHomeMenuTableViewCell getCellHeight]/2)];
        viewLine2.centerX = SCREEN_WIDTH/8*4;
        viewLine2.centerY = viewLine1.centerY;
        viewLine2.backgroundColor = COLOR_LINECOLOR;
        [self.contentView addSubview:viewLine2];
        
        UIButton *btnMenu3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 100)];
        btnMenu3.centerX = SCREEN_WIDTH/8*5;
        btnMenu3.centerY = btnMenu1.centerY;
        [self.contentView addSubview:btnMenu3];
        
        
        UIView *viewLine3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, [BMHomeMenuTableViewCell getCellHeight]/2)];
        viewLine3.centerX = SCREEN_WIDTH/8*6;
        viewLine3.centerY = viewLine1.centerY;
        viewLine3.backgroundColor = COLOR_LINECOLOR;
        [self.contentView addSubview:viewLine3];
        
        UIButton *btnMenu4 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 100)];
        btnMenu4.centerX = SCREEN_WIDTH/8*7;
        btnMenu4.centerY = btnMenu1.centerY;
        [self.contentView addSubview:btnMenu4];
        
        btnMenu1.tag = 100;
        [btnMenu1 setImage:[YYImage imageNamed:@"bm_report.png"]
                 withTitle:@"待付款"
                  sizeFont:[UIFont systemFontOfSize:13]
                titleColor:COLOR_DETAIL
                  forState:UIControlStateNormal];
        [btnMenu1 addTarget:self action:@selector(gotoOrder:) forControlEvents:UIControlEventTouchUpInside];
        
        
        btnMenu2.tag = 200;
        [btnMenu2 setImage:[YYImage imageNamed:@"bm_wait_pay.png"]
                 withTitle:@"待发货"
                  sizeFont:[UIFont systemFontOfSize:13]
                titleColor:COLOR_DETAIL
                  forState:UIControlStateNormal];
        [btnMenu2 addTarget:self action:@selector(gotoOrder:) forControlEvents:UIControlEventTouchUpInside];
        
        
        btnMenu3.tag = 300;
        [btnMenu3 setImage:[YYImage imageNamed:@"bm_wait_rec.png"]
                 withTitle:@"待收货"
                  sizeFont:[UIFont systemFontOfSize:13]
                titleColor:COLOR_DETAIL
                  forState:UIControlStateNormal];
        [btnMenu3 addTarget:self action:@selector(gotoOrder:) forControlEvents:UIControlEventTouchUpInside];
        
        [btnMenu4 setImage:[YYImage imageNamed:@"bm_wait_send.png"]
                 withTitle:@"店铺报表"
                  sizeFont:[UIFont systemFontOfSize:13]
                titleColor:COLOR_DETAIL
                  forState:UIControlStateNormal];
//        [btnMenu4 addTarget:self action:@selector(gotoZP) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)gotoOrder:(id)sender  {
    UIButton *btn = (UIButton*)sender;
    BMOrderContainViewController *vc = [[BMOrderContainViewController alloc] init];
    vc.selIndex = btn.tag/100 - 1;
    [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
}

+ (CGFloat)getCellHeight {
    return 100;
}

@end
