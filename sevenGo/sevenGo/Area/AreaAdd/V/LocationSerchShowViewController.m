//
//  LocationSerchShowViewController.m
//  TIMChat
//
//  Created by zhengkai on 16/12/27.
//  Copyright © 2016年 AlexiChen. All rights reserved.
//

#import "LocationSerchShowViewController.h"
#import "LocationDemoViewController.h"

@interface LocationSerchShowViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LocationSerchShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TOP_HEIGHT)
                                                  style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellWithIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    BMKPoiInfo *poiInfo = self.resultsArray[indexPath.row];
    cell.textLabel.text = poiInfo.name;
    cell.detailTextLabel.text = poiInfo.address;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BMKPoiInfo *poiInfo = self.resultsArray[indexPath.row];
    if(self.sendLocation) {
        self.sendLocation(poiInfo);
    }
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
