//
//  UMengHelper.h
//  huimin
//
//  Created by zhengkai on 2017/10/16.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>

@interface UMengHelper : NSObject

//第三方登录
+ (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
                    completion:(UMSocialRequestCompletionHandler)completion;
    
//分享
+ (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
                             title:(NSString*)title
                             descr:(NSString*)descr
                               img:(id)img
                           linkUrl:(NSString*)linkUrl;


+ (void)shareWebPageInPlatWithTitle:(NSString*)title
                              descr:(NSString*)descr
                                img:(id)img
                            linkUrl:(NSString*)linkUrl;

@end
