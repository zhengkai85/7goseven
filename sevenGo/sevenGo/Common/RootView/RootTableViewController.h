//
//  BaseTableViewController.h
//  MyBaseView
//
//  Created by zhengkai on 16/10/26.
//  Copyright © 2016年 zhengkai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "MJRefresh.h"

@interface RootTableViewController : RootViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView      *tableView;
@property (nonatomic, strong) NSMutableArray   *arrDataSource;
@property (nonatomic, assign) NSInteger        pageNum;
@property (nonatomic, assign) NSInteger        pageSize;

- (void)addHeardView;
- (void)addFootView;
- (void)addFootView:(NSString*)title
              click:(void(^)(void))click;

- (void)addHeaderLoad;
- (void)addFootLoad;

- (void)endRefreshingHeard;
- (void)endRefreshingFoot;

- (void)fillData;
- (void)fillMoreData;

- (void)beginFillData;
- (void)endFillData:(NSArray*)arr;

- (void)beginFillMoreData;
- (void)endFillMoreData:(NSArray*)arr;

@end
