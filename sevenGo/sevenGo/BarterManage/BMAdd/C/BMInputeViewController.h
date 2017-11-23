//
//  BMInputeViewController.h
//  sevenGo
//
//  Created by zhengkai on 2017/11/22.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "RootViewController.h"

@interface BMInputeViewController : RootViewController
@property (nonatomic, strong)NSString *strContent;
@property (nonatomic, strong)void(^doSaveBlock)(NSString *txt);
@end
