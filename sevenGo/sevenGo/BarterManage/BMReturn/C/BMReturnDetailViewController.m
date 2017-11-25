//
//  BMReturnDetailViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/11/24.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "BMReturnDetailViewController.h"
#import "PhotoTableViewCell.h"
#import "TitleContentTableViewCell.h"
#import "BMOrderTableViewCell.h"

@interface BMReturnDetailViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView      *tableView;
@end

#define ReusePhotoCell                     @"PhotoCell"
#define ReuseTitleContentCell              @"TitleContentCell"
#define ReuseBMOrderCell                   @"BMOrderCell"



@implementation BMReturnDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"退货管理";

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   CGRectGetWidth(self.view.frame),
                                                                   CGRectGetHeight(self.view.frame) - TOP_HEIGHT)
                                                  style:UITableViewStyleGrouped];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionHeaderHeight = 0.0001;
    self.tableView.sectionFooterHeight = 0.0001;
    [self.view addSubview:self.tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return [BMOrderTableViewCell getCellHeigt];
    }
    return Def_TableViewCellHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        TitleContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseTitleContentCell
                                                                          forIndexPath:indexPath];
        cell.txtContent.hidden = YES;
        return cell;
    } else if (indexPath.section == 1) {
        BMOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseBMOrderCell
                                                                     forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section == 2) {
        TitleContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseTitleContentCell
                                                                          forIndexPath:indexPath];
        cell.lblTitle.text = @"退款金额";
        cell.txtContent.userInteractionEnabled = NO;
        return cell;
    } else if (indexPath.section == 3) {
        TitleContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseTitleContentCell
                                                                          forIndexPath:indexPath];
        cell.txtContent.userInteractionEnabled = NO;
        cell.lblTitle.text = @"退货原因";
        return cell;
    } else if (indexPath.section == 4) {
        PhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReusePhotoCell
                                                                   forIndexPath:indexPath];
        cell.lblTitle.text = @"商品图";
        cell.readOnly = YES;
        return cell;
    }
    
    return [[UITableViewCell alloc] init];
}

@end
