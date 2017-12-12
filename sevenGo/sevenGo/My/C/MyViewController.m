//
//  MyViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/10/18.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "MyViewController.h"
#import "UserViewMode.h"
#import "MyLevelUpTableViewCell.h"
#import "MyMenuTableViewCell.h"
#import "AppCacheData.h"
#import "ReactiveCocoa.h"
#import "MyNet.h"
#import "RootWebViewController.h"
#import "WalletHomeViewController.h"
#import "InvitationViewController.h"
#import "GotoRoute.h"
#import "BlocksKit+UIKit.h"
#import "LCProgressHUD.h"

@interface MyViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView      *tableView;
@property (nonatomic, strong) NSArray   *arrDataSource;
@property (nonatomic, assign) BOOL isEnt;

@end


#define ReuseLevelUpTableViewCell         @"MyLevelUpTableViewCell"
#define ReuseMenuTableViewCell            @"MyMenuTableViewCell"
#define ReuseTableViewCell                @"TableViewCell"

@implementation MyViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    
    NSString *uId = [AppCacheData shareCachData].getU_id;
    if(uId && uId.length > 0) {
        [MyNet userDataBlock:^(id posts, NSInteger code, NSString *errorMsg) {
            ;
        }];
    }

    
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isEnt = NO;
    
    CGFloat height = [self addTopView];
    
    
    
    [RACObserve(self, isEnt) subscribeNext:^(id x) {
        if(!self.isEnt) {
            self.arrDataSource = @[@"邀请好友",@"收货地址管理",@"联系客服",@"个人信息",@"设置"];
        } else {
            self.arrDataSource = @[@"咨询管理",@"留言管理",@"企业信息",@"合作管理",@"联系客服",@"设置"];
        }
        
        [self.tableView reloadData];
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                   height,
                                                                   CGRectGetWidth(self.view.frame),
                                                                   CGRectGetHeight(self.view.frame) - height - TAB_BAR_HEIGHT)
                                                  style:UITableViewStyleGrouped];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionHeaderHeight = 0.0001;
    self.tableView.sectionFooterHeight = 0.0001;
    [self.view addSubview:self.tableView];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:ReuseLevelUpTableViewCell bundle:nil]
         forCellReuseIdentifier:ReuseLevelUpTableViewCell];
    
    [self.tableView registerClass:[MyMenuTableViewCell class]
           forCellReuseIdentifier:ReuseMenuTableViewCell];
    
    [self.tableView registerClass:[RootTableViewCell class]
           forCellReuseIdentifier:ReuseTableViewCell];
    
}



