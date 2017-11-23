//
//  AreaContainViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/10/19.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "AreaContainViewController.h"
#import "AreaNetViewController.h"
#import "AreaAddViewController.h"


@interface AreaContainViewController ()

@end

@implementation AreaContainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 35, 10, 20, 20)];
    [btn setImage:[YYImage imageNamed:@"areaAdd.png"] forState:UIControlStateNormal];
    [self.pagingHeaderView addSubview:btn];
    [btn addTarget:self action:@selector(doAdd) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)doAdd {
    AreaAddViewController *vc = [[AreaAddViewController alloc] init];
    [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
}

- (void)setupData {
    
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:3];
    [items addObject:@"商圈"];
    //http://wxtestpro.free.ngrok.cc/iQiGou/h5/iQiGou/src/app/commercialArea/supplyAndDemandList.w
    [self.viewControllers addObject:[[AreaNetViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@/iQiGou/src/app/commercialArea/supplyAndDemandList.w",NetH5]]];

    [items addObject:@"我的关注"];
    [self.viewControllers addObject:[[AreaNetViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@/iQiGou/src/app/commercialArea/myFocus.w",NetH5]]];
    
    [items addObject:@"企业"];
    [self.viewControllers addObject:[[AreaNetViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@/iQiGou/src/app/commercialArea/enterprise.w",NetH5]]];
    
    self.arrItem = [[NSArray alloc] initWithArray:items];
    [self setupView];
}

- (void)viewDidLayoutSubviews
{
    self.pagingViewController.view.frame = CGRectMake(0,
                                                      kHeaderViewTop ,
                                                      SCREEN_WIDTH,
                                                      SCREEN_HEIGHT - kHeaderViewTop - TAB_BAR_HEIGHT);
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
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
