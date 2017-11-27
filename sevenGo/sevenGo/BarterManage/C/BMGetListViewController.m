//
//  BMGetListViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/11/27.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "BMGetListViewController.h"

@interface BMGetListViewController ()

@end

@implementation BMGetListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self fillData];
    [self addFootLoad];
    
}

- (void)fillData {
}


- (void)fillMoreData {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrDataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
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


@end
