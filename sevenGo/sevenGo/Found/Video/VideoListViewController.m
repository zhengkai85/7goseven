//
//  VideoListViewController.m
//  sevenGo
//
//  Created by zhengkai on 17/9/11.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "VideoListViewController.h"
#import "VideoTableViewCell.h"
#import "MJRefresh.h"
#import "HTPlayer.h"
#import "VideoViewMode.h"
#import "VideoDetailViewController.h"

@interface VideoListViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) VideoViewMode *viewModel;
@property (strong, nonatomic) HTPlayer *htPlayer;
@property (strong, nonatomic) NSIndexPath *currentIndexPath;
@property (nonatomic, strong) VideoTableViewCell *currentCell;
@property (assign, nonatomic) BOOL isSmallScreen;

@property (nonatomic, strong) NSString *videoTypeId;
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) RACCommand *fetchDataCommand;
@property (strong, nonatomic) RACCommand *didSelectedRowCommand;
@end

#define ReuseIdentifier @"VideoCell"

@implementation VideoListViewController



- (instancetype)initWithvideoTypeId:(NSString*)videoTypeId {
    
    if (self = [super init]) {
        self.videoTypeId = videoTypeId;
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self releaseWMPlayer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_BAR_HEIGHT - TAB_BAR_HEIGHT - kHeaderViewTop*2)
                                                  style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"VideoTableViewCell" bundle:nil]
         forCellReuseIdentifier:ReuseIdentifier];
    
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self.viewModel.refreshDataSignal subscribeError:^(NSError *error) {
            [self.tableView.mj_header endRefreshing];
        } completed:^{
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer resetNoMoreData];
        }];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self.viewModel.loadMoreDataSignal subscribeError:^(NSError *error) {
            [self.tableView.mj_footer endRefreshing];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } completed:^{
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
        }];
    }];
    
    
    self.viewModel = [[VideoViewMode alloc] initWithVideoTypeID:self.videoTypeId];
    RACSubject *subject = [RACSubject subject];
    [self.viewModel.refreshDataSignal subscribeError:^(NSError *error) {
        [subject sendError:error];
    } completed:^{
        [subject sendCompleted];
        [self.tableView reloadData];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popDetail:)
                                                 name:kHTPlayerPopDetailNotificationKey
                                               object:nil];
    
    [self addObserver];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self closeTheVideo:nil];
}

- (void)addObserver {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(OrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidFinished:)
                                                 name:kHTPlayerFinishedPlayNotificationKey object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullScreenBtnClick:)
                                                 name:kHTPlayerFullScreenBtnNotificationKey object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeTheVideo:)
                                                 name:kHTPlayerCloseVideoNotificationKey
                                               object:nil];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.listDatas.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [VideoTableViewCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    VideoViewMode *mode = self.viewModel.listDatas[indexPath.row];
    cell.viewModel = mode;
    [cell setSelectBlock:^{
        VideoDetailViewController *vc = [[VideoDetailViewController alloc] init];
        [vc setValueHtPlayer:_htPlayer mode:mode];
        [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
        
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self startPlayVideo:indexPath];
}

#pragma mark scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView ==self.tableView){
        if (_htPlayer==nil) return;
        
        if (_htPlayer.superview) {
            CGRect rectInTableView = [self.tableView rectForRowAtIndexPath:_currentIndexPath];
            CGRect rectInSuperview = [self.tableView convertRect:rectInTableView toView:[self.tableView superview]];
            
            if (rectInSuperview.origin.y-kNavbarHeight<-self.currentCell.backView.height||rectInSuperview.origin.y>self.view.height) {//往上拖动
                if (![[UIApplication sharedApplication].keyWindow.subviews containsObject:_htPlayer]) {
                    //放widow上,小屏显示
                    //[self toSmallScreen];
                    
                    [_htPlayer removeFromSuperview];
                    [self releaseWMPlayer];
                }
            }
        }
        
    }
}

-(void)toCell{
    
    self.currentCell = (VideoTableViewCell *)[self.tableView cellForRowAtIndexPath:_currentIndexPath];
    [_htPlayer reductionWithInterfaceOrientation:self.currentCell.backView];
    _isSmallScreen = NO;
    [self.tableView reloadData];
}

-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation{
    [_htPlayer toFullScreenWithInterfaceOrientation:interfaceOrientation];
}
-(void)toSmallScreen{
    //放widow上
    [_htPlayer toSmallScreen];
    _isSmallScreen = YES;
}

//开始播放
-(void)startPlayVideo:(NSIndexPath *)index{
    
    _currentIndexPath = index;
    self.currentCell = (VideoTableViewCell *)[self.tableView cellForRowAtIndexPath:_currentIndexPath];
    VideoViewMode *model = [self.viewModel.listDatas objectAtIndex:index.row];
    if (_htPlayer) {
        [_htPlayer removeFromSuperview];
        [_htPlayer setVideoURLStr:model.url_mobile];
        
    }else{
        _htPlayer = [[HTPlayer alloc]initWithFrame:self.currentCell.backView.bounds videoURLStr:model.url_mobile];
    }
    
    [_htPlayer setPlayTitle:model.title];
    
    [self.currentCell.backView addSubview:_htPlayer];
    [self.currentCell.backView bringSubviewToFront:_htPlayer];
    
    if (_htPlayer.screenType == UIHTPlayerSizeSmallScreenType) {
        [_htPlayer reductionWithInterfaceOrientation:self.currentCell.backView];
    }
    _isSmallScreen = NO;
    
    //[self.tableView reloadData];
}


- (void)OrientationDidChange:(NSNotification *)obj
{
    if (_htPlayer) {
        
        UIInterfaceOrientation orientation = (UIInterfaceOrientation)[UIDevice currentDevice].orientation;
        if(orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
            [_htPlayer setFullScreenSelect:NO];
        } else {
            [_htPlayer setFullScreenSelect:YES];
            
        }
    }
}

- (void)popDetail:(NSNotification *)obj
{
    _htPlayer = (HTPlayer *)obj.object;
    if (_htPlayer) {
        if (_isSmallScreen) {
            [self toSmallScreen];
        }else{
            [self toCell];
        }
    }
    
    [self addObserver];
}

-(void)videoDidFinished:(NSNotification *)notice{
    
    if (_htPlayer.screenType == UIHTPlayerSizeFullScreenType){
        
        [self toCell];//先变回cell
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        _htPlayer.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_htPlayer removeFromSuperview];
        [self releaseWMPlayer];
    }];
    
}
-(void)closeTheVideo:(NSNotification *)obj{
    
    if(!_htPlayer) {
        return;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        _htPlayer.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_htPlayer removeFromSuperview];
        [self releaseWMPlayer];
    }];
}

-(void)fullScreenBtnClick:(NSNotification *)notice{
    
    UIButton *fullScreenBtn = (UIButton *)[notice object];
    if (fullScreenBtn.isSelected) {//全屏显示
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        if([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft) {
            [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
        } else if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight) {
            [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeRight];
        }
    } else {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        if (_isSmallScreen) {
            //放widow上,小屏显示
            [self toSmallScreen];
        } else {
            [self toCell];
        }
    }
}

-(void)releaseWMPlayer{
    
    [_htPlayer releaseWMPlayer];
    _htPlayer = nil;
    _currentIndexPath = nil;
}
@end
