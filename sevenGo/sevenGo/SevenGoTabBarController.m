//
//  SevenGoTabBarController.m
//  sevenGo
//
//  Created by zhengkai on 17/9/5.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "SevenGoTabBarController.h"
#import "TopHomeViewController.h"
#import "TopHome2ViewController.h"
#import "BarterViewController.h"
#import "AreaContainViewController.h"
#import "FoundContainViewController.h"
#import "MyViewController.h"
#import "HTPlayer.h"
#import "BMHomeViewController.h"

@interface SevenGoTabBarController ()

@end

@implementation SevenGoTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setViewControllerValues];
}

- (void)setViewControllerValues {
    
    
    UINavigationController *homeNavigationController = [[UINavigationController alloc]
                                                        initWithRootViewController:[[TopHome2ViewController alloc] init]];
    homeNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页"
                                                                        image:[YYImage imageNamed:@"tb_home_nor.png"]
                                                                selectedImage:[YYImage imageNamed:@"tb_home_sel.png"]];
    
    
    RootWebViewController *vcGoods = [[RootWebViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@%@",NetH5,@"/iQiGou/src/app/bid/bidHome.w"]];
//    vcGoods.view.backgroundColor = COLOR_TABARVIEWGRAY;
    vcGoods.webView.top = 0;
    UINavigationController *barterNavigationController = [[UINavigationController alloc]
                                                        initWithRootViewController:vcGoods];
    barterNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"易货"
                                                                        image:[YYImage imageNamed:@"tb_barter_nor.png"]
                                                                selectedImage:[YYImage imageNamed:@"tb_barter_sel.png"]];
    
    UINavigationController *areaNavigationController = [[UINavigationController alloc]
                                                          initWithRootViewController:[[AreaContainViewController alloc] init]];
    areaNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"商圈"
                                                                          image:[YYImage imageNamed:@"tb_area_nor.png"]
                                                                  selectedImage:[YYImage imageNamed:@"tb_area_sel.png"]];
    
    FoundContainViewController *vc = [[FoundContainViewController alloc] init];
    [vc setScrollGoto:^(NSInteger index) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kHTPlayerCloseVideoNotificationKey
                                                            object:nil];
    }];
    UINavigationController *foundNavigationController = [[UINavigationController alloc]
                                                         initWithRootViewController:vc];
    foundNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现"
                                                                         image:[YYImage imageNamed:@"tb_found_nor.png"]
                                                                 selectedImage:[YYImage imageNamed:@"tb_found_sel.png"]];
    
    
    
    UINavigationController *myNavigationController = [[UINavigationController alloc]
                                                      initWithRootViewController:[[MyViewController alloc] init]];
    myNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的"
                                                                      image:[YYImage imageNamed:@"tb_my_nor.png"]
                                                              selectedImage:[YYImage imageNamed:@"tb_my_sel.png"]];
    
    
    
    [self setViewControllers:@[homeNavigationController,barterNavigationController,areaNavigationController,foundNavigationController,myNavigationController]];
    
    [self.tabBar setTintColor:RGBCOLOR(158, 72, 176)];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -3)];
//    self.tabBar.translucent = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.extendedLayoutIncludesOpaqueBars = NO;
    self.tabBar.backgroundColor = [UIColor whiteColor];
//    [self.tabBar setShadowImage:[UIImage new]];
//    [self.tabBar setBackgroundImage:[[UIImage alloc]init]];


}

@end
