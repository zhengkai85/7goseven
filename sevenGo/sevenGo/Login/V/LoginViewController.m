//
//  LoginViewController.m
//  huimin
//
//  Created by zhengkai on 16/4/7.
//  Copyright © 2016年 zhengkai. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "FindPwdViewController.h"
#import "LCProgressHUD.h"

#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import <UMSocialCore/UMSocialCore.h>

#import "UIAlertView+BlocksKit.h"
#import "GotoAppdelegate.h"
#import "BlocksKit+UIKit.h"
#import "LoginNet.h"
#import "PubFunction.h"
#import "AppDelegate.h"
#import "UMengHelper.h"
#import "BindViewController.h"
#import "AppCacheData.h"
#import "UserViewMode.h"

@interface LoginViewController ()
@property (nonatomic, strong)UIView *viewTop;
@property (nonatomic, strong)UIView *viewBottom;
@property (nonatomic, strong)UIButton *btnRegist;
@property (nonatomic, strong)UIButton *btnForget;

@end

@implementation LoginViewController

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
    
    UIButton *btnClose = [[UIButton alloc] initWithFrame:CGRectMake(20, STATUS_BAR_HEIGHT+10, 15, 15)];
    [btnClose setImage:[YYImage imageNamed:@"login_out.png"] forState:UIControlStateNormal];
    [btnClose addTarget:self action:@selector(doClose:) forControlEvents:UIControlEventTouchUpInside];
    [img addSubview:btnClose];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(btnClose.right, btnClose.top, 100, btnClose.height)];
    lblTitle.centerX = SCREEN_WIDTH/2;
    lblTitle.textColor = COLOR_BLACK;
    lblTitle.font = [UIFont systemFontOfSize:18];
    lblTitle.text = @"登录";
    lblTitle.textAlignment = NSTextAlignmentCenter;
    [img addSubview:lblTitle];
    
    UIButton *btnRegist = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 50, btnClose.top, 30, btnClose.height)];
    [btnRegist setTitle:@"注册" forState:UIControlStateNormal];
    [btnRegist setTitleColor:COLOR_TEXT forState:UIControlStateNormal];
    btnRegist.titleLabel.font = [UIFont systemFontOfSize:14];
    [btnRegist addTarget:self action:@selector(doRegist:) forControlEvents:UIControlEventTouchUpInside];
    [img addSubview:btnRegist];

    return img;
}
    
