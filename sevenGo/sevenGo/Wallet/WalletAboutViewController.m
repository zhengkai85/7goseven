//
//  WalletAboutViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/11/2.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "WalletAboutViewController.h"
#import "RechargeViewController.h"
#import "InvitationViewController.h"

@interface WalletAboutViewController ()
@property (nonatomic, strong)IBOutlet UILabel *lblTitle1;
@property (nonatomic, strong)IBOutlet UILabel *lblContent1;
@property (nonatomic, strong)IBOutlet UILabel *lblTitle2;
@property (nonatomic, strong)IBOutlet UILabel *lblContent2;
@property (nonatomic, strong)IBOutlet UILabel *lblTitle3;
@property (nonatomic, strong)IBOutlet UILabel *lblContent3;
@property (nonatomic, strong)IBOutlet UILabel *lblContentA;
@property (nonatomic, strong)IBOutlet UILabel *lblContentB;
@property (nonatomic, strong)IBOutlet UILabel *lblContentC;
@property (nonatomic, strong)IBOutlet UILabel *lblTitle4;
@property (nonatomic, strong)IBOutlet UILabel *lblContent4;
@property (nonatomic, strong)IBOutlet UIButton *btnInvitation;
@property (nonatomic, strong)IBOutlet UIButton *btnRecharge;


@end

@implementation WalletAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.lblTitle1.font = self.lblTitle2.font = self.lblTitle3.font = self.lblTitle4.font = self.lblContent1.font = self.lblContent2.font = self.lblContent3.font = self.lblContent4.font = self.lblContentA.font = self.lblContentB.font = self.lblContentC.font = [UIFont systemFontOfSize:16];
    self.lblTitle1.textColor = self.lblTitle2.textColor = self.lblTitle3.textColor = self.lblTitle4.textColor = COLOR_TEXT;
    self.lblContent1.textColor = self.lblContent2.textColor = self.lblContent3.textColor = self.lblContent4.textColor = self.lblContentA.textColor = self.lblContentB.textColor = COLOR_DETAIL;
    
    
    self.title = @"什么是7币";
    self.lblTitle1.text = @"1. “7币”是什么？";
    self.lblContent1.text = @"“7币”是7购往来全新推出的虚拟货币，1个7币=1元人民币。";
    self.lblTitle2.text = @"2. “7币”可以做什么呢？";
    self.lblContent2.text = @"“7币”可以用来参与7购往来APP 的功能服务以及7购易货的 交易与拍卖，也可以来兑换我们的各种精彩活动哦";
    self.lblTitle3.text = @"3. 怎样获得 “7币”呢？";
    self.lblContent3.text = @"通过以下几种渠道可以获得7币：";
    self.lblContentA.text = @"A、邀请好友注册可获得7币";
    self.lblContentB.text = @"B、通过充值快速获得7币";
    self.lblContentC.text = @"C、系统赠予";
    self.lblTitle4.text = @"4. “7币”可以兑换成人民币吗？";
    self.lblContent4.text = @"“7币”是7购往来平台使用的虚拟货币，不支持兑换成人民币。";
    
    self.btnRecharge.layer.cornerRadius = self.btnInvitation.layer.cornerRadius = 16.0;
    self.btnRecharge.backgroundColor = self.btnInvitation.backgroundColor = COLOR_NAV;
}


- (IBAction)doInvitaion:(id)sender {
    InvitationViewController *vc = [[InvitationViewController alloc] init];
    [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
}

- (IBAction)doRecharge:(id)sender {
    RechargeViewController *vc = [[RechargeViewController alloc] init];
    [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
}

@end
