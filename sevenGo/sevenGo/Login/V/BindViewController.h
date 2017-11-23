//
//  BindViewController.h
//  sevenGo
//
//  Created by zhengkai on 2017/10/17.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "RootLoginViewController.h"

@interface BindViewController : RootLoginViewController

@property (nonatomic, strong) NSString *accountType;
@property (nonatomic, strong) NSString *auth_result;
@property (nonatomic, strong) NSString *userInfo;

@end
