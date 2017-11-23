//
//  AgreementViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/10/10.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "AgreementViewController.h"

@interface AgreementViewController ()

@end

@implementation AgreementViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
    
}
    
- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillDisappear:animated];
}
    
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"用户协议";
    
    
    UITextView *txt = [[UITextView alloc] initWithFrame:CGRectMake(8, 0, SCREEN_WIDTH-16, SCREEN_HEIGHT - TOP_HEIGHT)];
    txt.editable = NO;
    txt.font = [UIFont systemFontOfSize:12];
    txt.textColor = COLOR_TEXT;
    [self.view addSubview:txt];
    
    
    NSString *dataFile = [NSString stringNamed:@"readme"];

    txt.text = dataFile;
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, txt.width, 12)];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.text = @"7购往来用户注册协议";
    lblTitle.font = txt.font;
    lblTitle.textColor = COLOR_BLACK;
    [txt addSubview:lblTitle];
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
