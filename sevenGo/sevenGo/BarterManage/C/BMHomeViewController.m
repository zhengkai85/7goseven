//
//  BMHomeViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/11/20.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "BMHomeViewController.h"
#import "BMHomeMenuTableViewCell.h"
#import "TitleDetailTableViewCell.h"
#import "BMProductContainViewController.h"
#import "BMAddSelType.h"
#import "BMMoneyAboutViewController.h"
@interface BMHomeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView      *tableView;
@property (nonatomic, strong) NSArray   *arrDataSource;
@property (nonatomic, strong)  BMAddSelType *selType;
@end

#define ReuseBMMHomeMenuTableViewCell         @"BMHomeMenuTableViewCell"
#define ReuseTitleDetailTableViewCell         @"TitleDetailTableViewCell"

@implementation BMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"易货管理";
    self.arrDataSource = @[@"产品管理",@"退货管理",@"收支明细",@"余额提现",@"费率说明"];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   CGRectGetWidth(self.view.frame),
                                                                   CGRectGetHeight(self.view.frame))
                                                  style:UITableViewStyleGrouped];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionHeaderHeight = 0.0001;
    self.tableView.sectionFooterHeight = 0.0001;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleDetailTableViewCell" bundle:nil]
         forCellReuseIdentifier:ReuseTitleDetailTableViewCell];
    
    [self.tableView registerClass:[BMHomeMenuTableViewCell class]
           forCellReuseIdentifier:ReuseBMMHomeMenuTableViewCell];
    
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithImage:[YYImage imageNamed:@"areaAdd.png"]
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(addProduct)];
    
    self.navigationItem.rightBarButtonItem = barItem;
    
    self.selType = [[BMAddSelType alloc] initWithFrame:self.view.bounds];
    self.selType.hidden = YES;
    [self.view addSubview:self.selType];


}

- (void)addProduct {
    
    self.selType.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    @weakify(self);
    [self.selType setCloseBLock:^{
        @strongify(self);
        self.selType.hidden = YES;
        self.tabBarController.tabBar.hidden = NO;
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) {
        return 1;
    } else if (section == 1) {
        return self.arrDataSource.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0) {
        BMHomeMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseBMMHomeMenuTableViewCell forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section == 1) {
        TitleDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseTitleDetailTableViewCell forIndexPath:indexPath];
        NSString *menuName = self.arrDataSource[indexPath.row];
        cell.lblTitle.text = menuName;
        cell.lblDetail.text = @"";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        NSString *menuName = self.arrDataSource[indexPath.row];
        if([menuName isEqualToString:@"产品管理"]) {
            [[GotoAppdelegate sharedAppDelegate] pushViewController:[[BMProductContainViewController alloc] init]];
        } else if ([menuName isEqualToString:@"退货管理"]) {
            
        } else if ([menuName isEqualToString:@"收支明细"]) {
            
        } else if ([menuName isEqualToString:@"余额提现"]) {
            
        } else if ([menuName isEqualToString:@"费率说明"]) {
            [[GotoAppdelegate sharedAppDelegate] pushViewController:[[BMMoneyAboutViewController alloc] init]];
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        return [BMHomeMenuTableViewCell getCellHeight];
    } else if (indexPath.section == 1) {
        return 50;
    };
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

@end
