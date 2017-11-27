//
//  UIViewController+BackButtonHandler.h
//  huimin
//
//  Created by zhengkai on 16/4/22.
//  Copyright © 2016年 zhengkai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BackButtonHandlerProtocol <NSObject>

@optional

// Override this method in UIViewController derived class to handle 'Back' button click

-(BOOL)navigationShouldPopOnBackButton;

@end

@interface UIViewController (BackButtonHandler) <BackButtonHandlerProtocol>

@end
