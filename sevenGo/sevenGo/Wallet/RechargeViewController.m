//
//  RechargeViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/10/23.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "RechargeViewController.h"
#import "TitleDetailTableViewCell.h"
#import "PayViewController.h"

@interface RechargeViewController ()
@property (nonatomic, assign) NSInteger selRow;
@property (nonatomic, strong) UITextField *txtInput;
@end

static NSString *strCellIdentifier = @"CellIdentifier";


@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"7币充值";
    [self.arrDataSource addObject:@{@"title" : @"100元",@"content" : @"送10个7币"}];
    [self.arrDataSource addObject:@{@"title" : @"300元",@"content" : @"送30个7币"}];
    [self.arrDataSource addObject:@{@"title" : @"500元",@"content" : @"送50个7币"}];
    [self.arrDataSource addObject:@{@"title" : @"1000元",@"content" : @"送100个7币"}];

    self.selRow = 2;
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.selRow inSection:0]
                                animated:YES
                          scrollPosition:UITableViewScrollPositionNone];
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleDetailTableViewCell"bundle:nil]
         forCellReuseIdentifier:strCellIdentifier];
    self.tableView.tableFooterView = [self footView];
}


- (UIView*)footView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIView *viewInput = [[UIView alloc] initWithFrame:CGRectMake(16, 8, SCREEN_WIDTH - 32, 40)];
    viewInput.backgroundColor = [UIColor whiteColor];
    [view addSubview:viewInput];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 20, 30)];
    lbl.centerY = viewInput.height/2;
    lbl.font = [UIFont systemFontOfSize:25];
    lbl.textColor= [UIColor blackColor];
    lbl.text = @"￥";
    [viewInput addSubview:lbl];
    
    self.txtInput = [[UITextField alloc] initWithFrame:CGRectMake(lbl.right + 10, 5, SCREEN_WIDTH - 120, 30)];
    self.txtInput.keyboardType = UIKeyboardTypeNumberPad;
    [viewInput addSubview:self.txtInput];
    
    UILabel *lblAbout = [[UILabel alloc] initWithFrame:CGRectMake(20, viewInput.bottom+ 10, 300, 13)];
    lblAbout.font = [UIFont systemFontOfSize:12];
    lblAbout.textColor = COLOR_DETAIL;
    lblAbout.text = @"注:手动输入充值金额不赠送7币";
    [view addSubview:lblAbout];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(16, lblAbout.bottom+30, SCREEN_WIDTH-32, 40)];
    btn.layer.cornerRadius = 16;
    [btn setTitle:@"下一步" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = COLOR_NAV;
    [btn addTarget:self action:@selector(doNext) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    return view;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TitleDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCellIdentifier];
    NSDictionary *dic = self.arrDataSource[indexPath.row];
    cell.lblTitle.text = [dic stringValue:@"title"];
    cell.lblDetail.text = [dic stringValue:@"content"];
    
    NSIndexPath *selectIndexPath = [self.tableView indexPathForSelectedRow];
    if(indexPath.row == selectIndexPath.row) {
        cell.lblTitle.textColor = [UIColor whiteColor];
        cell.lblDetail.textColor = [UIColor whiteColor];
        cell.backgroundColor = COLOR_NAV;
    } else {
        cell.lblTitle.textColor = COLOR_TEXT;
        cell.lblDetail.textColor = COLOR_DETAIL;
        cell.backgroundColor = [UIColor whiteColor];
    }

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    TitleDetailTableViewCell *lastCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selRow inSection:0]];
    lastCell.lblTitle.textColor = COLOR_TEXT;
    lastCell.lblDetail.textColor = COLOR_DETAIL;
    lastCell.backgroundColor = [UIColor whiteColor];

    self.selRow = indexPath.row;
    TitleDetailTableViewCell *selCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selRow inSection:0]];
    selCell.lblTitle.textColor = [UIColor whiteColor];
    selCell.lblDetail.textColor = [UIColor whiteColor];
    selCell.backgroundColor = COLOR_NAV;

}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 40)];
    lbl.font = [UIFont systemFontOfSize:14];
    lbl.textColor = COLOR_BLACK;
    lbl.text = @"充值金额";
    [view addSubview:lbl];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}


- (void)doNext {
    CGFloat moeny = 0;
    BOOL giveMoney = NO;
    if(self.txtInput.text.length > 0) {
        moeny = [self.txtInput.text floatValue];
    } else {
        moeny = 100;
        if(self.selRow == 0) {
            giveMoney = YES;
        } else if (self.selRow == 1) {
            moeny = 300;
        } else if (self.selRow == 2) {
            moeny = 500;
        } else if (self.selRow == 3) {
            moeny = 1000;
        }
    }
    
    PayViewController *vc = [[PayViewController alloc] init];
    [vc setMoney:moeny];
    [vc setGiveMoney:giveMoney];
    [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
}
@end
