//
//  GotoAppdelegate.h
//  MyBaseFrameWork
//
//  Created by zhengkai on 16/11/11.
//  Copyright © 2016年 zhengkai. All rights reserved.
//

#import "AppDelegate.h"

typedef void (^CommonVoidBlock)(void);


@interface GotoAppdelegate : NSObject

+ (GotoAppdelegate*)sharedAppDelegate;


// 代码中尽量改用以下方式去push/pop/present界面
- (UINavigationController *)navigationViewController;

- (UIViewController *)topViewController;

- (void)pushViewController:(UIViewController *)viewController;
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (void)popToViewControllerClass:(id)viewControllerClass;


- (UIViewController *)popViewController;

- (NSArray *)popToRootViewController;

- (void)presentViewController:(UIViewController *)vc animated:(BOOL)animated completion:(void (^)(void))completion;
- (void)dismissViewController:(UIViewController *)vc animated:(BOOL)animated completion:(void (^)(void))completion;
@end
