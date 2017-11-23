//
//  RootLoginViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/10/9.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "RootLoginViewController.h"
#import "JKCountDownButton.h"
#import "RootTableViewCell.h"

@interface RootLoginViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation RootLoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    
}
    
- (void)viewWillDisappear:(BOOL)animated {
    //[self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}
    
    
+ (CGFloat)getCellHeight {
    return 60;
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                   -STATUS_BAR_HEIGHT,
                                                                   SCREEN_WIDTH,
                                                                   SCREEN_HEIGHT + STATUS_BAR_HEIGHT)
                                                  style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = [RootLoginViewController getCellHeight];
    self.tableView.sectionHeaderHeight = 10;
    self.tableView.sectionFooterHeight = 0.0001;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    

    [self.tableView registerClass:[RootTableViewCell class]
           forCellReuseIdentifier:ReusePhoneTableViewCell];
    
    [self.tableView registerClass:[RootTableViewCell class]
           forCellReuseIdentifier:ReusePwdTableViewCell];
    
    [self.tableView registerClass:[RootTableViewCell class]
           forCellReuseIdentifier:ReuseCodeTableViewCell];
    
    [self.tableView registerClass:[RootTableViewCell class]
           forCellReuseIdentifier:ReuseInviterTableViewCell];
    
    [self.tableView registerClass:[RootTableViewCell class]
           forCellReuseIdentifier:ReuseRePwdTableViewCell];
}
    

    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrDataSoruce.count;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellName = self.arrDataSoruce[indexPath.row];
    
    if([cellName isEqualToString:ReusePhoneTableViewCell]) {
        return [self getPhoneCellTable:tableView cellForRowAtIndexPath:indexPath reuseString:ReusePhoneTableViewCell];
    } else if ([cellName isEqualToString:ReusePwdTableViewCell]) {
        return [self getPwdCellTable:tableView cellForRowAtIndexPath:indexPath reuseString:ReusePwdTableViewCell];
    } else if ([cellName isEqualToString:ReuseCodeTableViewCell]) {
        return [self getCodeCellTable:tableView cellForRowAtIndexPath:indexPath reuseString:ReuseCodeTableViewCell];
    } else if ([cellName isEqualToString:ReuseRePwdTableViewCell]) {
        return [self getRePwdCellTable:tableView cellForRowAtIndexPath:indexPath reuseString:ReuseRePwdTableViewCell];
    }
    
    return [UITableViewCell new];
}

- (UITableViewCell*)getPhoneCellTable:(UITableView *)tableView
                cellForRowAtIndexPath:(NSIndexPath *)indexPath
                          reuseString:(NSString *)reuseString {
    
    RootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseString
                                                                forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, 15, 20)];
    icon.image = [YYImage imageNamed:@"login_phone"];
    [cell.contentView addSubview:icon];
    
    self.txtPhone = [[UITextField alloc] initWithFrame:CGRectMake(icon.left+30,
                                                                  [RootLoginViewController getCellHeight] - 35,
                                                                  SCREEN_WIDTH - icon.left - 50,
                                                                  30)];
    icon.centerY = self.txtPhone.centerY;
    [cell.contentView addSubview:self.txtPhone];
    
    NSString *holderText = @"请输入手机号";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont boldSystemFontOfSize:14]
                        range:NSMakeRange(0, holderText.length)];
    self.txtPhone.attributedPlaceholder = placeholder;
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(icon.left, [RootLoginViewController getCellHeight] - 1, SCREEN_WIDTH-icon.left*2, 0.6)];
    line.backgroundColor = COLOR_LINECOLOR;
    [cell.contentView addSubview:line];
    
    return cell;
}
    
- (UITableViewCell*)getPwdCellTable:(UITableView *)tableView
              cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        reuseString:(NSString *)reuseString {
    
    RootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseString
                                                            forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, 15, 20)];
    icon.image = [YYImage imageNamed:@"login_pwd"];
    [cell.contentView addSubview:icon];
    
    self.txtPwd = [[UITextField alloc] initWithFrame:CGRectMake(icon.left+30,
                                                                [RootLoginViewController getCellHeight] - 35,
                                                                SCREEN_WIDTH - icon.left - 50,
                                                                30)];
    icon.centerY = self.txtPwd.centerY;
    self.txtPwd.secureTextEntry = YES;
    [cell.contentView addSubview:self.txtPwd];
    
    NSString *holderText = @"请输入密码";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont boldSystemFontOfSize:14]
                        range:NSMakeRange(0, holderText.length)];
    self.txtPwd.attributedPlaceholder = placeholder;
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(icon.left, [RootLoginViewController getCellHeight] - 1, SCREEN_WIDTH-icon.left*2, 0.6)];
    line.backgroundColor = COLOR_LINECOLOR;
    [cell.contentView addSubview:line];
    
    return cell;
}

    

