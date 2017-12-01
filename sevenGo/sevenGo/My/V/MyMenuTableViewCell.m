//
//  MyMenuTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 2017/11/7.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "MyMenuTableViewCell.h"
#import "RootWebViewController.h"
#import "GotoRoute.h"
#import "WalletHomeViewController.h"
#import "ReactiveCocoa.h"
#import "AppCacheData.h"
#import "BMHomeViewController.h"

@implementation MyMenuTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIButton *btnMenu1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 100)];
        btnMenu1.centerX = SCREEN_WIDTH/8;
        btnMenu1.centerY = [MyMenuTableViewCell getCellHeight]/2 + 10;
        [self.contentView addSubview:btnMenu1];

        UIView *viewLine1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, [MyMenuTableViewCell getCellHeight]/2)];
        viewLine1.centerX = SCREEN_WIDTH/8*2;
        viewLine1.centerY = [MyMenuTableViewCell getCellHeight]/2;
        viewLine1.backgroundColor = COLOR_LINECOLOR;
        [self.contentView addSubview:viewLine1];
        
        UIButton *btnMenu2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 100)];
        btnMenu2.centerX = SCREEN_WIDTH/8*3;
        btnMenu2.centerY = btnMenu1.centerY;
        [self.contentView addSubview:btnMenu2];

        UIView *viewLine2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1,[MyMenuTableViewCell getCellHeight]/2)];
        viewLine2.centerX = SCREEN_WIDTH/8*4;
        viewLine2.centerY = [MyMenuTableViewCell getCellHeight]/2;
        viewLine2.backgroundColor = COLOR_LINECOLOR;
        [self.contentView addSubview:viewLine2];
        
        UIButton *btnMenu3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 100)];
        btnMenu3.centerX = SCREEN_WIDTH/8*5;
        btnMenu3.centerY = btnMenu1.centerY;
        [self.contentView addSubview:btnMenu3];

        
        UIView *viewLine3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, [MyMenuTableViewCell getCellHeight]/2)];
        viewLine3.centerX = SCREEN_WIDTH/8*6;
        viewLine3.centerY = [MyMenuTableViewCell getCellHeight]/2;
        viewLine3.backgroundColor = COLOR_LINECOLOR;
        [self.contentView addSubview:viewLine3];
        
        UIButton *btnMenu4 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 100)];
        btnMenu4.centerX = SCREEN_WIDTH/8*7;
        btnMenu4.centerY = btnMenu1.centerY;
        [self.contentView addSubview:btnMenu4];

        
        
        
        [RACObserve(self, isEnt) subscribeNext:^(id x) {
            if(!self.isEnt) {
                [btnMenu1 setImage:[YYImage imageNamed:@"my_barter.png"]
                         withTitle:@"图库管理"
                          sizeFont:[UIFont systemFontOfSize:13]
                        titleColor:COLOR_DETAIL
                          forState:UIControlStateNormal];
                [btnMenu1 removeAllTargets];
                [btnMenu1 addTarget:self action:@selector(gotoEntAlbum) forControlEvents:UIControlEventTouchUpInside];
                
                [btnMenu2 setImage:[YYImage imageNamed:@"my_supply.png"]
                         withTitle:@"供求管理"
                          sizeFont:[UIFont systemFontOfSize:13]
                        titleColor:COLOR_DETAIL
                          forState:UIControlStateNormal];
                [btnMenu2 removeAllTargets];
                [btnMenu2 addTarget:self action:@selector(gotoEntSupply) forControlEvents:UIControlEventTouchUpInside];
                
                [btnMenu3 setImage:[YYImage imageNamed:@"my_barter.png"]
                         withTitle:@"易货管理"
                          sizeFont:[UIFont systemFontOfSize:13]
                        titleColor:COLOR_DETAIL
                          forState:UIControlStateNormal];
                [btnMenu3 removeAllTargets];
                [btnMenu3 addTarget:self action:@selector(gotoEntBid) forControlEvents:UIControlEventTouchUpInside];
                
                [btnMenu4 setImage:[YYImage imageNamed:@"my_recruit.png"]
                         withTitle:@"招聘管理"
                          sizeFont:[UIFont systemFontOfSize:13]
                        titleColor:COLOR_DETAIL
                          forState:UIControlStateNormal];
                [btnMenu4 removeAllTargets];
                [btnMenu4 addTarget:self action:@selector(gotoZP) forControlEvents:UIControlEventTouchUpInside];
                
                
            } else {
                [btnMenu1 setImage:[YYImage imageNamed:@"my_wallte.png"]
                         withTitle:@"我的钱包"
                          sizeFont:[UIFont systemFontOfSize:13]
                        titleColor:COLOR_DETAIL
                          forState:UIControlStateNormal];
                [btnMenu1 removeAllTargets];
                [btnMenu1 addTarget:self action:@selector(gotoMyWallet) forControlEvents:UIControlEventTouchUpInside];
                
                [btnMenu2 setImage:[YYImage imageNamed:@"my_yiHuo.png"]
                         withTitle:@"我的易货"
                          sizeFont:[UIFont systemFontOfSize:13]
                        titleColor:COLOR_DETAIL
                          forState:UIControlStateNormal];
                [btnMenu2 removeAllTargets];
                [btnMenu2 addTarget:self action:@selector(gotoMyBarter) forControlEvents:UIControlEventTouchUpInside];
                
                [btnMenu3 setImage:[YYImage imageNamed:@"my_gongQiu.png"]
                         withTitle:@"我的供求"
                          sizeFont:[UIFont systemFontOfSize:13]
                        titleColor:COLOR_DETAIL
                          forState:UIControlStateNormal];
                [btnMenu3 removeAllTargets];
                [btnMenu3 addTarget:self action:@selector(gotoMySupply) forControlEvents:UIControlEventTouchUpInside];

                [btnMenu4 setImage:[YYImage imageNamed:@"my_collection.png"]
                         withTitle:@"我的收藏"
                          sizeFont:[UIFont systemFontOfSize:13]
                        titleColor:COLOR_DETAIL
                          forState:UIControlStateNormal];
                [btnMenu4 removeAllTargets];
                [btnMenu4 addTarget:self action:@selector(gotoMyCollectiong) forControlEvents:UIControlEventTouchUpInside];
            }
        }];
    }
    return self;
}


