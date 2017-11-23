//
//  TopHomeViewController.m
//  sevenGo
//
//  Created by zhengkai on 17/9/5.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "TopHomeViewController.h"
#import "HomeViewMode.h"
#import "BannerTableViewCell.h"
#import "HeadlineTableViewCell.h"
#import "BidTableViewCell.h"
#import "DesignerTableViewCell.h"
#import "BrandTableViewCell.h"
#import "SCMTableViewCell.h"
#import "MarkTableViewCell.h"
#import "RecommendTableViewCell.h"
#import "GroupHeardView.h"

#import "WalletHomeViewController.h"
#import "AreaAddViewController.h"

@interface TopHomeViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HomeViewMode *viewMode;
@end


#define ReuseHomeTopBannerTableViewCell         @"BannerTableViewCell"
#define ReuseHomeHeadlineTableViewCell          @"HeadlineTableViewCell"
#define ReuseHomeBidTableViewCell               @"BidTableViewCell"
#define ReuseDesignerTableViewCell              @"DesignerTableViewCell"
#define ReuseBrandTableViewCell                 @"BrandTableViewCell"
#define ReuseScmTableViewCell                   @"ScmTableViewCell"
#define ReuseMarkTableViewCell                  @"MarkTableViewCell"
#define ReuseRecommendTableViewCell             @"RecommendTableViewCell"


typedef enum : NSUInteger {
    CellType_Banner = 0,
    CellType_Headline,
    CellType_Bid,
    CellType_Designer,
    CellType_Brand,
    CellType_Scm,
    CellType_Mark,
    CellType_Recommend
} CellType;


@implementation TopHomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (instancetype)init {
    if(!self) {
        self = [super init];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   SCREEN_WIDTH,
                                                                   SCREEN_HEIGHT - TAB_BAR_HEIGHT - STATUS_BAR_HEIGHT)
                                                  style:UITableViewStyleGrouped];
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
    RACSubject *subject = [RACSubject subject];
    [self.viewMode.refreshDataSignal subscribeError:^(NSError *error) {
        [subject sendError:error];
    } completed:^{
        [subject sendCompleted];
        [self.tableView reloadData];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WalletHomeViewController *vc = [[WalletHomeViewController alloc] init];
    [[GotoAppdelegate sharedAppDelegate] pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 7) {
        NSArray *arr =  self.viewMode.arrRecommend;
        return arr.count;
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
    } else if (indexPath.section == CellType_Bid) {
        BidTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseHomeBidTableViewCell
                                                                 forIndexPath:indexPath];
        [cell setViewMode:self.viewMode height:[self getHeightForRowAtIndexPath:indexPath]];
        return cell;
    } else if (indexPath.section == CellType_Designer) {
        DesignerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseDesignerTableViewCell
                                                                 forIndexPath:indexPath];
        [cell setViewMode:self.viewMode height:[self getHeightForRowAtIndexPath:indexPath]];
        return cell;
    } else if (indexPath.section == CellType_Brand) {
        BrandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseBrandTableViewCell
                                                                      forIndexPath:indexPath];
        [cell setViewMode:self.viewMode height:[self getHeightForRowAtIndexPath:indexPath]];
        return cell;
    } else if (indexPath.section == CellType_Scm) {
        SCMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseScmTableViewCell
                                                                   forIndexPath:indexPath];
        [cell setViewMode:self.viewMode height:[self getHeightForRowAtIndexPath:indexPath]];
        return cell;
    } else if (indexPath.section == CellType_Mark) {
        MarkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseMarkTableViewCell
                                                                 forIndexPath:indexPath];
        [cell setViewMode:self.viewMode height:[self getHeightForRowAtIndexPath:indexPath]];
        return cell;
    } else if (indexPath.section == CellType_Recommend) {
        RecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseRecommendTableViewCell
                                                                       forIndexPath:indexPath];
        [cell setViewMode:self.viewMode height:[self getHeightForRowAtIndexPath:indexPath] index:indexPath.row];
        return cell;
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
    HomeMode *mode;
    if(section == CellType_Bid) {
        mode = [dic objectForKey:HomeType_bid];
    } else if (section == CellType_Designer) {
        mode = [dic objectForKey:HomeType_designer];
    } else if (section == CellType_Brand) {
        mode = [dic objectForKey:HomeType_brand];
    } else if (section == CellType_Scm) {
        mode = [dic objectForKey:HomeType_scm];
    } else if (section == CellType_Mark) {
        mode = [dic objectForKey:HomeType_market];
    } else if (section == CellType_Recommend) {
        mode = [dic objectForKey:HomeType_recommend];
    }
    
    if(mode) {
        GroupHeardView *view = [[GroupHeardView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
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
    } else if(indexPath.section == CellType_Bid) {
        return SCREEN_WIDTH/750*580;
    } else  if(indexPath.section == CellType_Designer || indexPath.section == CellType_Scm) {
        return SCREEN_WIDTH/750*540;
    } else if (indexPath.section == CellType_Brand || indexPath.section == CellType_Mark || indexPath.section == CellType_Recommend) {
        return SCREEN_WIDTH/750*540;
    }
    return 0;
}


@end