- (UITableViewCell*)getCodeCellTable:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath reuseString:(NSString *)reuseString {
    RootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseString
                                                            forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, 15, 20)];
    icon.image = [YYImage imageNamed:@"login_code"];
    [cell.contentView addSubview:icon];
    
    self.txtCode = [[UITextField alloc] initWithFrame:CGRectMake(icon.left+30,
                                                                  [RootLoginViewController getCellHeight] - 35,
                                                                  100,
                                                                  30)];
    icon.centerY = self.txtCode.centerY;
    [cell.contentView addSubview:self.txtCode];
    
    NSString *holderText = @"请输入验证码";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont boldSystemFontOfSize:14]
                        range:NSMakeRange(0, holderText.length)];
    self.txtCode.attributedPlaceholder = placeholder;
    
    JKCountDownButton *countDownCode = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
    countDownCode.frame = CGRectMake(SCREEN_WIDTH - 60 - 50, self.txtCode.top, 80, 25);
    countDownCode.layer.cornerRadius = 12.0;
    [countDownCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    countDownCode.titleLabel.font = [UIFont systemFontOfSize:12];
    countDownCode.backgroundColor = COLOR_NAV;
    [cell.contentView addSubview:countDownCode];
    
    [countDownCode countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
        sender.enabled = NO;
        [sender startCountDownWithSecond:120];
        [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
            NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
            return title;
        }];
        [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
            countDownButton.enabled = YES;
            return @"点击重新获取";
        }];
    }];
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(icon.left, [RootLoginViewController getCellHeight] - 1, SCREEN_WIDTH-icon.left*2, 0.6)];
    line.backgroundColor = COLOR_LINECOLOR;
    [cell.contentView addSubview:line];
    
    return cell;
}
    
- (UITableViewCell*)getInviterCellTable:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath reuseString:(NSString *)reuseString {
    RootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseString
                                                            forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, 15, 20)];
    icon.image = [YYImage imageNamed:@"login_phone"];
    [cell.contentView addSubview:icon];
    
    self.txtInviter = [[UITextField alloc] initWithFrame:CGRectMake(icon.left+30,
                                                                  [RootLoginViewController getCellHeight] - 35,
                                                                  SCREEN_WIDTH - icon.left - 50,
                                                                  30)];
    icon.centerY = self.txtInviter.centerY;
    [cell.contentView addSubview:self.txtInviter];
    
    NSString *holderText = @"选填。请填写邀请者UID";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont boldSystemFontOfSize:14]
                        range:NSMakeRange(0, holderText.length)];
    self.txtInviter.attributedPlaceholder = placeholder;
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(icon.left, [RootLoginViewController getCellHeight] - 1, SCREEN_WIDTH-icon.left*2, 0.6)];
    line.backgroundColor = COLOR_LINECOLOR;
    [cell.contentView addSubview:line];
    
    return cell;
}

- (UITableViewCell*)getRePwdCellTable:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  reuseString:(NSString *)reuseString {
    
    RootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseString
                                                            forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, 15, 20)];
    icon.image = [YYImage imageNamed:@"login_pwd"];
    [cell.contentView addSubview:icon];
    
    self.txtRePwd = [[UITextField alloc] initWithFrame:CGRectMake(icon.left+30,
                                                                [RootLoginViewController getCellHeight] - 35,
                                                                SCREEN_WIDTH - icon.left - 50,
                                                                30)];
    icon.centerY = self.txtRePwd.centerY;
    self.txtRePwd.secureTextEntry = YES;
    [cell.contentView addSubview:self.txtRePwd];
    
    NSString *holderText = @"请输入密码";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont boldSystemFontOfSize:14]
                        range:NSMakeRange(0, holderText.length)];
    self.txtRePwd.attributedPlaceholder = placeholder;
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(icon.left, [RootLoginViewController getCellHeight] - 1, SCREEN_WIDTH-icon.left*2, 0.6)];
    line.backgroundColor = COLOR_LINECOLOR;
    [cell.contentView addSubview:line];
    
    return cell;
}

@end
