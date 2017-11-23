//
//  PubFunction.m
//  dream
//
//  Created by zhengkai on 14/12/8.
//  Copyright (c) 2014年 zhengkai. All rights reserved.
//

#import "PubFunction.h"
#import "LCProgressHUD.h"
#import "AFNetworkReachabilityManager.h"

#define NOImageTag 2000
#define NOLableTag 2001

@implementation PubFunction

+ (NSString*)getHtmlString:(NSString*)str {    
    str = [str stringByReplacingOccurrencesOfString:@"&quot;" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    str = [str stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    str = [str stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    str = [str stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    return str;
}


+ (UIViewController *)getCurrentVC {
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}



+ (NSString*)getNewTelString:(NSString*)strTelephoner {
    
    NSString *newString = strTelephoner;
    if(strTelephoner.length > 7) {
        NSString *headString = [strTelephoner substringToIndex:3];
        NSString *footString = [strTelephoner substringFromIndex:strTelephoner.length - 4];
        newString = [NSString stringWithFormat:@"%@****%@",headString,footString];
    }
    return newString;
}

+ (NSString*)getNewIdentityNumberString:(NSString *)strId {
    NSString *strIdentityNumber = strId;
    if(strIdentityNumber.length > 8) {
        NSString *headString = [strIdentityNumber substringToIndex:strIdentityNumber.length - 8];
        NSString *footString = [strIdentityNumber substringFromIndex:strIdentityNumber.length - 2];
        strIdentityNumber = [NSString stringWithFormat:@"%@******%@",headString,footString];
    } else {
        strIdentityNumber = strId;
    }
    return strIdentityNumber;
}


+ (void)isNetConnect:(netBlock)block {
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    __weak AFNetworkReachabilityManager *wManager = manager;
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status == AFNetworkReachabilityStatusNotReachable) {
            if(block) {
                block(NO);
            }
        } else {
            if(block) {
                block(YES);
            }
        }
        [wManager stopMonitoring];

    }];
    [manager startMonitoring];
}

+ (void)showNetErrorLocalStr:(NSString*)local
                   serverStr:(NSString*)error {
    
    if(error.length > 30 || error.length == 0) {
        [LCProgressHUD showMessage:local];
    } else {
        [LCProgressHUD showMessage:error];
    }
}

+ (BOOL)checkPhoneNum:(NSString*)phone {
    
    if(![phone isNoEmpty]) {
        [LCProgressHUD showMessage:@"手机号不能为空"];
        return NO;
    }
    
    if([phone length] != 11) {
        [LCProgressHUD showMessage:@"请输入合法的手机号"];
        return NO;
    }
    
    if(![[phone substringToIndex:1] isEqualToString:@"1"]) {
        [LCProgressHUD showMessage:@"请输入合法的手机号"];
        return NO;
    }
    return YES;
}

+ (BOOL)checkIdentityCard:(NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}




//获取当前系统时间的时间戳

#pragma mark - 获取当前时间的 时间戳

+(NSInteger)getNowTimestamp {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间
    NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue]*1000;
    
    return timeSp;
    
}



//将某个时间转化成 时间戳

#pragma mark - 将某个时间转化成 时间戳

+ (NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:formatTime];
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue]*1000;
    return timeSp;
    
}



//将某个时间戳转化成 时间

#pragma mark - 将某个时间戳转化成 时间

+(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp/1000];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
    
}


#pragma mark - 做间隔区域

+ (UIView*)getSpaceViewWithWithFrame:(CGRect)frame
                            haveLine:(BOOL)haveLine {
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = COLOR_TABARVIEWGRAY;
    
    if(haveLine) {
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        line1.backgroundColor = COLOR_LINECOLOR;
        [view addSubview:line1];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 0.7, SCREEN_WIDTH, 0.5)];
        line2.backgroundColor = COLOR_LINECOLOR;
        [view addSubview:line2];
    }
    return view;
}




@end
