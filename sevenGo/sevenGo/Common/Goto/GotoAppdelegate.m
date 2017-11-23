//
//  GotoAppdelegate.m
//  MyBaseFrameWork
//
//  Created by zhengkai on 16/11/11.
//  Copyright © 2016年 zhengkai. All rights reserved.
//

#import "GotoAppdelegate.h"

@implementation GotoAppdelegate

+ (GotoAppdelegate*)sharedAppDelegate {
    
    static GotoAppdelegate *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

// 获取当前活动的navigationcontroller
- (UINavigationController *)navigationViewController {
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];

    if ([window.rootViewController isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)window.rootViewController;
    } else if ([window.rootViewController isKindOfClass:[UITabBarController class]]) {
        UIViewController *selectVc = [((UITabBarController *)window.rootViewController) selectedViewController];
        if ([selectVc isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *)selectVc;
        }
    }
    return nil;
}

- (UIViewController *)topViewController {
    UINavigationController *nav = [self navigationViewController];
    return nav.topViewController;
}

- (void)pushViewController:(UIViewController *)viewController {
    @autoreleasepool {
        viewController.hidesBottomBarWhenPushed = YES;
        [[self navigationViewController] pushViewController:viewController animated:YES];
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    @autoreleasepool {
        viewController.hidesBottomBarWhenPushed = YES;
        [[self navigationViewController] pushViewController:viewController animated:animated];
    }
}



- (UIViewController *)popViewController {
    return [[self navigationViewController] popViewControllerAnimated:YES];
}
- (NSArray *)popToRootViewController {
    return [[self navigationViewController] popToRootViewControllerAnimated:YES];
}

- (void)popToViewControllerClass:(id)viewControllerClass {
    for (UIViewController *temp in [self navigationViewController].viewControllers) {
        if ([temp isKindOfClass:viewControllerClass]) {
            [[self navigationViewController] popToViewController:temp animated:YES];
        }
    }
}



- (void)presentViewController:(UIViewController *)vc animated:(BOOL)animated completion:(void (^)(void))completion {
    
    UIViewController *top = [self topViewController];
    if (vc.navigationController == nil) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [top presentViewController:nav animated:animated completion:completion];
    } else {
        [top presentViewController:vc animated:animated completion:completion];
    }
}

- (void)dismissViewController:(UIViewController *)vc animated:(BOOL)animated completion:(void (^)(void))completion {
    
    if (vc.navigationController != [GotoAppdelegate sharedAppDelegate].navigationViewController) {
        [vc dismissViewControllerAnimated:YES completion:completion];
    } else {
        [vc.navigationController popViewControllerAnimated:YES];
    }
}

@end
