//
//  FindPwdViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/10/10.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "FindPwdViewController.h"

@interface FindPwdViewController ()

@end

@implementation FindPwdViewController

- (void)viewDidLoad {
    
    self.arrDataSoruce = @[ReusePhoneTableViewCell,ReuseCodeTableViewCell,ReusePwdTableViewCell,ReuseRePwdTableViewCell];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.tableHeaderView = [self getTabViewHeardView];
    self.tableView.tableFooterView = [self getTabViewFootView];
}

- (UIView*)getTabViewHeardView {
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/1.68)];
    img.userInteractionEnabled = YES;
    [img setImage:[YYImage imageNamed:@"login_background.png"]];
    
    UIButton *btnClose = [[UIButton alloc] initWithFrame:CGRectMake(25, STATUS_BAR_HEIGHT+10, 9, 16)];
    [btnClose setImage:[YYImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
    [btnClose addTarget:self action:@selector(doClose:) forControlEvents:UIControlEventTouchUpInside];
    [img addSubview:btnClose];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(btnClose.right, btnClose.top, 100, btnClose.height)];
    lblTitle.centerX = SCREEN_WIDTH/2;
    lblTitle.textColor = COLOR_BLACK;
    lblTitle.font = [UIFont systemFontOfSize:18];
    lblTitle.text = @"找回密码";
    lblTitle.textAlignment = NSTextAlignmentCenter;
    [img addSubview:lblTitle];
    
    
    return img;
}
    
- (UIView*)getTabViewFootView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,200)];
    
    UIButton *btnLogin = [[UIButton alloc] initWithFrame:CGRectMake(30, 40, SCREEN_WIDTH-60, 40)];
    [btnLogin setTitle:@"确定" forState:UIControlStateNormal];
    btnLogin.layer.cornerRadius = 4.0;
    [btnLogin setBackgroundImage:[YYImage imageNamed:@"login_buttonNor"] forState:UIControlStateNormal];
    [btnLogin setBackgroundImage:[YYImage imageNamed:@"login_buttonSel"] forState:UIControlStateHighlighted];
    [btnLogin addTarget:self action:@selector(doFind:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnLogin];
    
    return view;
}
    
- (void)doClose:(id)sender {
    [[GotoAppdelegate sharedAppDelegate] popViewController];
}
    
- (void)doFind:(id)sender {
}
@end