- (UIView*)getTabViewFootView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,200)];
    
    UIButton *btnLogin = [[UIButton alloc] initWithFrame:CGRectMake(30, 40, SCREEN_WIDTH-60, 40)];
    [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    btnLogin.layer.cornerRadius = 4.0;
    [btnLogin setBackgroundImage:[YYImage imageNamed:@"login_buttonNor"] forState:UIControlStateNormal];
    [btnLogin setBackgroundImage:[YYImage imageNamed:@"login_buttonSel"] forState:UIControlStateHighlighted];
    [btnLogin addTarget:self action:@selector(doLogin:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnLogin];
    
    UIButton *btnForget = [[UIButton alloc] initWithFrame:CGRectMake(btnLogin.right - 60, btnLogin.bottom + 10, 60, 30)];
    [btnForget setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [btnForget setTitleColor:COLOR_NAV forState:UIControlStateNormal];
    btnForget.titleLabel.font = [UIFont systemFontOfSize:12];
    [btnForget addTarget:self action:@selector(doForget:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnForget];
    
    
    UILabel *lblTag = [[UILabel alloc] initWithFrame:CGRectMake(0, btnForget.bottom+20, 100, 13)];
    lblTag.centerX = view.width/2;
    lblTag.textAlignment = NSTextAlignmentCenter;
    lblTag.text = @"使用其他账号登录";
    lblTag.textColor = COLOR_DETAIL;
    lblTag.font = [UIFont systemFontOfSize:12];
    [view addSubview:lblTag];
    
    UIButton *btnWeChart = [[UIButton alloc] initWithFrame:CGRectMake(0, lblTag.bottom+20, 50, 50)];
    btnWeChart.centerX = self.view.width/2 - 50;
    [btnWeChart setImage:[YYImage imageNamed:@"weixin"] forState:UIControlStateNormal];
    [btnWeChart addTarget:self action:@selector(doWeCharLogin:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnWeChart];
    
    UIButton *btnQQ = [[UIButton alloc] initWithFrame:CGRectMake(0, btnWeChart.top, 50, 50)];
    btnQQ.centerX = self.view.width/2 + 50;
    [btnQQ setImage:[YYImage imageNamed:@"qq"] forState:UIControlStateNormal];
    [btnQQ addTarget:self action:@selector(doQQLogin:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnQQ];
    
    return view;
}


- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
   [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)doClose:(id)sender {
    if(self.cancleBlock) {
        self.cancleBlock();
    }

    [[AppDelegate sharedAppDelegate] enterMainUI];
}

- (IBAction)doLogin:(id)sender {
    
    

    

//    BindViewController *vc = [[BindViewController alloc] init];
//
//    vc.accountType = @"qq";
//    [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
    
    if(self.txtPhone.text.length == 0) {
        [LCProgressHUD showMessage:@"手机号不能为空"];
        return;
    }

    if(self.txtPwd.text.length == 0) {
        [LCProgressHUD showMessage:@"密码不能为空"];
        return;
    }

    [LoginNet loginUserName:self.txtPhone.text
                   password:self.txtPwd.text
                      block:^(id posts, NSInteger code, NSString *errorMsg) {
                          if(code == 200) {
                              [self saveUserMessage:(NSDictionary*)posts];
                              [self loginSucess];
                          } else {
                              [PubFunction showNetErrorLocalStr:@"登录失败" serverStr:errorMsg];
                          }
                      }];
}

- (void)doRegist:(id)sender {
    
    RegisterViewController *vc = [[RegisterViewController alloc] init];
    [[GotoAppdelegate sharedAppDelegate] pushViewController:vc animated:NO];

}

- (void)doForget:(id)sender {

    FindPwdViewController *vc = [[FindPwdViewController alloc] init];
    [[GotoAppdelegate sharedAppDelegate] pushViewController:vc animated:NO];
}


- (void)doQQLogin:(id)sender {
    [UMengHelper getUserInfoForPlatform:UMSocialPlatformType_QQ
                             completion:^(id result, NSError *error) {
                                 if(!error){
                                     UMSocialUserInfoResponse *resp = result;
                                     NSDictionary *dicAuth_result = @{@"userid" : resp.uid,
                                                                      @"access_token" : resp.accessToken
                                                                      };
                                     
                                     NSDictionary *dicUserInfo = @{@"nickname": resp.name,
                                                                   @"gender" : resp.gender,
                                                                   @"figureurl_qq_2" : resp.iconurl,
                                                                   @"ret" : @""
                                                                   };
                                     [LoginNet oauthAccountType:@"qq"
                                                    auth_result:[dicAuth_result jsonStringEncoded]
                                                          block:^(id posts, NSInteger code, NSString *errorMsg) {
                                                              if(code == 200) {
                                                                  [self saveUserMessage:(NSDictionary*)posts];
                                                                  [self loginSucess];
                                                              } else if(code == 202){
                                                                  BindViewController *vc = [[BindViewController alloc] init];
                                                                  vc.auth_result = [dicAuth_result jsonStringEncoded];
                                                                  vc.userInfo = [dicUserInfo jsonStringEncoded];
                                                                  vc.accountType = @"qq";
                                                                  [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
                                                              }
                                                              
                                                          }];

                                 }
                             }];
}



- (void)doWeCharLogin:(id)sender {
    
    [UMengHelper getUserInfoForPlatform:UMSocialPlatformType_WechatSession
                             completion:^(id result, NSError *error) {
                                 if(!error){
                                     UMSocialUserInfoResponse *resp = result;
                                     NSDictionary *dicAuth_result = @{@"unionid" : resp.unionId,
                                                                      @"openid" : resp.openid,
                                                                      @"access_token" : resp.accessToken
                                                                      };
                                     
                                     
                                     NSDictionary *dicUserInfo = @{@"nickname": resp.name,
                                                                   @"sex" : resp.unionGender,
                                                                   @"headimgurl" : resp.iconurl,
                                                                   @"ret" : @""
                                                                   };
                                     
                                     [LoginNet oauthAccountType:@"weixin"
                                                    auth_result:[dicAuth_result jsonStringEncoded]
                                                          block:^(id posts, NSInteger code, NSString *errorMsg) {
                                                              if(code == 200) {
                                                                  [self saveUserMessage:(NSDictionary*)posts];
                                                                  [self loginSucess];
                                                              } else if(code == 202){
                                                                  BindViewController *vc = [[BindViewController alloc] init];
                                                                  vc.auth_result = [dicAuth_result jsonStringEncoded];
                                                                  vc.userInfo = [dicUserInfo jsonStringEncoded];
                                                                  vc.accountType = @"weixin";
                                                                  [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
                                                              }
                                                          }];
                                 }
                             }];
}


- (void)loginSucess {
    [LCProgressHUD showMessage:@"登录成功"];
    [[AppDelegate sharedAppDelegate] enterMainUI];
    [[NSNotificationCenter defaultCenter] postNotificationName:STRING_NOTIFICATION_LOINGCHANGE
                                                        object:nil];
}

- (void)saveUserMessage:(NSDictionary*)dic {
    NSDictionary *dicData = dic[@"data"];
    NSDictionary *dicData1 = dic[@"data_1"];
    [[AppCacheData shareCachData] setOpen_id:[dicData stringValue:@"open_id"]];
    [[AppCacheData shareCachData] setU_id:[dicData1 stringValue:@"uid"]];
    
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithDictionary:dicData1];
    [muDic setObject:dicData[@"auth"][@"role_id"] forKey:@"role_id"];
    UserViewMode *user = [UserViewMode modelWithDictionary:muDic];
    [[AppCacheData shareCachData] setAllUserMessage:user];
}


@end
