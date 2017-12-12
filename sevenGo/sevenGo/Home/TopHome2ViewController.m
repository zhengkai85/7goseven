//
//  TopHome2ViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/12/2.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "TopHome2ViewController.h"
#import "HomeViewMode.h"
#import "BannerTableViewCell.h"
#import "HeadlineTableViewCell.h"
#import "BidTableViewCell.h"
#import "DesignerTableViewCell.h"
#import "BrandTableViewCell.h"
#import "SCMTableViewCell.h"
#import "MarkTableViewCell.h"
#import "RecommendTableViewCell.h"
#import "AuctionTableViewCell.h"
#import "GroupHeardView.h"
#import "AuctionImgTableViewCell.h"

#import "WalletHomeViewController.h"
#import "AreaAddViewController.h"
#import "AppDelegate.h"

#import "AuctionMode.h"
#import "AuctionViewMode.h"
#import "RootWebViewController.h"

@interface TopHome2ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HomeViewMode *viewMode;
@property (nonatomic, strong) AuctionViewMode *auViewMode;
@end

#define ReuseHomeTopBannerTableViewCell         @"BannerTableViewCell"
#define ReuseHomeHeadlineTableViewCell          @"HeadlineTableViewCell"
#define ReuseHomeBidTableViewCell               @"BidTableViewCell"
#define ReuseDesignerTableViewCell              @"DesignerTableViewCell"
#define ReuseBrandTableViewCell                 @"BrandTableViewCell"
#define ReuseScmTableViewCell                   @"ScmTableViewCell"
#define ReuseMarkTableViewCell                  @"MarkTableViewCell"
#define ReuseRecommendTableViewCell             @"RecommendTableViewCell"
#define ReuseAuctionTableViewCell               @"AuctionTableViewCell"
#define ReuseBannerTableViewCell                @"BannerTableViewCell"
#define ReuseAuctionImgTableViewCell            @"AuctionImgTableViewCell"

typedef enum : NSUInteger {
    CellType_Banner = 0,
    CellType_Headline,
    CellType_Mode,
    CellType_Batch,
    CellType_Metting,
    CellType_Bid,
    CellType_Designer,
    CellType_Brand,
    CellType_Scm,
    CellType_Mark,
    CellType_Recommend
} CellType;

@implementation TopHome2ViewController

