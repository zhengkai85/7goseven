//
//  WalletHomeViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/10/20.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "WalletHomeViewController.h"
#import "WalletHomeTableViewCell.h"
#import "MJRefresh.h"
#import "WalletNet.h"
#import "PubFunction.h"
#import "RechargeViewController.h"
#import "WalletAboutViewController.h"

@interface WalletHomeViewController () <UITableViewDataSource, UITableViewDelegate>
@end

#define ReuseIdentifier  @"WalletHomeTableViewCell"

@implementation WalletHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的钱包";
    
    UIView *heard = [self getTopView];
    [self.view addSubview:heard];
    self.tableView.frame = CGRectMake(0, heard.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-heard.bottom - STATUS_BAR_HEIGHT);
    self.tableView.rowHeight = 70;
    self.tableView.sectionHeaderHeight = 0.001;
    self.tableView.sectionFooterHeight = 0.001;
    [self addHeaderLoad];
    [self addFootLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:ReuseIdentifier bundle:nil]
         forCellReuseIdentifier:ReuseIdentifier];
    
    [self fillData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(fillData)
                                                 name:Nofification_PaySucess
                                               object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)fillData {
    self.pageNum = 1;
    [WalletNet getScorelogListPage:self.pageNum
                             block:^(id posts, NSInteger code, NSString *errorMsg) {
                                 [self.tableView.mj_header endRefreshing];
                                 if(code == 200) {
                                     [self.arrDataSource removeAllObjects];
                                     NSArray *arr = posts[@"data"][@"list"];
                                     if(arr.count > 0) {
                                         [self.arrDataSource addObjectsFromArray:arr];
                                         [self.tableView reloadData];
                                         [self.tableView.mj_footer resetNoMoreData];
                                     }
                                 } else if (code == 400) {
                                     [self.tableView.mj_footer endRefreshingWithNoMoreData];
                                 } else {
                                     [self.tableView.mj_footer endRefreshingWithNoMoreData];
                                     [PubFunction showNetErrorLocalStr:@"获取失败" serverStr:errorMsg];
                                 }
                             }];
}

- (void)fillMoreData {
    self.pageNum ++;
    [WalletNet getwalletListPage:self.pageNum
                           block:^(id posts, NSInteger code, NSString *errorMsg) {
                               [WalletNet getScorelogListPage:self.pageNum
                                                        block:^(id posts, NSInteger code, NSString *errorMsg) {
                                                            [self.tableView.mj_footer endRefreshing];
                                                            if(code == 200) {
                                                                NSArray *arr = posts[@"data"][@"list"];
                                                                if(arr.count > 0) {
                                                                    [self.arrDataSource addObjectsFromArray:arr];
                                                                    [self.tableView reloadData];
                                                                    [self.tableView.mj_footer resetNoMoreData];
                                                                }
                                                            } else if (code == 400) {
                                                                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                                                            }
                                                            else {
                                                                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                                                                [PubFunction showNetErrorLocalStr:@"获取失败" serverStr:errorMsg];
                                                            }
                                                        }];
                           }];
}


- (UIView*)getTopView {
    
    UIView *viewTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/75*40 + 30)];
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/75*40)];
    img.image = [YYImage imageNamed:@"wallet_background"];
    [viewTop addSubview:img];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 15)];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.font = [UIFont systemFontOfSize:12];
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.text = @"我的7币";
    [viewTop addSubview:lblTitle];
    
    UILabel *lblContent = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 30)];
    lblContent.centerY = viewTop.height/2;
    lblContent.textAlignment = NSTextAlignmentCenter;
    lblContent.font = [UIFont systemFontOfSize:42];
    lblContent.textColor = [UIColor whiteColor];
    lblContent.text = @"0";
    [viewTop addSubview:lblContent];
    
    UIButton *btnAdd = [[UIButton alloc] initWithFrame:CGRectMake(0, viewTop.height - 80, 50, 30)];
    btnAdd.centerX = SCREEN_WIDTH/4;
    [btnAdd setTitle:@"充值" forState:UIControlStateNormal];
    btnAdd.titleLabel.font = [UIFont systemFontOfSize:14];
    btnAdd.titleLabel.textColor = [UIColor whiteColor];
    btnAdd.layer.cornerRadius = 16;
    btnAdd.layer.borderWidth = 1.0;
    btnAdd.layer.borderColor = [UIColor whiteColor].CGColor;
    [viewTop addSubview:btnAdd];
    [btnAdd addTarget:self action:@selector(doAdd) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnAbout= [[UIButton alloc] initWithFrame:CGRectMake(0, viewTop.height - 80, 90, 30)];
    btnAbout.centerX = SCREEN_WIDTH - SCREEN_WIDTH/4;
    [btnAbout setTitle:@"什么是7币" forState:UIControlStateNormal];
    btnAbout.titleLabel.font = [UIFont systemFontOfSize:12];
    btnAbout.titleLabel.textColor = [UIColor whiteColor];
    btnAbout.layer.cornerRadius = 16;
    btnAbout.layer.borderWidth = 1.0;
    btnAbout.layer.borderColor = [UIColor whiteColor].CGColor;
    [btnAbout addTarget:self action:@selector(doAbout) forControlEvents:UIControlEventTouchUpInside];
    [viewTop addSubview:btnAbout];
    
    UILabel *lblAbuout = [[UILabel alloc] initWithFrame:CGRectMake(16, img.bottom, 200, 30)];
    lblAbuout.textColor = COLOR_TEXT;
    lblAbuout.font = [UIFont systemFontOfSize:14];
    lblAbuout.text = @"7币记录";
    [viewTop addSubview:lblAbuout];
    viewTop.backgroundColor = [UIColor whiteColor];
    return viewTop;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WalletHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    [cell setValue:self.arrDataSource[indexPath.row]];
    return cell;
}

- (void)doAdd {
    RechargeViewController *vc = [[RechargeViewController alloc] init];
    [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
}

- (void)doAbout {
    WalletAboutViewController *vc = [[WalletAboutViewController alloc] init];
    [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
}
@end
