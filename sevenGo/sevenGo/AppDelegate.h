//
//  AppDelegate.h
//  sevenGo
//
//  Created by zhengkai on 17/9/5.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SevenGoTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) SevenGoTabBarController *tabBarController;

+ (instancetype)sharedAppDelegate;

- (void)reNewMainUI;
- (void)enterMainUI;
- (void)enterLoginUI;
- (void)selectTabBarIndex:(NSInteger)index;

@end

