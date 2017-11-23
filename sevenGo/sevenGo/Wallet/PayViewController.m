//
//  PayViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/10/23.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "PayViewController.h"
#import "TitleDetailTableViewCell.h"
#import "PaySelTableViewCell.h"
#import "WalletNet.h"

//支付
//#import "WXApiObject.h"
//#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "LCProgressHUD.h"

@interface PayViewController ()
@property (nonatomic,assign) CGFloat money;
@property (nonatomic,assign) BOOL giveMoney;
@property (nonatomic, assign) NSInteger selRow;

@end

static NSString *strCellIdentifierMoney = @"CellIdentifierMoney";
static NSString *strCellIdentifierPay = @"CellIdentifierPay";

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"收银台";
    
    @weakify(self);
    [self addFootView:@"去支付" click:^{
        @strongify(self);
        if(self.selRow == 0) {
            [self wxPay];
        } else if (self.selRow == 1) {
            [self aliPay];

        }
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleDetailTableViewCell"bundle:nil]
         forCellReuseIdentifier:strCellIdentifierMoney];
    [self.tableView registerNib:[UINib nibWithNibName:@"PaySelTableViewCell"bundle:nil]
         forCellReuseIdentifier:strCellIdentifierPay];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) {
        return 1;
    } else if (section == 1) {
        return 2;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0) {
        TitleDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCellIdentifierMoney];
        cell.lblTitle.text = @"订单金额";
        cell.lblDetail.text = [NSString stringWithFormat:@"%f",self.money];
        cell.lblDetail.textColor = COLOR_NAV;
        cell.lblDetail.text = [NSString stringWithFormat:@"￥%.1f",self.money];
        return cell;

    } else if(indexPath.section == 1) {
        PaySelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCellIdentifierPay];
        if(indexPath.row == 0) {
            cell.lblTitle.text = @"微信支付";
            cell.imgIocn.image = [YYImage imageNamed:@"weixin"];
        } else if (indexPath.row == 1) {
            cell.lblTitle.text = @"支付宝支付";
            cell.imgIocn.image = [YYImage imageNamed:@"pay_zfb"];
        }
        
        if(indexPath.row == self.selRow) {
            cell.imgSel.image = [YYImage imageNamed:@"pay_sel"];
        } else {
            cell.imgSel.image = [YYImage imageNamed:@"pay_unSel"];
        }

        return cell;
    }
    
    return [[UITableViewCell alloc] init];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selRow = indexPath.row;
    [self.tableView reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

- (void)aliPay {
    [WalletNet wallet_orderHas_gift:self.giveMoney
                             amount:self.money
                            channel:@"alipay"
                              block:^(id posts, NSInteger code, NSString *errorMsg) {

                                  NSDictionary *data = posts[@"data"];
                                  [[AlipaySDK defaultService] payOrder:[data stringValue:@"alipay"]
                                                            fromScheme:@"Alipay7Go"
                                                              callback:^(NSDictionary *resultDic) {
                                                                  [LCProgressHUD showMessage:resultDic[@"memo"]];
                                                                  if([[resultDic stringValue:@"resultStatus"] integerValue] == 9000) {
                                                                      [self paySucess];
                                                                  }
                                  }];
                              }];
}

- (void)wxPay {
//    [WalletNet wallet_orderHas_gift:self.giveMoney
//                             amount:self.money
//                            channel:@"wxpay"
//                              block:^(id posts, NSInteger code, NSString *errorMsg) {
//                                  NSDictionary *dic ;
//                                  
//                                  [WXApi registerApp:dic[@"appid"]];
//                                  PayReq *request = [[PayReq alloc] init];
//                                  request.partnerId = dic[@"partnerid"];
//                                  request.prepayId= dic[@"prepayid"];
//                                  request.package = dic[@"package"];
//                                  request.nonceStr= dic[@"noncestr"];
//                                  request.timeStamp = [dic[@"timestamp"] intValue];
//                                  request.sign= dic[@"sign"];
//                                  [WXApi sendReq:request];
//                              }];
}

- (void)paySucess {
    [[NSNotificationCenter defaultCenter] postNotificationName:Nofification_PaySucess object:nil];
    NSMutableArray*tempMarr = [NSMutableArray arrayWithArray:[GotoAppdelegate sharedAppDelegate].navigationViewController.viewControllers];
    [tempMarr removeLastObject];
    [tempMarr removeLastObject];
    [self.navigationController setViewControllers:tempMarr animated:YES];
}

@end
