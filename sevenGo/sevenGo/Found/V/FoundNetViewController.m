//
//  FoundNetViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/11/6.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "FoundNetViewController.h"

@interface FoundNetViewController ()

@end

@implementation FoundNetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kHeaderViewTop - TAB_BAR_HEIGHT - STATUS_BAR_HEIGHT);
}
@end
