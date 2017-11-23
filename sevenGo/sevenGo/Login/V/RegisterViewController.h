//
//  RegisterViewController.h
//  sevenGo
//
//  Created by zhengkai on 2017/10/9.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "RootLoginViewController.h"

@interface RegisterViewController : RootLoginViewController
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) void(^bindRegSucessBLock)(void);
@end
