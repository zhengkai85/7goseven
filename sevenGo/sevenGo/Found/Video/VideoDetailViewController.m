//
//  VideoDetailViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/9/26.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "VideoDetailViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"

#import "VideoTitleTableViewCell.h"
#import "VideoRecommendTableViewCell.h"
#import "VideoCommentTableViewCell.h"
#import "VideoNoRecommendTableViewCell.h"
#import "MJRefresh.h"
#import "VideoView.h"
#import "VideoDetailViewMode.h"
#import "CommandViewMode.h"
#import "ZKInPutTextView.h"
#import "PlugNet.h"
#import "GotoRoute.h"

@interface VideoDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSString *videoTypeId;
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) RACCommand *fetchDataCommand;

@property (strong, nonatomic)HTPlayer *htPlayer;
@property (strong, nonatomic)VideoViewMode *viewModel;
@property (strong, nonatomic)VideoDetailViewMode *detailViewModel;
@property (strong, nonatomic)VideoViewMode *recommendViewModel;
@property (strong, nonatomic)CommandViewMode *commandViewModel;

@property (strong, nonatomic)VideoView *videoView;
@property (strong, nonatomic)ZKInPutTextView *txtView;

@end

#define TitleReuseIdentifier        @"VideoTitleTableViewCell"
#define RecommendReuseIdentifier    @"VideoRecommendTableViewCell"
#define NoRecommendReuseIdentifier  @"VideoNoRecommendTableViewCell"
#define CommentReuseIdentifier      @"VideoCommentTableViewCell"


@implementation VideoDetailViewController



- (void)setValueHtPlayer:(HTPlayer*)player
                    mode:(VideoViewMode*)mode {

    self.htPlayer = player;
    self.viewModel = mode;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频";
    
    self.videoView = [[VideoView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 140)];
    self.videoView.model = self.viewModel;
    self.videoView.htPlayer = self.htPlayer;

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   SCREEN_WIDTH,
                                                                   SCREEN_HEIGHT - self.videoView.bottom)
                                                  style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.videoView;
    [self.videoView reloadData];

    [self.tableView registerNib:[UINib nibWithNibName:TitleReuseIdentifier bundle:nil]
         forCellReuseIdentifier:TitleReuseIdentifier];
    
    [self.tableView registerNib:[UINib nibWithNibName:RecommendReuseIdentifier bundle:nil]
         forCellReuseIdentifier:RecommendReuseIdentifier];
    
    [self.tableView registerNib:[UINib nibWithNibName:CommentReuseIdentifier bundle:nil]
         forCellReuseIdentifier:CommentReuseIdentifier];
    
    [self.tableView registerNib:[UINib nibWithNibName:NoRecommendReuseIdentifier bundle:nil]
         forCellReuseIdentifier:NoRecommendReuseIdentifier];
    
    [self.viewModel.refreshDataSignal subscribeError:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    } completed:^{
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer resetNoMoreData];
    }];
    
    
    @weakify(self);
    self.txtView = [[ZKInPutTextView alloc] initWithFrame:CGRectMake(0,
                                                                     SCREEN_HEIGHT - TOP_HEIGHT - kTOOLBarHeight ,
                                                                     SCREEN_WIDTH,
                                                                     kTOOLBarHeight)];
    [self.view addSubview:self.txtView];
    [self.txtView setSendBlock:^(NSString *txt) {
        @strongify(self);
        
        if([GotoRoute isLogin]) {
            return ;
        }
        
        NSInteger row = [self.viewModel.videoID integerValue];
        [PlugNet sendCommentApp:@"Video"
                            mod:@"video"
                         row_id:row
                            pid:0
                        content:txt
                          block:^(id posts, NSInteger code, NSString *errorMsg) {
                              ;
                          }];
    }];
    
    [RACObserve(self, txtView.top) subscribeNext:^(id x) {
        @strongify(self);
        self.tableView.height = [x floatValue];
        CGFloat y = self.tableView.contentSize.height - self.tableView.height;
        if(y > 0) {
            [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height - self.tableView.height)];
        }
    }];
    
    self.detailViewModel = [[VideoDetailViewMode alloc] initWithVideoID:self.viewModel.videoID];
    [self.detailViewModel.refreshDetailDataSignal subscribeError:^(NSError *error) {
    } completed:^{
        [self.tableView reloadSection:0 withRowAnimation:UITableViewRowAnimationNone];
    }];
    
    self.recommendViewModel = [[VideoViewMode alloc] initWithRecommend];
    [self.recommendViewModel.refreshRecommendSignal subscribeError:^(NSError *error) {
    }  completed:^{
        [self.tableView reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
    }];
    
    self.commandViewModel = [[CommandViewMode alloc] initWithVideoID:self.viewModel.videoID];
    [self.commandViewModel.refreshDataSignal subscribeError:^(NSError *error) {
    } completed:^{
        [self.tableView reloadSection:2 withRowAnimation:UITableViewRowAnimationNone];
    }];

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    DOWN_KEYBOARD;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) {
        return 1;
    } else if (section == 1) {
        NSInteger count = self.recommendViewModel.recommendDatas.count;
        return count == 0 ? 1:count ;
    } else if (section == 2) {
        NSInteger count = self.commandViewModel.listDatas.count;
        return count ;//== 0 ? 1:count ;
    }
    return 0;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self getHeightForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if(indexPath.section == 0) {
        VideoTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TitleReuseIdentifier];
        if(self.detailViewModel.detailMode) {
            [cell setViewMode:self.detailViewModel.detailMode height:[self getHeightForRowAtIndexPath:indexPath]];
        }
        return cell;
    } else if (indexPath.section == 1) {
        if(self.recommendViewModel.recommendDatas.count == 0) {
            VideoNoRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NoRecommendReuseIdentifier];
            return cell;
        } else {
            VideoRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RecommendReuseIdentifier];
            VideoViewMode *mode = self.recommendViewModel.recommendDatas[indexPath.row];
            [cell setViewMode:mode];
            return cell;
        }
    } else if (indexPath.section == 2) {
        if(self.commandViewModel.listDatas.count > indexPath.row) {
            VideoCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentReuseIdentifier];
            CommandViewMode *mode = self.commandViewModel.listDatas[indexPath.row];
            [cell setViewMode:mode];
            return cell;
        }

    }
    return [UITableViewCell new];
}


- (CGFloat)getHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        return 170;
    } else if (indexPath.section == 1) {
        return 70;
    } else if (indexPath.section == 2) {
        return 100;
    }
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 2) {
        return 30;
    }
    return 0.0001;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section == 2) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 100, 30)];
        lbl.textColor = COLOR_TEXT;
        lbl.font = [UIFont systemFontOfSize:13];
        lbl.text = @"最新评论";
        [view addSubview:lbl];
        return view;
    }

    return [UIView new];
}

@end
