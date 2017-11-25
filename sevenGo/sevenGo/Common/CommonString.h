//
//  CommonString.h
//  dream
//
//  Created by zhengkai on 15/1/31.
//  Copyright (c) 2015年 zhengkai. All rights reserved.
//

#import <Foundation/Foundation.h>


#ifdef DEBUG
#define PPLog(...) printf("[%s] %s [第%d行]: %s\n", __TIME__ ,__PRETTY_FUNCTION__ ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define PPLog(...)
#endif


/**
 Create a UIColor with r,g,b values between 0.0 and 1.0.
 */
#define RGBCOLOR(r,g,b) \
[UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.f]

/**
 Create a UIColor with r,g,b,a values between 0.0 and 1.0.
 */
#define RGBACOLOR(r,g,b,a) \
[UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a]



#define HEXCOLOR(hexValue) \
[UIColor colorWithRed:((CGFloat)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((CGFloat)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((CGFloat)(hexValue & 0xFF))/255.0 alpha:1.0] \

#define HEXACOLOR(hexValue,alpha) \
[UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((CGFloat)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((CGFloat)(hexValue & 0xFF))/255.0 alpha:alpha] \


#define DOWN_KEYBOARD  [[[UIApplication sharedApplication] keyWindow] endEditing:YES];


#define NetAPI                      @"http://test.7gomall.com/api/"
#define NetH5                       @"https://h5.7gomall.com/iQiGou/h5"
#define NetH5Get                    @"https://h5.7gomall.com"


#define APPVERSION                  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define APPID                       1101558323

#define APPDown                     @"http://a.app.qq.com/o/simple.jsp?pkgname=com.store.screen"
#define APPCODE                     @"PT_O2O_APP"

#define UMAppID              @"56ef5210e0f55a9723001518"
#define ShareQQAppId         @"1106039596"
#define ShareQQKey           @"fudl0hsZJYz3WGCm"
#define ShareSinaWeibo       @"2453906686"
#define ShareSinaWeiboSecret @"9b2b42e3c3eb55f8e8ad27ee0b112467"
#define ShareSinaRedirect    @"http://sns.whalecloud.com/sina2/callback"
#define ShareWeixinAppID     @"wx7bf00ee84b6b20ec"
#define ShareWeixinAppSecret @"f6514d04924372b52acfe79861c02298"
#define BAIDUKEY             @"KmKKvOPHA6Rf3wd4TbZV1VFrQKBu5UVU"



#define STRING_NOTIFICATION_LOINGCHANGE     @"Nofification_LoginChange"
#define STRING_NOTIFICATION_OPENMENU        @"Nofification_OpenMenu"


#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]



#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define STATUS_BAR_HEIGHT        [[UIApplication sharedApplication] statusBarFrame].size.height //系统状态栏高度
#define NAVIGATION_BAR_HEIGHT     44 //导航状态栏高度
#define TAB_BAR_HEIGHT           ((AppDelegate *)([[UIApplication sharedApplication] delegate])).tabBarController.tabBar.bounds.size.height //底部栏高度
#define TOP_HEIGHT               (STATUS_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT)
#define PADDING                 10
#define kHeaderViewTop          40
#define Def_TableViewCellHeight     50
#define PageSize                    20

#define COLOR_NAV              HEXCOLOR(0x9231a6)
#define COLOR_TEXT             HEXCOLOR(0x171717)
#define COLOR_DETAIL           HEXCOLOR(0x9e9da3)
#define COLOR_LINECOLOR        HEXCOLOR(0xe2e1e9)
#define COLOR_TABARVIEWGRAY    HEXCOLOR(0xf0Eff5)
//#define COLOR_GREEN            RGBCOLOR(80,200,86)
//#define COLOR_BLUE             RGBCOLOR(12,60,97)
#define COLOR_BLACK            RGBCOLOR(56,56,56)
//#define COLOR_ORANGE           RGBCOLOR(253,135,67)
//#define COLOR_YELLOR           RGBCOLOR(251,168,40)
#define COLOR_RED              HEXCOLOR(0xff4f00)
//#define COLOR_BOTTOMCELL       RGBCOLOR(248, 249, 251)

#define Nofification_PaySucess           @"Nofification_PaySucess"


@interface CommonString : NSObject

@end
