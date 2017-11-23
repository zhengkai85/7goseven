//
//  RootViewController.m
//  huimin
//
//  Created by zhengkai on 16/4/5.
//  Copyright © 2016年 zhengkai. All rights reserved.
//

#import "RootViewController.h"
//#import "UMMobClick/MobClick.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    
    
    //[__bu preferredStatusBarStyle];
}

- (void)viewWillAppear:(BOOL)animated {
    //[self setNeedsStatusBarAppearanceUpdate];
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:self.title];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:self.title];
}

- (void)didReceiveMemoryWarning {
    NSLog(@"%@ .............        didReceiveMemoryWarning",[self class]);
}
//- (UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