- (CGFloat)addTopView {
    
    UIView *viewTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/75*54)];
    [self.view addSubview:viewTop];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/75*54)];
    img.image = [YYImage imageNamed:@"my_background.png"];
    [viewTop addSubview:img];
    
    UIButton *heard = [[UIButton alloc] initWithFrame:CGRectMake(0, 70, 75, 75)];
    heard.centerX = viewTop.width/2;
    heard.layer.cornerRadius = heard.width/2;
    heard.clipsToBounds = YES;
    [viewTop addSubview:heard];
    [heard addTarget:self action:@selector(gotoPersonalCenter) forControlEvents:UIControlEventTouchUpInside];

    
    UILabel *lblName = [[UILabel alloc] initWithFrame:CGRectMake(20, heard.bottom+5, SCREEN_WIDTH-40, 17)];
    lblName.centerX = viewTop.width/2;
    lblName.textAlignment = NSTextAlignmentCenter;
    lblName.font = [UIFont systemFontOfSize:17];
    lblName.textColor = COLOR_TEXT;
    [viewTop addSubview:lblName];
    lblName.userInteractionEnabled = YES;
    [lblName bk_whenTapped:^{
        [self gotoPersonalCenter];
    }];
    
    UILabel *lblLeve = [[UILabel alloc] initWithFrame:CGRectMake(lblName.left, lblName.bottom+15, lblName.width, 13)];
    lblLeve.centerX = viewTop.width/2;
    lblLeve.textAlignment = NSTextAlignmentCenter;
    lblLeve.font = [UIFont systemFontOfSize:12];
    lblLeve.textColor = COLOR_DETAIL;
    [viewTop addSubview:lblLeve];

    UIButton *btnChange = [[UIButton alloc] initWithFrame:CGRectMake(0, lblLeve.bottom + 20, 90, 30)];
    btnChange.layer.cornerRadius = 16.0;
    btnChange.centerX = viewTop.width/2;
    btnChange.titleLabel.font = [UIFont systemFontOfSize:13];
    [btnChange setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnChange.backgroundColor = COLOR_NAV;
    [viewTop addSubview:btnChange];
    [btnChange addTarget:self action:@selector(doChange) forControlEvents:UIControlEventTouchUpInside];
    [RACObserve(self, isEnt) subscribeNext:^(id x) {
        if(!self.isEnt) {
            [btnChange setTitle:@"切换到企业" forState:UIControlStateNormal];
        } else {
            [btnChange setTitle:@"切换到个人" forState:UIControlStateNormal];
        }
        
        [self.tableView reloadData];
    }];
    

    UIButton *btnSetting = [[UIButton alloc] initWithFrame:CGRectMake(20, 40, 21, 21)];
    [btnSetting setImage:[YYImage imageNamed:@"my_sheZhi.png"] forState:UIControlStateNormal];
    [viewTop addSubview:btnSetting];
    [btnSetting addTarget:self
                   action:@selector(gotoSetting)
         forControlEvents:UIControlEventTouchUpInside];
    
    
    [RACObserve([AppCacheData shareCachData], userMode) subscribeNext:^(id x) {
        UserViewMode *mode = (UserViewMode *)x;
        if(mode) {
            
            [heard setImageWithURL:[NSURL URLWithString:mode.avatar128]
                          forState:UIControlStateNormal
                           options:YYWebImageOptionShowNetworkActivity];
            lblName.text = mode.nickname;
            lblLeve.text = [NSString stringWithFormat:@"会员ID:%@",mode.uid];
            lblLeve.hidden = NO;
            btnChange.hidden = NO;
            
        } else {
            [heard setImage:[YYImage imageNamed:@"my_DefFace.png"] forState:UIControlStateNormal];
            lblName.text = @"未登录";
            lblLeve.hidden = YES;
            btnChange.hidden = YES;
        }
    }];
    return viewTop.height;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) {
        return 2;
    } else if (section == 1) {
        return self.arrDataSource.count;

    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0) {
        if(indexPath.row == 0) {
            MyLevelUpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseLevelUpTableViewCell forIndexPath:indexPath];
            return cell;
        } else if (indexPath.row == 1) {
            MyMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseMenuTableViewCell forIndexPath:indexPath];
            cell.isEnt = self.isEnt;
            return cell;
        }
    } else if (indexPath.section == 1) {
        RootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseTableViewCell forIndexPath:indexPath];
        NSString *str = self.arrDataSource[indexPath.row];
        cell.textLabel.text = str;
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.textColor = COLOR_TEXT;
        return cell;
    }

    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        if(indexPath.row == 0) {
            return [MyLevelUpTableViewCell getCellHeight];
        } else if (indexPath.row == 1) {
            return [MyMenuTableViewCell getCellHeight];
        }
    } else if (indexPath.section == 1) {
        return 50;
    };
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return 0.0001;
    } else if (section == 1) {
        return 10;
    };
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        NSString *menuName = self.arrDataSource[indexPath.row];
        //            self.arrDataSource = @[@"咨询管理",@"留言管理",@"企业信息",@"合作管理",@"联系客服",@"设置"];

        if([menuName isEqualToString:@"邀请好友"]) {
            [self gotoInviterFrend];
        } else if([menuName isEqualToString:@"收货地址管理"]) {
            [self gotoReceivingAddress];
        } else if([menuName isEqualToString:@"联系客服"]) {
            [self gotoContactService];
        } else if([menuName isEqualToString:@"个人信息"]) {
            [self gotoPersonalCenter];
        } else if([menuName isEqualToString:@"设置"]) {
            if(self.isEnt) {
                [self gotoEntSetting];
            } else {
                [self gotoSetting];
            }
        } else if ([menuName isEqualToString:@"咨询管理"]) {
            [self gotoEntNewsMng];
        } else if ([menuName isEqualToString:@"留言管理"]) {
            [self gotoEntMessageMng];
        } else if ([menuName isEqualToString:@"企业信息"]) {
            [self gotoEntInfo];
        } else if ([menuName isEqualToString:@"合作管理"]) {
            [self gotoEntCooperation];
        }
    }
}


