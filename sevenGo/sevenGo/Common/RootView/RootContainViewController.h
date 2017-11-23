//
//  RootContainViewController.h
//  Credit
//
//  Created by zhengkai on 17/3/29.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "FFPagingViewController.h"

@interface RootContainViewController : RootViewController {
}
@property (nonatomic, strong) NSArray *arrItem;
@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, assign) NSInteger selIndex;
@property (nonatomic, strong) FFPagingHeaderView *pagingHeaderView;
@property (nonatomic, strong) FFPagingViewController *pagingViewController;
@property (nonatomic, strong) void(^scrollGoto)(NSInteger index);
- (void)setupView;
@end
