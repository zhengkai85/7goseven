//
//  MyLevelUpTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 2017/11/7.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "MyLevelUpTableViewCell.h"
#import "BlocksKit+UIKit.h"
#import "ReactiveCocoa.h"
#import "AppCacheData.h"
#import "GotoRoute.h"
#import "RootWebViewController.h"

@interface MyLevelUpTableViewCell()
@property (nonatomic, strong) IBOutlet UILabel *lblLTitle;
@property (nonatomic, strong) IBOutlet UILabel *lblLContent;
@property (nonatomic, strong) IBOutlet UILabel *lblRTitle;
@property (nonatomic, strong) IBOutlet UILabel *lblRContent;
@end

@implementation MyLevelUpTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lblLTitle.textColor = self.lblRTitle.textColor = COLOR_BLACK;
    self.lblLContent.textColor = self.lblRContent.textColor = COLOR_DETAIL;
    self.lblLTitle.text = @"开通VIP会员";
    self.lblLContent.text = @"享受超多VIP专属权益";
    self.lblRTitle.text = @"开通企业会员";
    self.lblRContent.text = @"享受超多企业专属权益";
    
    [RACObserve([AppCacheData shareCachData], userMode) subscribeNext:^(id x) {
        UserViewMode *mode = (UserViewMode *)x;
        if(mode) {
            if([mode.role_id isEqualToString:@"1"]) {
                self.lblLTitle.text = @"开通VIP会员";
                self.lblRTitle.text = @"开通企业会员";
            } else if ([mode.role_id isEqualToString:@"2"]) {
                self.lblLTitle.text = @"续费";
                self.lblRTitle.text = @"升级到企业VIP";
            } else if ([mode.role_id isEqualToString:@"3"]) {
                self.lblLTitle.text = @"续费";
                self.lblRTitle.text = @"续费";
            }
        }
    }];

    @weakify(self);
    self.lblLTitle.userInteractionEnabled = YES;
    [self.lblLTitle bk_whenTapped:^{
        @strongify(self);
        [self clickLeft];
    }];
    
    self.lblLContent.userInteractionEnabled = YES;
    [self.lblLContent bk_whenTapped:^{
        @strongify(self);
        [self clickLeft];
    }];
    
    self.lblRTitle.userInteractionEnabled = YES;
    [self.lblRTitle bk_whenTapped:^{
        @strongify(self);
        [self clickRight];
    }];
    
    self.lblRContent.userInteractionEnabled = YES;
    [self.lblRContent bk_whenTapped:^{
        @strongify(self);
        [self clickRight];
    }];
    
    
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2,
                                                                [MyLevelUpTableViewCell getCellHeight]/4,
                                                                1,
                                                                [MyLevelUpTableViewCell getCellHeight]/2)];
    viewLine.backgroundColor = COLOR_LINECOLOR;
    [self.contentView addSubview:viewLine];
    
}

- (void)clickLeft {
    
    if([GotoRoute isLogin]) {
        return;
    }
    
    UserViewMode *mode = [AppCacheData shareCachData].userMode;
    if([mode.role_id isEqualToString:@"1"]) {
        RootWebViewController *vc = [[RootWebViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@%@",NetH5,@"/iQiGou/src/app/commercialArea/upgradeVip.w"]];
        [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
    } else if ([mode.role_id isEqualToString:@"2"]) {
        RootWebViewController *vc = [[RootWebViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@%@",NetH5,@"/iQiGou/src/app/commercialArea/Vip_S_Item.w?data=2"]];
        [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
    } else if ([mode.role_id isEqualToString:@"3"]) {
        RootWebViewController *vc = [[RootWebViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@%@",NetH5,@"/iQiGou/src/app/commercialArea/Vip_S_Item.w?data=3"]];
        [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
    }}

- (void)clickRight {
    
    if([GotoRoute isLogin]) {
        return;
    }
    
    UserViewMode *mode = [AppCacheData shareCachData].userMode;
    if([mode.role_id isEqualToString:@"1"]) {
        RootWebViewController *vc = [[RootWebViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@%@",NetH5Get,@"/iQiGou/src/app/commercialArea/upgradeVip.w"]];
        [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
    } else if ([mode.role_id isEqualToString:@"2"]) {
        RootWebViewController *vc = [[RootWebViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@%@",NetH5Get,@"/iQiGou/src/app/commercialArea/Vip_S_Item.w?data=3"]];
        [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
    } else if ([mode.role_id isEqualToString:@"3"]) {
        RootWebViewController *vc = [[RootWebViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@%@",NetH5Get,@"/iQiGou/src/app/commercialArea/Vip_S_Item.w?data=3"]];
        [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
    }
}

+ (CGFloat)getCellHeight {
    return 75;
}
@end
