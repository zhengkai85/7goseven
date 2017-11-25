//
//  BMOrderContainViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/11/23.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "BMOrderContainViewController.h"
#import "BMOrderListViewController.h"

@interface BMOrderContainViewController ()

@end

@implementation BMOrderContainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"产品管理";
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:6];
    
    [items addObject:@"全部"];
    [self.viewControllers addObject:[[BMOrderListViewController alloc] initWithState:1]];
    
    [items addObject:@"待付款"];
    [self.viewControllers addObject:[[BMOrderListViewController alloc] initWithState:2]];
    
    [items addObject:@"待发货"];
    [self.viewControllers addObject:[[BMOrderListViewController alloc] initWithState:3]];
    
    [items addObject:@"待收货"];
    [self.viewControllers addObject:[[BMOrderListViewController alloc] initWithState:4]];
    
    [items addObject:@"已完成"];
    [self.viewControllers addObject:[[BMOrderListViewController alloc] initWithState:5]];
    

    
    
    self.arrItem = [[NSArray alloc] initWithArray:items];
    [self setupView];
    
    self.pagingHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kHeaderViewTop);
    self.pagingViewController.view.frame = CGRectMake(0,
                                                      self.pagingHeaderView.bottom,
                                                      SCREEN_WIDTH,
                                                      self.view.height - self.pagingHeaderView.bottom);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
