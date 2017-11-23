//
//  PubFunction.h
//  dream
//
//  Created by zhengkai on 14/12/8.
//  Copyright (c) 2014年 zhengkai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

typedef void(^netBlock)(BOOL bConnect);


@interface PubFunction : NSObject


/**
   获取html字符串
 */
+ (NSString*)getHtmlString:(NSString*)str;



/**
   电话号码验证
 */
+ (BOOL)checkPhoneNum:(NSString*)phone;



    
    
/**
 身份证验证
 */
+ (BOOL)checkIdentityCard:(NSString *)identityCard;



/**
   获得当前屏幕显示的viewcontroller
 */
+ (UIViewController *)getCurrentVC;




/**
 获得带星号的手机号
 */
+ (NSString*)getNewTelString:(NSString*)strTelephoner;


/**
 获得带星号的身份证
 */
+ (NSString*)getNewIdentityNumberString:(NSString*)strId;

/**
   是否连接网络
 */
+ (void)isNetConnect:(netBlock)block;

/**
   弹出错误消息,如果长度大于30用本地，否则用服务端
 */
+ (void)showNetErrorLocalStr:(NSString*)local
                   serverStr:(NSString*)error;


/**
 * 获取当前时间的 时间戳
 */
+ (NSInteger)getNowTimestamp;

/**
  将某个时间转化成 时间戳
 */
+ (NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;


/**
  将某个时间戳转化成 时间
 */
+ (NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;

/**
 获取间隔区域view
 */
+ (UIView*)getSpaceViewWithWithFrame:(CGRect)frame
                            haveLine:(BOOL)haveLine;
@end
