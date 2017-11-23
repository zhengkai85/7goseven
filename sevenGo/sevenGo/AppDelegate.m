//
//  AppDelegate.m
//  sevenGo
//
//  Created by zhengkai on 17/9/5.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import <AlipaySDK/AlipaySDK.h>
#import "AppCacheData.h"
#import "WXApi.h"
@interface AppDelegate ()
@end

@implementation AppDelegate

+ (instancetype)sharedAppDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self enterMainUI];

//    if([[[AppCacheData shareCachData] getOpen_id] isNoEmpty]) {
//        [self enterMainUI];
//    } else {
//        [self enterLoginUI];
//    }

    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if([[UMSocialManager defaultManager] handleOpenURL:url]) {
        return YES;
    }
    
    if([WXApi handleOpenURL:url delegate:nil]) {
        return YES;
    }
    
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        }];
        return YES;
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation {
    if([[UMSocialManager defaultManager] handleOpenURL:url]) {
        return YES;
    }
    
    if([WXApi handleOpenURL:url delegate:nil]) {
        return YES;
    }
    
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        }];
        return YES;
    }
    return YES;
}

- (BOOL)appOpenUrl:(NSURL *)url {
    if([[UMSocialManager defaultManager] handleOpenURL:url]) {
        return YES;
    }
    
    if([WXApi handleOpenURL:url delegate:nil]) {
        return YES;
    }
    
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        }];
        return YES;
    }
    return YES;
}

- (void)enterMainUI {
    [self customizeInterface];
    if(!self.tabBarController) {
        self.tabBarController = [[SevenGoTabBarController alloc] init];
    }
    [self.window setRootViewController:self.tabBarController];
}

- (void)reNewMainUI {
    self.tabBarController = nil;
}

- (void)enterLoginUI {
    
    [self customizeInterface];
    UINavigationController *vc = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
    [self.window setRootViewController:vc];
}

- (void)selectTabBarIndex:(NSInteger)index {
    self.tabBarController.selectedIndex = index;
}




- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    NSDictionary *attributesSel = nil;
    attributesSel = @{ NSFontAttributeName: [UIFont boldSystemFontOfSize:17],
                       NSForegroundColorAttributeName: COLOR_BLACK, };
    
    [navigationBarAppearance setTitleTextAttributes:attributesSel];
    navigationBarAppearance.barTintColor = [UIColor whiteColor];
    navigationBarAppearance.tintColor = COLOR_BLACK;
    navigationBarAppearance.translucent = NO;
    
}

@end
