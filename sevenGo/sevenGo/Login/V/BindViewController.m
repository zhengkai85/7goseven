//
//  BindViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/10/17.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "BindViewController.h"
#import "LoginNet.h"
#import "LCProgressHUD.h"
#import "RegisterViewController.h"
#import "AppCacheData.h"

@interface BindViewController ()

@end

@implementation BindViewController

- (void)viewDidLoad {
    self.arrDataSoruce = @[ReusePhoneTableViewCell,ReusePwdTableViewCell];
    [super viewDidLoad];
    
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
    lblTitle.text = @"绑定手机号";
    lblTitle.textAlignment = NSTextAlignmentCenter;
    [img addSubview:lblTitle];
    
    return img;
}

- (UIView*)getTabViewFootView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,200)];
    
    UIButton *btnLogin = [[UIButton alloc] initWithFrame:CGRectMake(30, 40, SCREEN_WIDTH-60, 40)];
    [btnLogin setTitle:@"立即绑定" forState:UIControlStateNormal];
    btnLogin.layer.cornerRadius = 4.0;
    [btnLogin setBackgroundImage:[YYImage imageNamed:@"login_buttonNor"] forState:UIControlStateNormal];
    [btnLogin setBackgroundImage:[YYImage imageNamed:@"login_buttonSel"] forState:UIControlStateHighlighted];
    [btnLogin addTarget:self action:@selector(doBind:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnLogin];
    
    return view;
}

- (void)doBind:(id)sender {
    
    if(self.txtPhone.text.length == 0) {
        [LCProgressHUD showMessage:@"手机号不能为空"];
        return;
    }
    
    if(self.txtPwd.text.length == 0) {
        [LCProgressHUD showMessage:@"密码不能为空"];
        return;
    }
    
    [LoginNet checkAccount:self.txtPhone.text
                     block:^(id posts, NSInteger code, NSString *errorMsg) {
                         if(code == 400) {
                             [self bind];
                         } else if(code == 200){
                             RegisterViewController *vc = [[RegisterViewController alloc] init];
                             vc.phone = self.txtPhone.text;
                             vc.password = self.txtPwd.text;
                             [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
                             
                             [vc setBindRegSucessBLock:^{
                                 [self bind];
                             }];
                         }
                     }];
}

- (void)doClose:(id)sender {
    [[GotoAppdelegate sharedAppDelegate] popViewController];
}

- (void)bind {
    [LoginNet bindAccountType:self.accountType
                  auth_result:self.auth_result
                    user_info:self.userInfo
                     username:self.txtPhone.text
                     password:self.txtPwd.text
                        block:^(id posts, NSInteger code, NSString *errorMsg) {
                            if(code == 200) {
                                NSDictionary *dicData = posts[@"data"];
                                NSDictionary *dicAuth = dicData[@"auth"];
                                [[AppCacheData shareCachData] setOpen_id:[dicData stringValue:@"open_id"]];
                                [[AppCacheData shareCachData] setU_id:[dicAuth stringValue:@"uid"]];

                                [LCProgressHUD showMessage:@"绑定成功"];
                                [[AppDelegate sharedAppDelegate] enterMainUI];
                                [[NSNotificationCenter defaultCenter] postNotificationName:STRING_NOTIFICATION_LOINGCHANGE
                                                                                    object:nil];
                            }
                        }];
}
@end
