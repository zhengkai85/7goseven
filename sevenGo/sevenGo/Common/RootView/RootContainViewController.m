//
//  RootContainViewController.m
//  Credit
//
//  Created by zhengkai on 17/3/29.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "RootContainViewController.h"
#import "UINavigationController+TZPopGesture.h"


@interface RootContainViewController ()  <FFPagingViewControllerDataSource, FFPagingViewControllerDelegate>
@end

@implementation RootContainViewController

- (void)setupView {
    

    if(self.arrItem.count>0) {
        [self.view addSubview:self.pagingHeaderView];
        
        @weakify(self);
        self.pagingHeaderView.pagingViewItemClickHandle = ^(FFPagingHeaderView *headerView, NSString *title, NSInteger currentIndex) {
            @strongify(self);
            self.pagingViewController.seletedIndex = currentIndex;
        };
        
        [self.view addSubview:self.pagingViewController.view];
        [self.pagingViewController reloadData];
    }

}



- (void)setupData {
}
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupData];
    [self setupView];
    
    if(self.selIndex < _pagingHeaderView.titles.count) {
        [_pagingHeaderView updateTitleContentOffset:self.selIndex];
    }
    
    if(self.selIndex < self.viewControllers.count) {
        _pagingViewController.seletedIndex = self.selIndex;
    }
    
}

- (void)viewDidLayoutSubviews
{
//    self.pagingViewController.view.frame = CGRectMake(0,
//                                                      kHeaderViewTop,
//                                                      self.view.frame.size.width,
//                                                      self.view.frame.size.height- kHeaderViewTop);
//    [self.pagingHeaderView updateTitleContentOffset:0];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - FFPagingViewControllerDelegate
- (void)customPagingViewController:(FFPagingViewController *)pagingViewController slideIndex:(NSInteger)slideIndex
{
    [self.pagingHeaderView updateTitleContentOffset:slideIndex];
}

- (void)customPagingViewController:(FFPagingViewController *)pagingViewController contentOffset:(CGPoint)slideOffset
{
    self.pagingHeaderView.contentOffset = slideOffset;
}

#pragma mark - FFPagingViewControllerDataSource
- (NSUInteger)numberOfChildViewControllersInPagingViewController:(FFPagingViewController *)pagingViewController
{
    return self.viewControllers.count;
}

- (UIViewController *)pagingViewController:(FFPagingViewController *)pageingViewController atIndex:(NSInteger)index
{
    if(self.scrollGoto) {
        self.scrollGoto(index);
    }
    return self.viewControllers[index];
}

#pragma mark - getter
- (FFPagingViewController *)pagingViewController {
    
    if (!_pagingViewController) {
        _pagingViewController = [[FFPagingViewController alloc] init];
        _pagingViewController.view.frame = CGRectMake(0,
                                             STATUS_BAR_HEIGHT + kHeaderViewTop,
                                             [UIScreen mainScreen].bounds.size.width,
                                             [UIScreen mainScreen].bounds.size.height - kHeaderViewTop - TAB_BAR_HEIGHT - STATUS_BAR_HEIGHT);
        _pagingViewController.delegate = self;
        _pagingViewController.dataSource = self;
        [self tz_addPopGestureToView:_pagingViewController.scrollview];
    }
    return _pagingViewController;
}

- (FFPagingHeaderView *)pagingHeaderView {
    if (!_pagingHeaderView) {
        _pagingHeaderView = [[FFPagingHeaderView alloc] init];
        _pagingHeaderView.backgroundColor = [UIColor whiteColor];
        _pagingHeaderView.frame = CGRectMake(0, STATUS_BAR_HEIGHT, [UIScreen mainScreen].bounds.size.width, kHeaderViewTop);
        [_pagingHeaderView setFont:[UIFont systemFontOfSize:12]];
        [_pagingHeaderView setTextColor:COLOR_BLACK];
        [_pagingHeaderView setSelectTextColor:COLOR_NAV];
        _pagingHeaderView.itemWidth = SCREEN_WIDTH/self.arrItem.count;
        _pagingHeaderView.titles = self.arrItem;
        
    }
    return _pagingHeaderView;
}

- (NSMutableArray *)viewControllers
{
    if (!_viewControllers) {
        _viewControllers = [NSMutableArray array];
    }
    return _viewControllers;
}
@end
