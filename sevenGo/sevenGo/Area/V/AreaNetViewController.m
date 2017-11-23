//
//  AreaNetViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/11/6.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "AreaNetViewController.h"

@interface AreaNetViewController ()

@end

@implementation AreaNetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView.frame = CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - kHeaderViewTop - TAB_BAR_HEIGHT - STATUS_BAR_HEIGHT);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
