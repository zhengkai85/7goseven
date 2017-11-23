//
//  LoginNet.m
//  sevenGo
//
//  Created by zhengkai on 2017/9/30.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "LoginNet.h"
#import "AFAppDotNetAPIClient.h"
#import "AppCacheData.h"

@implementation LoginNet

+ (void)verifyPhone:(NSString*)phone
             action:(NSString*)action
              block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    
    NSDictionary *dic = @{@"method" : Method_Post,
                          @"account" : phone,
                          @"type" : @"mobile",
                          @"action":action,
                          };
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    NSString *openId = [[AppCacheData shareCachData] getOpen_id];
    if([openId isNoEmpty]) {
        [muDic setObject:openId forKey:@"open_id"];
    }
    
    [AFAppDotNetAPIClient dealWithNet:@"verify"
                                param:muDic
                           isShowLoad:NO
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                               block(posts,code,errorMsg);
                           }];
}


+ (void)loginUserName:(NSString*)userName
             password:(NSString*)pwd
                block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    
    NSDictionary *dic = @{@"method" : Method_Post,
                          @"username" : userName,
                          @"password" : pwd,
                          };
    [AFAppDotNetAPIClient dealWithNet:@"authorization"
                                param:dic
                           isShowLoad:NO
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                               block(posts,code,errorMsg);
                           }];
}

+ (void)accountUserName:(NSString*)userName
               password:(NSString*)pwd
             reg_verify:(NSString*)reg_verify
                  block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    NSDictionary *dic = @{@"method" : Method_Post,
                          @"reg_type": @"mobile",
                          @"mobile" : userName,
                          @"password" : pwd,
                          @"nickname" : userName,
                          @"role" : @"1",
                          };
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    if([reg_verify isNoEmpty]) {
        [muDic setObject:reg_verify forKey:@"inviter_uid"];
    }
    
    [AFAppDotNetAPIClient dealWithNet:@"account"
                                param:muDic
                           isShowLoad:NO
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                               block(posts,code,errorMsg);
                           }];
}

+ (void)passwordUserName:(NSString*)userName
                password:(NSString*)pwd
                  verify:(NSString*)verify
                   block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    NSDictionary *dic = @{@"method" : Method_Put,
                          @"action" : @"find",
                          @"type": @"mobile",
                          @"verify" : verify,
                          @"account" : userName,
                          @"password" : pwd,
                          };

    [AFAppDotNetAPIClient dealWithNet:@"password"
                                param:dic
                           isShowLoad:NO
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                               block(posts,code,errorMsg);
                           }];
}

+ (void)passwordPassword:(NSString*)pwd
             oldPawwsord:(NSString*)oldPwd
                   block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    NSDictionary *dic = @{@"method" : Method_Post,
                          @"action" : @"change",
                          @"old_password": oldPwd,
                          @"password" : pwd,
                          };
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    NSString *openId = [[AppCacheData shareCachData] getOpen_id];
    if([openId isNoEmpty]) {
        [muDic setObject:openId forKey:@"open_id"];
    }
    [AFAppDotNetAPIClient dealWithNet:@"password"
                                param:muDic
                           isShowLoad:NO
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                               block(posts,code,errorMsg);
                           }];
}

+ (void)checkAccount:(NSString*)account
               block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    NSDictionary *dic = @{@"method" : Method_Get,
                          @"action" : @"checkAccount",
                          @"type" : @"mobile",
                          @"account" : account,
                          };
    
    [AFAppDotNetAPIClient dealWithNet:@"checking"
                                param:dic
                           isShowLoad:YES
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                               block(posts,code,errorMsg);
                           }];
}

+ (void)oauthAccountType:(NSString*)type
             auth_result:(NSDictionary*)result
                   block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    NSDictionary *dic = @{@"method" : Method_Post,
                          @"auth_result" : result,
                          @"type" : type,
                          };
    
    [AFAppDotNetAPIClient dealWithNet:@"oauth"
                                param:dic
                           isShowLoad:YES
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                               block(posts,code,errorMsg);
                           }];
}

+ (void)bindAccountType:(NSString*)type
            auth_result:(NSString*)auth_result
              user_info:(NSString*)user_info
               username:(NSString*)username
               password:(NSString*)password
                  block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    
    NSDictionary *dic = @{@"method" : Method_Post,
                          @"type" : type,
                          @"auth_result" : auth_result,
                          @"user_info" : user_info,
                          @"bind_info" : @"1",
                          @"username" : username,
                          @"password" : password
                          };
    
    [AFAppDotNetAPIClient dealWithNet:@"oauth_sync"
                                param:dic
                           isShowLoad:YES
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                               block(posts,code,errorMsg);
                           }];
}
@end
