//
//  BMProductListViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/11/20.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "BMProductListViewController.h"
#import "ProductTableViewCell.h"
#import "BMNet.h"
#import "PubFunction.h"
#import "BMProductObj.h"

@interface BMProductListViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign)NSInteger state;
@end

#define ReuseProductTableViewCell        @"ProductTableViewCell"


@implementation BMProductListViewController

- (instancetype)initWithState:(ProductState)state {
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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ProductTableViewCell" bundle:nil]
         forCellReuseIdentifier:ReuseProductTableViewCell];

    [self fillData];
}


- (void)fillData {
    self.pageNum = 1;
    [BMNet getBidGoodsListState:self.state
                           page:self.pageNum
                          block:^(id posts, NSInteger code, NSString *errorMsg) {
                              [self.tableView.mj_header endRefreshing];
                              if(code == 200) {
                                  [self.arrDataSource removeAllObjects];
                                  NSArray *arr = posts[@"data"][@"list"];
                                  if(arr.count > 0) {
                                      for(NSDictionary *dic in arr) {
                                          [self.arrDataSource addObject:[BMProductObj modelWithDictionary:dic]];
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
    [BMNet getBidGoodsListState:self.state
                           page:self.pageNum
                          block:^(id posts, NSInteger code, NSString *errorMsg) {
                              [self.tableView.mj_footer endRefreshing];
                              if(code == 200) {
                                  NSArray *arr = posts[@"data"][@"list"];
                                  if(arr.count > 0) {
                                      for(NSDictionary *dic in arr) {
                                          [self.arrDataSource addObject:[BMProductObj modelWithDictionary:dic]];
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




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseProductTableViewCell
                                                                 forIndexPath:indexPath];
    BMProductObj *mode = self.arrDataSource[indexPath.row];
    [cell drawWith:mode];
    return cell;
}


@end
