//
//  BMReturnContainViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/11/23.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "BMReturnContainViewController.h"
#import "BMReturnListViewController.h"

@interface BMReturnContainViewController ()

@end

@implementation BMReturnContainViewController

- (void)setupData {
    
    self.title = @"退货管理";
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:2];
    
    [items addObject:@"处理中"];
    [self.viewControllers addObject:[[BMReturnListViewController alloc] init]];
    
    [items addObject:@"已处理"];
    [self.viewControllers addObject:[[BMReturnListViewController alloc] init]];
    
    
    self.arrItem = [[NSArray alloc] initWithArray:items];
    [self setupView];
    
    self.pagingHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kHeaderViewTop);
    self.pagingViewController.view.frame = CGRectMake(0,
                                                      self.pagingHeaderView.bottom,
                                                      SCREEN_WIDTH,
                                                      self.view.height - self.pagingHeaderView.bottom);
    
}

@end
