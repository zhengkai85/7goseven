//
//  RootLoginViewController.h
//  sevenGo
//
//  Created by zhengkai on 2017/10/9.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "RootViewController.h"

#define ReusePhoneTableViewCell         @"PhoneTableViewCell"
#define ReusePwdTableViewCell           @"PwdTableViewCell"
#define ReuseCodeTableViewCell          @"CodeTableViewCell"
#define ReuseInviterTableViewCell       @"InviterTableViewCell"
#define ReuseRePwdTableViewCell         @"RePwdTableViewCell"



@interface RootLoginViewController : RootViewController
@property (nonatomic, strong)UITextField *txtPhone;
@property (nonatomic, strong)UITextField *txtPwd;
@property (nonatomic, strong)UITextField *txtCode;
@property (nonatomic, strong)UITextField *txtInviter;
@property (nonatomic, strong)UITextField *txtRePwd;
@property (nonatomic, strong)NSArray *arrDataSoruce;
@property (nonatomic, strong) UITableView *tableView;

@end
