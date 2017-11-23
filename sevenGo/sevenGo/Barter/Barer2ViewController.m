//
//  Barer2ViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/10/19.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "Barer2ViewController.h"

@interface Barer2ViewController ()

@end

@implementation Barer2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *str = [request.URL absoluteString];
    NSLog(@"zhenkgaimark   shouldStartLoadWithRequest %@",str);
    return YES;
}

@end