- (void)doChange {
    if([GotoRoute isLogin]) {
        return;
    }
    
    if([[AppCacheData shareCachData].userMode.computer_id isNoEmpty]) {
        self.isEnt = YES;
    } else {
        self.isEnt = NO;
        UIAlertView *alert = [UIAlertView bk_showAlertViewWithTitle:@""
                                                            message:@"您还不是企业用户，点击开通超多专属权益"
                                                  cancelButtonTitle:@"我再想想"
                                                  otherButtonTitles:@[@"去开通"]
                                                            handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                                                if (buttonIndex == 1) {
                                                                    [self gotoH5:@"/iQiGou/h5/iQiGou/src/app/commercialArea/upgradeVip.w"];
                                                                }
                                                            }];
        [alert show];
    }
}

//设置
- (void)gotoSetting {
    if([GotoRoute isLogin]) {
        return;
    }

    [self gotoH5:@"/iQiGou/h5/iQiGou/src/app/settings/setting.w"];
}


//邀请好友
- (void)gotoInviterFrend {
    
    if([GotoRoute isLogin]) {
        return;
    }
    
    InvitationViewController *vc = [[InvitationViewController alloc] init];
    [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
}

//收货地址
- (void)gotoReceivingAddress {
    [self gotoH5:@"/iQiGou/h5/iQiGou/src/app/accountSafety/addressManager.w"];
}

//联系客服
- (void)gotoContactService {
    [self gotoH5:@"/iQiGou/h5/iQiGou/src/app/settings/contactus.w"];
}

//个人中心
- (void)gotoPersonalCenter {
    [self gotoH5:@"/iQiGou/h5/iQiGou/src/app/accountSafety/personalInfo.w"];
}

//个人VIP
- (void)gotoPersonalVip {
    [self gotoH5:@"/iQiGou/h5/iQiGou/src/app/commercialArea/upgradeVip.w"];
}

//企业会员
- (void)gotoEntVip {
    [self gotoH5:@"/iQiGou/h5/iQiGou/src/app/commercialArea/upgradeVip.w"];
}

//企业信息
- (void)gotoEntInfo {
    [self gotoH5:@"/iQiGou/h5/iQiGou/src/app/manager/personalInfo.w"];
}

//企业设置
- (void)gotoEntSetting {
    [self gotoH5:@"/iQiGou/h5/iQiGou/src/app/manager/setting.w"];
}



//资讯管理
- (void)gotoEntNewsMng {
    if([GotoRoute isLogin]) {
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"/iQiGou/h5/iQiGou/src/app/manager/newsMng.w?uid=%@",[AppCacheData shareCachData].userMode.uid];
    [self gotoH5:url];
    
}

//留言管理
- (void)gotoEntMessageMng {
    if([GotoRoute isLogin]) {
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"/iQiGou/h5/iQiGou/src/app/manager/messageMng?uid=%@",[AppCacheData shareCachData].userMode.uid];
    [self gotoH5:url];
}

// 合作管理
- (void)gotoEntCooperation {
    if([GotoRoute isLogin]) {
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"/iQiGou/h5/iQiGou/src/app/manager/cooperationManager/cooperation.w?company_id=%@",[AppCacheData shareCachData].userMode.computer_id];
    [self gotoH5:url];
}

- (void)gotoH5:(NSString*)url {
    if([GotoRoute isLogin]) {
        return;
    }
    
    RootWebViewController *vc = [[RootWebViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@%@",NetH5Get,url]];
    [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
}

@end
