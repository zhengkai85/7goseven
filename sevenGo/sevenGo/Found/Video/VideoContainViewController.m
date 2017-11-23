//
//  VideoContainViewController.m
//  sevenGo
//
//  Created by zhengkai on 17/9/11.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "VideoContainViewController.h"
#import "VideoListViewController.h"
#import "VideoTypeViewMode.h"

@interface VideoContainViewController ()

@end

@implementation VideoContainViewController

- (void)setupData {
    // Do any additional setup after loading the view.
    
    VideoTypeViewMode *mode = [[VideoTypeViewMode alloc] init];
    RACSubject *subject = [RACSubject subject];
    [mode.refreshDataSignal subscribeError:^(NSError *error) {
        [subject sendError:error];
    } completed:^{
        [subject sendCompleted];
        NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:mode.allDatas.count];
        for(VideoTypeViewMode *m in mode.allDatas) {
            [arr addObject:m.title];
            [self.viewControllers addObject:[[VideoListViewController alloc] initWithvideoTypeId:m.videoTypeId]];
        }
        
        self.arrItem = [[NSArray alloc] initWithArray:arr];
        [self setupView];
        
        
        self.pagingHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kHeaderViewTop);
        self.pagingViewController.view.frame = CGRectMake(0,
                                                          self.pagingHeaderView.bottom,
                                                          SCREEN_WIDTH,
                                                          self.view.height - self.pagingHeaderView.bottom);
    }];
}



- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews {

}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

@end
