//
//  BarterViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/10/19.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "BarterViewController.h"

@interface BarterViewController () <UIWebViewDelegate>
@end

@implementation BarterViewController

- (id)init {
    
    self.currentUrl = [NSString stringWithFormat:@"%@/iQiGou/web/iQiGou/src/app/goodsExchange/goodsList.w",NetH5];
    self = [super initWithUrl:self.currentUrl];
    if(self) {
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView.delegate = self;
    self.webView.frame = CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TAB_BAR_HEIGHT);
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *urlGO = [request.URL absoluteString];
    
    if (![urlGO isEqualToString:self.currentUrl]) {
        RootWebViewController *web = [[RootWebViewController alloc] initWithUrl:urlGO];
        web.currentUrl = urlGO;
        web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
        return NO;
    }
    return YES;
//    return [super webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
}


@end
