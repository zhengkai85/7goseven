//
//  GotoRoute.m
//  sevenGo
//
//  Created by zhengkai on 2017/11/10.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "GotoRoute.h"
#import "AppCacheData.h"
#import "AppDelegate.h"

@implementation GotoRoute
+ (BOOL)isLogin {
    NSString *uId = [AppCacheData shareCachData].getU_id;
    if(!uId) {
        [[AppDelegate sharedAppDelegate] enterLoginUI];
        return YES;
    }
    return NO;
}
@end
