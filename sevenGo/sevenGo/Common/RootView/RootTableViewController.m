//
//  RootTableViewController.m
//  MyBaseView
//
//  Created by zhengkai on 16/10/26.
//  Copyright © 2016年 zhengkai. All rights reserved.
//

#import "RootTableViewController.h"
#import "UIControl+BlocksKit.h"

@interface RootTableViewController ()
@property (nonatomic, assign) BOOL haveModeData;
@end

@implementation RootTableViewController

static NSString *strCellIdentifier = @"CellIdentifier";

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arrDataSource = [[NSMutableArray alloc] init];
        self.haveModeData = NO;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   CGRectGetWidth(self.view.frame),
                                                                   CGRectGetHeight(self.view.frame))
                                                  style:UITableViewStyleGrouped];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionHeaderHeight = 0.0001;
    self.tableView.sectionFooterHeight = 0.0001;
    [self.view addSubview:self.tableView];
        
//    [self.tableView registerNib:[UINib nibWithNibName:@"xxxxxCell" bundle:nil] forCellReuseIdentifier:kCellIdentify];
//    [self.tableView registerClass:[xxxxxCell class] forCellReuseIdentifier:kCellIdentify];
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:strCellIdentifier];
    self.pageSize = 10;
}

- (void)addHeardView {
    UIView *heardView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 100)];
    self.tableView.tableHeaderView = heardView;
}

- (void)addFootView {
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 100)];
    self.tableView.tableFooterView = footView;
}

- (void)addFootView:(NSString*)title
              click:(void(^)(void))click {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    view.backgroundColor =[UIColor clearColor];
    UIButton *btnFoot = [UIButton buttonWithType:UIButtonTypeSystem];
    btnFoot.layer.cornerRadius = 16.0;
    btnFoot.frame = CGRectMake(0, 25, SCREEN_WIDTH - 16, 35);
    btnFoot.centerX = view.centerX;
    [btnFoot setTitle:title forState:UIControlStateNormal];
    btnFoot.titleLabel.font = [UIFont systemFontOfSize:16];
    [btnFoot setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFoot setBackgroundColor:COLOR_NAV];
    [btnFoot bk_addEventHandler:^(id sender) {
        if(click) {
            click();
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:btnFoot];
    self.tableView.tableFooterView = view;
}

- (void)addHeaderLoad {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                                refreshingAction:@selector(fillData)];
}

- (void)addFootLoad {
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                    refreshingAction:@selector(fillMoreData)];
    self.haveModeData = YES;
    self.pageSize = PageSize;
}

- (void)endRefreshingHeard {
    [self.tableView.mj_header endRefreshing];
}

- (void)endRefreshingFoot {
    [self.tableView.mj_footer endRefreshing];
}



- (void)fillData {
}


- (void)fillMoreData {
}


- (void)beginFillData {
    self.pageNum = 1;
}



- (void)endFillData:(NSArray*)arr {
    
    [self.arrDataSource removeAllObjects];
    [self.arrDataSource addObjectsFromArray:arr];
    [self.tableView reloadData];
    if(self.tableView.mj_footer) {
        if(self.arrDataSource.count < self.pageSize*self.pageNum) {
            self.tableView.mj_footer = nil;
        }
    } else {
        if(self.haveModeData) {
            [self addFootLoad];
        }
    }
}

- (void)beginFillMoreData {
    self.pageNum ++;
}


- (void)endFillMoreData:(NSArray*)arr {
    
    [self.arrDataSource addObjectsFromArray:arr];
    [self.tableView reloadData];

    if(self.arrDataSource.count < self.pageSize*self.pageNum) {
        self.pageNum --;
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.tableView.mj_footer endRefreshing];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrDataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *CellWithIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier forIndexPath:indexPath];
//    return cell;
    
//    static NSString *CellWithIdentifier = @"Cell";
//    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
//    if (!cell) {
//        cell = [[FeedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
//    }
    
    return [[UITableViewCell alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}


- (void)scrollToBottom {
    CGFloat yOffset = 0; //设置要滚动的位置 0最顶部 CGFLOAT_MAX最底部
    if (self.tableView.contentSize.height > self.tableView.bounds.size.height) {
        yOffset = self.tableView.contentSize.height - self.tableView.bounds.size.height;
    }
    [self.tableView setContentOffset:CGPointMake(0, yOffset) animated:NO];
}

@end

/*  
 自动cell高度
 
 #import "UITableView+FDTemplateLayoutCell.h"

  - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 EntPublicShowDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
 forIndexPath:indexPath ];
 cell.selectionStyle = UITableViewCellSelectionStyleNone;
 NSDictionary *dic = self.dataSoruce[indexPath.row];
 [cell setCellValue:dic];
 return cell;
 }
 
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
 return [tableView fd_heightForCellWithIdentifier:cellIdentifier
 cacheByKey:indexPath
 configuration:^(EntPublicShowDetailTableViewCell *cell) {
 NSDictionary *dic = self.dataSoruce[indexPath.row];
 [cell setCellValue:dic];
 }];
 
 }
 
 cell.fd_enforceFrameLayout = YES; // Enable to use "-sizeThatFits:"
 
 @property (nonatomic, weak) IBOutlet NSLayoutConstraint *imgHeightConstraint;

*/


