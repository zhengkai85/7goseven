//
//  RootWebViewController.m
//  sevenGo
//
//  Created by zhengkai on 17/9/5.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "RootWebViewController.h"
#import "NJKWebViewProgressView.h" //进度条
#import "NJKWebViewProgress.h"
#import "UIWebView+TS_JavaScriptContext.h"
#import "AppCacheData.h"
#import "AppDelegate.h"
#import "ZLPhotoActionSheet.h"

@protocol JS_TSViewController <JSExport>
- (void)pageback;
- (void)open:(NSString *)url;
- (void)close;
- (void)gotoLogin;
- (void)logout;
- (void)openImage:(NSArray*)url;
@end


@interface RootWebViewController () <UIWebViewDelegate, NJKWebViewProgressDelegate,UIActionSheetDelegate,TSWebViewDelegate,JS_TSViewController>
@property (nonatomic, strong) JSContext              *jsContext;
@property (nonatomic, strong) NJKWebViewProgressView *webViewProgressView;
@property (nonatomic, strong) NJKWebViewProgress     *webViewProgress;


@end

@implementation RootWebViewController

- (id)initWithUrl:(NSString*)postUrl {
    self = [super init];
    if(self) {
        url = [[postUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] copy];
        url = [url stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    //[self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];

    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_BAR_HEIGHT)];
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]]];
    [self.view addSubview:self.webView];
    
    self.webViewProgress = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = self.webViewProgress;
    self.webViewProgress.webViewProxyDelegate = self;
    self.webViewProgress.progressDelegate = self;
    
    CGRect navBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0,
                                 navBounds.size.height - 2,
                                 navBounds.size.width,
                                 2);
    self.webViewProgressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    self.webViewProgressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.webViewProgressView setProgress:0 animated:YES];
    [self.navigationController.navigationBar addSubview:self.webViewProgressView];
}

-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [self.webViewProgressView setProgress:progress animated:YES];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *str = [request.URL absoluteString];
    NSLog(@"zhenkgaimark   shouldStartLoadWithRequest %@",str);
    return YES;
}


- (void)webView:(UIWebView *)webView didCreateJavaScriptContext:(JSContext *)ctx {
    ctx[@"appJS"] = self;
    self.jsContext = ctx;
    
    [self addLocalStorage:[self getStorage]];
}

- (void)addLocalStorage:(NSDictionary*)dic {
    for(NSString *key in dic.allKeys) {
        NSString *jsString = [NSString stringWithFormat:@"localStorage.setItem('%@', '%@')", key,[dic objectForKey:key]];
        [self.webView stringByEvaluatingJavaScriptFromString:jsString];
    }
}

- (NSDictionary*)getStorage {
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] init];
    
    [muDic setObject:APPVERSION forKey:@"app_version"];
    
    NSString *openid = [[AppCacheData shareCachData] getOpen_id];
    if([openid isNoEmpty]) {
        [muDic setObject:openid forKey:@"open_id"];
    }
    
    NSString *uID = [[AppCacheData shareCachData] getU_id];
    if([uID isNoEmpty]) {
        [muDic setObject:uID forKey:@"uid"];
    }
    UserViewMode *userMode = [[AppCacheData shareCachData] getAllUserMessage];
    if(userMode) {
        [muDic setObject:userMode.nickname forKey:@"nickname"];
        [muDic setObject:userMode.role_id forKey:@"role_id"];
        [muDic setObject:userMode.score1 forKey:@"score"];
        [muDic setObject:userMode.avatar128 forKey:@"avatar128"];
    }

    return muDic;
}


- (void)pageback {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[GotoAppdelegate sharedAppDelegate] popViewController];
    });
}

- (void)open:(NSString *)url {
    dispatch_async(dispatch_get_main_queue(), ^{
         RootWebViewController *vc = [[RootWebViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@%@",NetH5Get,url]];
        [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
    });
}

- (void)close {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[GotoAppdelegate sharedAppDelegate] popViewController];
    });
}

- (void)gotoLogin {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[AppDelegate sharedAppDelegate] enterLoginUI];
    });
}
- (void)openImage:(NSArray*)url {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableArray *muArr = [[NSMutableArray alloc] initWithCapacity:url.count];
        for(NSString *strUrl in url) {
            [muArr addObject:[NSURL URLWithString:strUrl]];
        }
        
        ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
        actionSheet.navBarColor = [UIColor whiteColor];
        actionSheet.navTitleColor = COLOR_BLACK;
        actionSheet.sender = [GotoAppdelegate sharedAppDelegate].topViewController;
        [actionSheet previewPhotos:muArr index:0 hideToolBar:YES complete:^(NSArray * _Nonnull photos) {
        }];
    });
    

}

- (void)logout {
    [[AppCacheData shareCachData] clearData];
    [[GotoAppdelegate sharedAppDelegate] popToRootViewController];
    [[AppDelegate sharedAppDelegate] enterLoginUI];


}
@end
