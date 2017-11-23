//
//  LoginViewController.h
//  huimin
//
//  Created by zhengkai on 16/4/7.
//  Copyright © 2016年 zhengkai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootLoginViewController.h"

@interface LoginViewController : RootLoginViewController

@property (nonatomic,assign) BOOL bPush;
@property (nonatomic, strong) void (^loginComplete)(void);
@property (nonatomic, strong) void(^cancleBlock)(void);

@end
