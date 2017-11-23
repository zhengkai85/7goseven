//
//  LoginNet.h
//  sevenGo
//
//  Created by zhengkai on 2017/9/30.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginNet : NSObject

/* action
 reg：注册账号；
 find：找回密码；
 change：修改用户信息；
 */

/**
 发送验证码
 */
+ (void)verifyPhone:(NSString*)phone
             action:(NSString*)action
              block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;

/**
 登录
 */
+ (void)loginUserName:(NSString*)userName
             password:(NSString*)pwd
                block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;

/**
 注册
 */
+ (void)accountUserName:(NSString*)userName
               password:(NSString*)pwd
             reg_verify:(NSString*)reg_verify
                  block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;

/**
 忘记密码
 */
+ (void)passwordUserName:(NSString*)userName
                password:(NSString*)pwd
                  verify:(NSString*)verify
                   block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;


//忘记密码
+ (void)passwordPassword:(NSString*)pwd
             oldPawwsord:(NSString*)oldPwd
                   block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;

//验证帐号是否存在
+ (void)checkAccount:(NSString*)account
               block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;


//验证帐号是否存在 类型：qq、weixin
+ (void)oauthAccountType:(NSString*)type
             auth_result:(NSString*)result
                   block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;


/*
 auth_result: qq      userid             access_token
              weixin  unionid、openid    access_token
  user_info:  qq      ret、nickname、figureurl_qq_2、gender
              weixin  ret、nickname、headimgurl、sex
 */
//绑定 类型：qq、weixin
+ (void)bindAccountType:(NSString*)type
            auth_result:(NSString*)auth_result
              user_info:(NSString*)user_info
               username:(NSString*)username
               password:(NSString*)password
                  block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;


@end
