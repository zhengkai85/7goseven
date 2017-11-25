//
//  BMOrderListViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/11/23.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "BMOrderListViewController.h"
#import "BMNet.h"
#import "BMOrderTableViewCell.h"
#import "BMOrderHearderTableViewCell.h"
#import "ControlTableViewCell.h"
#import "PubFunction.h"
#import "BMOrderObj.h"

@interface BMOrderListViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign)NSInteger state;
@end


#define ReuseBMHeardTableViewCell          @"BMOrderHearderTableViewCell"
#define ReuseBMOrderTableViewCell          @"BMOrderTableViewCell"
#define ReuseBMControlTableViewCell        @"BMControlTableViewCell"


@implementation BMOrderListViewController

- (instancetype)initWithState:(NSInteger)state {
    self = [super init];
    if(self) {
        self.state = state;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pageSize = 10;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BMOrderHearderTableViewCell" bundle:nil]
         forCellReuseIdentifier:ReuseBMHeardTableViewCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BMOrderTableViewCell" bundle:nil]
         forCellReuseIdentifier:ReuseBMOrderTableViewCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ControlTableViewCell" bundle:nil]
         forCellReuseIdentifier:ReuseBMControlTableViewCell];
    
    [self fillData];
}


- (void)fillData {
    self.pageNum = 1;
    [BMNet getBidOrderListState:self.state
                           page:self.pageNum
                          block:^(id posts, NSInteger code, NSString *errorMsg) {
                              [self.tableView.mj_header endRefreshing];
                              if(code == 200) {
                                  [self.arrDataSource removeAllObjects];
                                  NSArray *arr = posts[@"data"][@"list"];
                                  if(arr.count > 0) {
                                      for(NSDictionary *dic in arr) {
                                          [self.arrDataSource addObject:[BMOrderObj modelWithDictionary:dic]];
                                      }
                                      [self.tableView reloadData];
                                      if(arr.count < self.pageSize) {
                                          [self.tableView.mj_footer endRefreshingWithNoMoreData];
                                      } else {
                                          [self.tableView.mj_footer resetNoMoreData];
                                      }
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
    [BMNet getBidOrderListState:self.state
                           page:self.pageNum
                          block:^(id posts, NSInteger code, NSString *errorMsg) {
                              [self.tableView.mj_footer endRefreshing];
                              if(code == 200) {
                                  NSArray *arr = posts[@"data"][@"list"];
                                  if(arr.count > 0) {
                                      for(NSDictionary *dic in arr) {
                                          [self.arrDataSource addObject:[BMOrderObj modelWithDictionary:dic]];
                                      }
                                      [self.tableView reloadData];
                                      if(arr.count < self.pageSize) {
                                          [self.tableView.mj_footer endRefreshingWithNoMoreData];
                                      } else {
                                          [self.tableView.mj_footer resetNoMoreData];
                                      }                                  }
                              } else if (code == 400) {
                                  [self.tableView.mj_footer endRefreshingWithNoMoreData];
                              }
                              else {
                                  [self.tableView.mj_footer endRefreshingWithNoMoreData];
                                  [PubFunction showNetErrorLocalStr:@"获取失败" serverStr:errorMsg];
                              }
                          }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  self.arrDataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BMOrderObj *mode = self.arrDataSource[indexPath.section];

    if(indexPath.row == 0) {
        BMOrderHearderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseBMHeardTableViewCell
                                                                            forIndexPath:indexPath];
        [cell drawWithObj:mode];
        return cell;
    } else if (indexPath.row == 1) {
        BMOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseBMOrderTableViewCell
                                                                     forIndexPath:indexPath];
        [cell drawWithObj:mode];
        return cell;
    } else if (indexPath.row == 2) {
        ControlTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseBMControlTableViewCell
                                                                     forIndexPath:indexPath];
        cell.btnRight2.hidden = YES;
        cell.btnRight3.hidden = YES;
        [cell.btnRight1 setTitle:@"查看物流" forState:UIControlStateNormal];
        cell.btnRight1.titleLabel.backgroundColor = COLOR_NAV;
        [cell.btnRight1 setRoundedBorder:COLOR_NAV];
        [cell setBtnR1ClickBLock:^{
            
        }];
        return cell;
    }

    return [UITableViewCell new];
}

@end
