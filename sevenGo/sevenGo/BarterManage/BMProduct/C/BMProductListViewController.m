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
#import "ControlTableViewCell.h"

@interface BMProductListViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign)NSInteger state;
@end

#define ReuseProductTableViewCell        @"ProductTableViewCell"
#define ReuseProductCTableViewCell       @"ProductCTableViewCell"

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
    return self.arrDataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BMProductObj *mode = self.arrDataSource[indexPath.section];
    if(indexPath.row == 0) {
        ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseProductTableViewCell];
        [cell drawWith:mode];
        return cell;
    } else if (indexPath.row == 1) {
        ControlTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseProductTableViewCell];
        
        [cell.btnRight1 setTitle:@"编辑" forState:UIControlStateNormal];
        cell.btnRight1.titleLabel.backgroundColor = COLOR_NAV;
        [cell.btnRight1 setRoundedBorder:COLOR_NAV];
        [cell setBtnR1ClickBLock:^{
            
        }];
        
        [cell.btnRight2 setTitle:@"上架" forState:UIControlStateNormal];
        [cell.btnRight2 setTitleColor:COLOR_DETAIL forState:UIControlStateNormal];
        [cell.btnRight2 setRoundedBorder:COLOR_DETAIL];
        [cell setBtnR2ClickBLock:^{
            
        }];
        
        [cell.btnRight3 setTitle:@"删除" forState:UIControlStateNormal];
        [cell.btnRight3 setTitleColor:COLOR_DETAIL forState:UIControlStateNormal];
        [cell.btnRight3 setRoundedBorder:COLOR_DETAIL];
        [cell setBtnR3ClickBLock:^{
            
        }];
        
        
        return cell;
    }
    

    return [UITableViewCell new];
}


@end