- (instancetype)init {
    if(!self) {
        self = [super init];
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   SCREEN_WIDTH,
                                                                   SCREEN_HEIGHT - TAB_BAR_HEIGHT)
                                                  style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[BannerTableViewCell class]
           forCellReuseIdentifier:ReuseHomeTopBannerTableViewCell];
    
    [self.tableView registerClass:[HeadlineTableViewCell class]
           forCellReuseIdentifier:ReuseHomeHeadlineTableViewCell];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AuctionTableViewCell" bundle:nil]
           forCellReuseIdentifier:ReuseAuctionTableViewCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AuctionImgTableViewCell" bundle:nil]
         forCellReuseIdentifier:ReuseAuctionImgTableViewCell];
    
    
    
    [self.tableView registerClass:[BidTableViewCell class]
           forCellReuseIdentifier:ReuseHomeBidTableViewCell];
    
    [self.tableView registerClass:[DesignerTableViewCell class]
           forCellReuseIdentifier:ReuseDesignerTableViewCell];
    
    [self.tableView registerClass:[BrandTableViewCell class]
           forCellReuseIdentifier:ReuseBrandTableViewCell];
    
    [self.tableView registerClass:[SCMTableViewCell class]
           forCellReuseIdentifier:ReuseScmTableViewCell];
    
    [self.tableView registerClass:[MarkTableViewCell class]
           forCellReuseIdentifier:ReuseMarkTableViewCell];
    
    [self.tableView registerClass:[RecommendTableViewCell class]
           forCellReuseIdentifier:ReuseRecommendTableViewCell];
    
    self.viewMode = [[HomeViewMode alloc] init];
    

    
    self.auViewMode = [[AuctionViewMode alloc] init];


}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == CellType_Metting) {
        NSArray *arr =  self.auViewMode.arrMetting;
        return arr.count;
    }
    
    if(section == CellType_Mode) {
        NSInteger count = self.auViewMode.arrMode.count;
        if(count < 3) {
            return 2;
        } else {
            return 3;
        }
    } else if (section == CellType_Batch) {
        NSInteger count = self.auViewMode.arrBatch.count;
        if(count < 3) {
            return 2;
        } else {
            return 3;
        }
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self getHeightForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == CellType_Banner) {
        BannerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseHomeTopBannerTableViewCell
                                                                    forIndexPath:indexPath];
        [cell setViewMode:self.viewMode height:[self getHeightForRowAtIndexPath:indexPath]];
        return cell;
    } else if (indexPath.section == CellType_Headline) {
        BannerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseHomeHeadlineTableViewCell
                                                                    forIndexPath:indexPath];
        [cell setViewMode:self.viewMode height:[self getHeightForRowAtIndexPath:indexPath]];
        return cell;
    } else if(indexPath.section == CellType_Mode) {
        if(indexPath.row == 0) {
            AuctionImgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseAuctionImgTableViewCell];
            [cell setViewMode:self.auViewMode type:0];
            return cell;
        } else {
            AuctionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseAuctionTableViewCell];
            [cell setViewMode:self.auViewMode row:indexPath.row-1 type:0];
            return cell;
        }
    } else if (indexPath.section == CellType_Batch) {
        if(indexPath.row == 0) {
            AuctionImgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseAuctionImgTableViewCell];
            [cell setViewMode:self.auViewMode type:1];
            return cell;
        } else {
            AuctionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseAuctionTableViewCell];
            [cell setViewMode:self.auViewMode row:indexPath.row-1 type:1];
            return cell;
        }
    } else if (indexPath.section == CellType_Metting) {
        RecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseRecommendTableViewCell
                                                                       forIndexPath:indexPath];
        [cell setViewMode:self.auViewMode height:[self getHeightForRowAtIndexPath:indexPath] index:indexPath.row];
    }
    return [UITableViewCell new];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section  {
    return [self getSecitonHeightInSection:section];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section == CellType_Banner || section == CellType_Headline) {
        return [[UIView alloc] init];
    }
    
    NSDictionary *dic = self.viewMode.dicHeard;
    CGFloat height = [self getSecitonHeightInSection:section];

    GroupHeardView *view = [[GroupHeardView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];

    HomeMode *mode;
    if(section == CellType_Mode) {
        mode = [dic objectForKey:HomeType_mode];
        [view setGotoDetailBlock:^{
            [AppDelegate sharedAppDelegate].tabBarController.selectedIndex = 1;
            RootWebViewController *vc = [[RootWebViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@%@",NetH5,@"/iQiGou/src/app/bid/modeBid.w"]];
            [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
        }];

    } else if (section == CellType_Batch) {
        mode = [dic objectForKey:HomeType_batch];
        [view setGotoDetailBlock:^{
            [AppDelegate sharedAppDelegate].tabBarController.selectedIndex = 1;
            RootWebViewController *vc = [[RootWebViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@%@",NetH5,@"/iQiGou/src/app/bid/batchBid.w"]];
            [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
            
        }];
    } else if (section == CellType_Metting) {
        mode = [dic objectForKey:HomeType_metting];
        [view setGotoDetailBlock:^{
            [AppDelegate sharedAppDelegate].tabBarController.selectedIndex = 1;
            RootWebViewController *vc = [[RootWebViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@%@",NetH5,@"/iQiGou/src/app/bid/paimaihui.w"]];
            [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
        }];

    }
//    if(section == CellType_Bid) {
//        mode = [dic objectForKey:HomeType_bid];
//        [view setGotoDetailBlock:^{
//            [AppDelegate sharedAppDelegate].tabBarController.selectedIndex = 1;
//        }];
//    } else if (section == CellType_Designer) {
//        mode = [dic objectForKey:HomeType_designer];
//        [view setGotoDetailBlock:^{
//            [AppDelegate sharedAppDelegate].tabBarController.selectedIndex = 2;
//            [self performBlock:^{
//                [[NSNotificationCenter defaultCenter] postNotificationName:Nofification_TopDesigner object:nil];
//            } afterDelay:0.5];
//
//        }];
//    } else if (section == CellType_Brand) {
//        mode = [dic objectForKey:HomeType_brand];
//    } else if (section == CellType_Scm) {
//        mode = [dic objectForKey:HomeType_scm];
//    } else if (section == CellType_Mark) {
//        mode = [dic objectForKey:HomeType_market];
//    } else if (section == CellType_Recommend) {
//        mode = [dic objectForKey:HomeType_recommend];
//    }
//
    if(mode) {
        [view setViewMode:mode height:height];
        return view;
    }
    
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat)getSecitonHeightInSection:(NSInteger)section {
    if(section == CellType_Banner || section == CellType_Headline) {
        return 0.0001;
    }
    return 70;
}

- (CGFloat)getHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == CellType_Banner) {
        return SCREEN_WIDTH/750*500;
    } else if(indexPath.section == CellType_Headline) {
        return SCREEN_WIDTH/750*90;
    } else if(indexPath.section == CellType_Mode || indexPath.section == CellType_Batch) {
        if(indexPath.row == 0) {
            return SCREEN_WIDTH/750*300;
        }
        return SCREEN_WIDTH/750*480;
    } else if (indexPath.section == CellType_Metting) {
        return SCREEN_WIDTH/750*540;
    }
    return 0;
}

@end
