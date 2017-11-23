//
//  InvitationViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/11/3.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "InvitationViewController.h"
#import "TitleDetailTableViewCell.h"
#import "WalletNet.h"
#import "MJRefresh.h"
#import "UMengHelper.h"
#import "AppCacheData.h"

@interface InvitationViewController ()  <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)IBOutlet UILabel *lblTitle;
@property (nonatomic, strong)IBOutlet UITableView *tableView;
@property (nonatomic, strong)IBOutlet UIView *viewBackground;
@property (nonatomic, strong)NSMutableArray *arrDataSource;
@property (nonatomic, assign)NSInteger        pageNum;
@property (nonatomic, assign)NSInteger        pageSize;

@end



@implementation InvitationViewController

#define ReuseTableViewCell         @"TableViewCell"


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"邀请好友";
    [self.view insertSubview:self.viewBackground atIndex:0];
    self.viewBackground.layer.cornerRadius = 32;
    self.lblTitle.layer.cornerRadius = 16;
    self.lblTitle.clipsToBounds = YES;
    self.pageSize = 10;
    self.pageNum = 1;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionHeaderHeight = 0.0001;
    self.tableView.sectionFooterHeight = 0.0001;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.hidden = YES;
    self.arrDataSource = [[NSMutableArray alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleDetailTableViewCell"bundle:nil]
         forCellReuseIdentifier:ReuseTableViewCell];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                    refreshingAction:@selector(fillMoreData)];
    self.pageSize = 10;
    [self fillData];
    
}


- (void)fillData {
    self.pageNum = 1;
    [WalletNet friends_scorePage:self.pageNum
                           block:^(id posts, NSInteger code, NSString *errorMsg) {
                               if(code == 200) {
                                   NSDictionary *dic = (NSDictionary*)posts[@"data"];
                                   self.lblTitle.text = [NSString stringWithFormat:@"邀请获得奖励  已获得%@个7币",dic[@"total_score"]];
                                   NSArray *arr = dic[@"friends_list"];
                                   if(arr.count == 0) {
                                       self.tableView.hidden = YES;
                                   } else {
                                       self.tableView.hidden = NO;
                                       [self.arrDataSource addObjectsFromArray:arr];
                                       [self.tableView reloadData];
                                   }
                                   
                                   if(arr.count <  self.pageSize) {
                                       self.tableView.mj_footer.hidden = YES;
                                   }
                               } else {
                                   self.lblTitle.text = [NSString stringWithFormat:@"邀请获得奖励  已获得%@个7币",@"0"];

                               }
    }];
}

- (void)fillMoreData {
    self.pageNum ++;
    [WalletNet friends_scorePage:self.pageNum
                           block:^(id posts, NSInteger code, NSString *errorMsg) {
                               if(code == 200) {
                                   NSDictionary *dic = (NSDictionary*)posts[@"data"];
                                   NSArray *arr = dic[@"friends_list"];
                                   if(arr.count > 0) {
                                       [self.arrDataSource addObjectsFromArray:arr];
                                       [self.tableView reloadData];
                                   }
                                   if(arr.count < self.pageSize)
                                       self.tableView.mj_footer.hidden = YES;
                               }
                           }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doShare:(id)sender {

    [UMSocialUIManager removeAllCustomPlatformWithoutFilted];
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatTimeLine)]];
    [UMSocialUIManager addCustomPlatformWithoutFilted:UMSocialPlatformType_WechatSession
                                     withPlatformIcon:[YYImage imageNamed:@"weixin"]
                                     withPlatformName:@"微信"];

    [UMSocialUIManager addCustomPlatformWithoutFilted:UMSocialPlatformType_QQ
                                     withPlatformIcon:[YYImage imageNamed:@"qq"]
                                     withPlatformName:@"QQ"];

    [UMSocialUIManager addCustomPlatformWithoutFilted:UMSocialPlatformType_WechatTimeLine
                                     withPlatformIcon:[YYImage imageNamed:@"weixinQuan"]
                                     withPlatformName:@"朋友圈"];

    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        NSString *title = [NSString stringWithFormat:@"%@诚邀您加入7购往来-纺织服装全产业链服务平台",[AppCacheData shareCachData].userMode.nickname];
        NSString *des = @"7购往来，纺织服装全产业链服务平台，拥有商圈、易货、招聘、资讯4大功能分区，囊括了设计师工作室、品牌服饰、供应链、商场、经销商5大产业链核心板块，以精准匹配行业资源及在线交流服务为切入点，为纺织服饰行业提供更为广阔的发展与合作空间。";
        NSString *url = [NSString stringWithFormat:@"%@/7shopShare/index.html?login_method=webUrl&device=m&nickname=%@&uid=%@&imgUrl=%@",NetH5Get,
                         [AppCacheData shareCachData].userMode.nickname,[[AppCacheData shareCachData] getU_id],[AppCacheData shareCachData].userMode.avatar128];
        [UMengHelper shareWebPageToPlatformType:platformType
                                          title:title
                                          descr:des
                                            img:[AppCacheData shareCachData].userMode.avatar128
                                        linkUrl:url];
    }];
    
    

}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TitleDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseTableViewCell
                                                              forIndexPath:indexPath];
    
    cell.lblTitle.textColor = cell.lblDetail.textColor = RGBCOLOR(235, 87, 102);
    cell.lblTitle.font = cell.lblDetail.font = [UIFont systemFontOfSize:13];

    NSDictionary *dic = self.arrDataSource[indexPath.row];
    NSDictionary *dicUser = dic[@"user_data"];
    cell.lblTitle.text = [NSString stringWithFormat:@"邀请 %@",dicUser[@"mobile"]];
    cell.lblDetail.text = [NSString stringWithFormat:@"%@个7币",dic[@"score"]];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrDataSource.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}


@end
