//
//  FoundContainViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/11/6.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "FoundContainViewController.h"
#import "FoundNetViewController.h"
#import "VideoContainViewController.h"
#import "AreaNetViewController.h"

@interface FoundContainViewController ()

@end

@implementation FoundContainViewController

- (void)setupData {

    
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:3];
    [items addObject:@"推荐"];
    [self.viewControllers addObject:[[FoundNetViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@/iQiGou/src/app/find/recommend/recommendList.w",NetH5]]];

    [items addObject:@"视频"];
    [self.viewControllers addObject:[[VideoContainViewController alloc] init]];


    [items addObject:@"时尚"];
    [self.viewControllers addObject:[[FoundNetViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@/iQiGou/src/app/find/information/fashionNewsList.w",NetH5]]];

    [items addObject:@"招聘"];
    [self.viewControllers addObject:[[FoundNetViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@/iQiGou/src/app/find/recruit/recruitMain.w",NetH5]]];

    [items addObject:@"活动"];
    [self.viewControllers addObject:[[FoundNetViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@/iQiGou/src/app/find/recruitActivity/activityMain.w",NetH5]]];

    [items addObject:@"招商"];
    [self.viewControllers addObject:[[FoundNetViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@/iQiGou/src/app/find/information/attractInvestmentNewsList.w",NetH5]]];

    [items addObject:@"品牌"];
    [self.viewControllers addObject:[[FoundNetViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@/iQiGou/src/app/find/information/brandNewsList.w",NetH5]]];

    self.arrItem = [[NSArray alloc] initWithArray:items];
    [self setupView];

}

//- (void)viewDidLayoutSubviews
//{
//    self.pagingViewController.view.frame = CGRectMake(0,
//                                                      kHeaderViewTop,
//                                                      self.view.frame.size.width,
//                                                      self.view.frame.size.height- kHeaderViewTop);
//}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

@end