//钱包
- (void)gotoMyWallet {
    
    if([GotoRoute isLogin]) {
        return;
    }
    
    WalletHomeViewController *vc = [[WalletHomeViewController alloc] init];
    [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
}

//易货
- (void)gotoMyBarter {
//    if([GotoRoute isLogin]) {
//        return;
//    }
//
//    RootWebViewController *vc = [[RootWebViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@%@",NetH5Get,@"/iQiGou/h5/iQiGou/src/app/goodsExchange/myGoodsExchange.w"]];
//    [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
    
     [self gotoH5:@"/iQiGou/h5/iQiGou/src/app/manager/bidManager.w"];
}

//供求
- (void)gotoMySupply  {
    
    if([GotoRoute isLogin]) {
        return;
    }
    
    RootWebViewController *vc = [[RootWebViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@%@",NetH5Get,@"/iQiGou/h5/iQiGou/src/app/commercialArea/mySuplyNeed.w"]];
    [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
}

//收藏
- (void)gotoMyCollectiong {
    
    if([GotoRoute isLogin]) {
        return;
    }
    
    RootWebViewController *vc = [[RootWebViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@%@",NetH5Get,@"/iQiGou/h5/iQiGou/src/app/accountSafety/myFavorites.w"]];
    [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
}


//图库管理
- (void)gotoEntAlbum {
    if([GotoRoute isLogin]) {
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"/iQiGou/h5/iQiGou/src/app/manager/albumManager/albumManager.w?company_id=%@&company_name=%@",[AppCacheData shareCachData].userMode.computer_id,[AppCacheData shareCachData].userMode.computer_name];
    [self gotoH5:url];
}

//供求管理
- (void)gotoEntSupply {
    if([GotoRoute isLogin]) {
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"/iQiGou/h5/iQiGou/src/app/manager/supplyMng.w?uid=%@",[AppCacheData shareCachData].userMode.uid];
    [self gotoH5:url];
}

//易货管理
- (void)gotoEntBid {
    BMHomeViewController *vc = [[BMHomeViewController alloc] init];
    [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
//    [self gotoH5:@"/iQiGou/h5/iQiGou/src/app/manager/bidManager.w"];
}

//招聘管理
- (void)gotoZP {
    [self gotoH5:@"/iQiGou/h5/iQiGou/src/app/manager/merchant/ZP_Manage.w"];
}

- (void)gotoH5:(NSString*)url {
    if([GotoRoute isLogin]) {
        return;
    }
    
    RootWebViewController *vc = [[RootWebViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@%@",NetH5Get,url]];
    [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
}


+ (CGFloat)getCellHeight {
    return 100;
}

@end
