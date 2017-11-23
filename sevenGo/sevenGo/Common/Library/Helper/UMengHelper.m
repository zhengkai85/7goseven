//
//  UMengHelper.m
//  huimin
//
//  Created by zhengkai on 2017/10/16.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "UMengHelper.h"
#import "LCProgressHUD.h"
@implementation UMengHelper

+ (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
                             title:(NSString*)title
                             descr:(NSString*)descr
                               img:(id)img
                           linkUrl:(NSString*)linkUrl {
    
    [self setKeyForrPlatform:platformType];
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title
                                                                             descr:descr
                                                                         thumImage:img];
    shareObject.webpageUrl = linkUrl;
    messageObject.shareObject = shareObject;
    
    [[UMSocialManager defaultManager] shareToPlatform:platformType
                                        messageObject:messageObject
                                currentViewController:nil
                                           completion:^(id data, NSError *error) {
                                               if (error) {
                                                   if(error.code == 2009) {
                                                       [LCProgressHUD showMessage:@"用户取消操作"];
                                                   } else {
                                                       [LCProgressHUD showFailure:@"分享失败"];
                                                   }
                                               } else {
                                                   [LCProgressHUD showSuccess:@"分享成功"];
                                               }
                                           }];
}
    
+ (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
                    completion:(UMSocialRequestCompletionHandler)completion {
    
    [self setKeyForrPlatform:platformType];
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType
                                        currentViewController:nil
                                                   completion:^(id result, NSError *error) {
                                                       if(error) {
                                                           if(error.code == 2009) {
                                                               [LCProgressHUD showMessage:@"用户取消操作"];
                                                           } else {
                                                               [LCProgressHUD showFailure:@"获取失败"];
                                                           }
                                                       } else {
                                                           if(completion) {
                                                               completion(result, error);
                                                           }
                                                       }
                                       
    }];
}

+ (void)shareWebPageInPlatWithTitle:(NSString*)title
                              descr:(NSString*)descr
                                img:(UIImage*)img
                            linkUrl:(NSString*)linkUrl {

    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        [self shareWebPageToPlatformType:platformType
                                   title:title
                                   descr:descr
                                     img:img
                                 linkUrl:linkUrl];            
    }];
}
    
+ (void)setKeyForrPlatform:(UMSocialPlatformType)platformType {
    
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMAppID];
    if(platformType == UMSocialPlatformType_WechatSession) {
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession
                                              appKey:ShareWeixinAppID
                                           appSecret:ShareWeixinAppSecret
                                         redirectURL:nil];
    } else if (platformType == UMSocialPlatformType_QQ) {
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ
                                              appKey:ShareQQAppId/*设置QQ平台的appID*/
                                           appSecret:ShareQQKey
                                         redirectURL:@"http://mobile.umeng.com/social"];
    }
}
@end
