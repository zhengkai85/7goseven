//
//  BMProductContainViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/11/20.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "BMProductContainViewController.h"
#import "BMProductListViewController.h"

@interface BMProductContainViewController ()

@end

@implementation BMProductContainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupData {
    
    self.title = @"产品管理";
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:6];
    
    [items addObject:@"竞拍中"];
    [self.viewControllers addObject:[[BMProductListViewController alloc] initWithState:ProductState_ing]];

    [items addObject:@"已结拍"];
    [self.viewControllers addObject:[[BMProductListViewController alloc] initWithState:ProductState_finish]];
    
    [items addObject:@"已流拍"];
    [self.viewControllers addObject:[[BMProductListViewController alloc] initWithState:ProductState_flow]];
    
    [items addObject:@"已失败"];
    [self.viewControllers addObject:[[BMProductListViewController alloc] initWithState:ProductState_fail]];
    
    [items addObject:@"待上架"];
    [self.viewControllers addObject:[[BMProductListViewController alloc] initWithState:ProductState_Up]];
    
    [items addObject:@"已下架"];
    [self.viewControllers addObject:[[BMProductListViewController alloc] initWithState:ProductState_Down]];


    self.arrItem = [[NSArray alloc] initWithArray:items];
    [self setupView];
    
    self.pagingHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kHeaderViewTop);
    self.pagingViewController.view.frame = CGRectMake(0,
                                                      self.pagingHeaderView.bottom,
                                                      SCREEN_WIDTH,
                                                      self.view.height - self.pagingHeaderView.bottom);

}
@end
