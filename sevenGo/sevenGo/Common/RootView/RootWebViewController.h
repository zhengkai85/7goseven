//
//  RootWebViewController.h
//  sevenGo
//
//  Created by zhengkai on 17/9/5.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootWebViewController : UIViewController{
    @protected  NSString  *url;
}


@property (nonatomic, strong) UIWebView              *webView;

- (id)initWithUrl:(NSString*)url;

@property (nonatomic, strong)NSString *currentUrl;
@end
