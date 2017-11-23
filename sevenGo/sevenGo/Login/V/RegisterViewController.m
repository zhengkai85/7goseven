//
//  RegisterViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/10/9.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "RegisterViewController.h"
#import "GotoAppdelegate.h"
#import "AgreementViewController.h"
#import "LoginNet.h"
#import "LCProgressHUD.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    self.arrDataSoruce = @[ReusePhoneTableViewCell,ReuseCodeTableViewCell,ReusePwdTableViewCell];
    [super viewDidLoad];
    
    self.tableView.tableHeaderView = [self getTabViewHeardView];
    self.tableView.tableFooterView = [self getTabViewFootView];
    
    if([self.phone isNoEmpty]) {
        self.txtPhone.text = self.phone;
    }
    
    if([self.password isNoEmpty]) {
        self.txtPwd.text = self.password;
    }
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
    lblTitle.text = @"注册";
    lblTitle.textAlignment = NSTextAlignmentCenter;
    [img addSubview:lblTitle];
    
    
    return img;
}
    
- (UIView*)getTabViewFootView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,200)];
    
    UIButton *btnLogin = [[UIButton alloc] initWithFrame:CGRectMake(30, 40, SCREEN_WIDTH-60, 40)];
    [btnLogin setTitle:@"注册" forState:UIControlStateNormal];
    btnLogin.layer.cornerRadius = 4.0;
    [btnLogin setBackgroundImage:[YYImage imageNamed:@"login_buttonNor"] forState:UIControlStateNormal];
    [btnLogin setBackgroundImage:[YYImage imageNamed:@"login_buttonSel"] forState:UIControlStateHighlighted];
    [btnLogin addTarget:self action:@selector(doRegist:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnLogin];
    
    UIButton *btnAggress = [[UIButton alloc] initWithFrame:CGRectMake(btnLogin.right-210, btnLogin.bottom+10, 210, 20)];
    [btnAggress setTitle:@"点击注册意味着您同意《用户协议》" forState:UIControlStateNormal];
    [btnAggress setTitleColor:COLOR_DETAIL forState:UIControlStateNormal];
    btnAggress.titleLabel.font = [UIFont systemFontOfSize:12];
    [btnAggress addTarget:self action:@selector(doAggress:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnAggress];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(btnAggress.left - 13, 0, 10, 10)];
    icon.centerY = btnAggress.centerY;
    icon.image = [YYImage imageNamed:@"login_smallCheck"];
    [view addSubview:icon];
    
    return view;
}
    
- (void)doRegist:(id)sender {
    
    if(self.txtPhone.text.length == 0) {
        [LCProgressHUD showMessage:@"手机号不能为空"];
        return;
    }
    
    if(self.txtPwd.text.length == 0) {
        [LCProgressHUD showMessage:@"密码不能为空"];
        return;
    }
    
    if(self.txtCode.text.length == 0) {
        [LCProgressHUD showMessage:@"验证码不能为空"];
        return;
    }
    
    [LoginNet accountUserName:self.txtPhone.text
                     password:self.txtPwd.text
                   reg_verify:self.txtCode.text
                        block:^(id posts, NSInteger code, NSString *errorMsg) {
                            if(code == 200) {
                                [LCProgressHUD showMessage:@"注册成功"];
                                if(self.bindRegSucessBLock) {
                                    self.bindRegSucessBLock();
                                }
                            }
                        }];
}

- (void)doClose:(id)sender {
    [[GotoAppdelegate sharedAppDelegate] popViewController];
}
    
- (void)doAggress:(id)sender {
    [[GotoAppdelegate sharedAppDelegate] pushViewController:[[AgreementViewController alloc] init] animated:NO];
}
@end
