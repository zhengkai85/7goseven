//
//  BMMoneyAboutViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/11/23.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "BMMoneyAboutViewController.h"

@interface BMMoneyAboutViewController ()
@property (nonatomic, strong)IBOutlet UILabel *lblAbout;
@end

@implementation BMMoneyAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"费率说明";
    self.lblAbout.font = [UIFont systemFontOfSize:14];
    self.lblAbout.textColor = COLOR_DETAIL;
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
