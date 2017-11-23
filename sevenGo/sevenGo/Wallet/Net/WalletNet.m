//
//  WalletNet.m
//  sevenGo
//
//  Created by zhengkai on 2017/10/20.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "WalletNet.h"
#import "AFAppDotNetAPIClient.h"
#import "AppCacheData.h"
#import "AppDelegate.h"
#import "LCProgressHUD.h"

@implementation WalletNet

+ (void)getwalletListPage:(NSInteger)page
                    block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    
    NSString *open_id = [[AppCacheData shareCachData] getOpen_id];
    if(open_id && [open_id isEmpty]) {
        [LCProgressHUD showFailure:@"未登录"];
        return;
    }
    
    NSDictionary *dic = @{@"open_id" : [[AppCacheData shareCachData] getOpen_id],
                          @"payok" : @"2",
                          @"page" : [NSNumber numberWithInteger:page],
                          @"method" : Method_Get,
                          };
    
    [AFAppDotNetAPIClient dealWithNet:@"wallet_list"
                                param:dic
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                                    block(posts,code,errorMsg);
                                }];
}

+ (void)getScorelogListPage:(NSInteger)page
                      block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    
    NSString *open_id = [AFAppDotNetAPIClient getOpenId];
    if([open_id isEmpty]) {
        return;
    }
    
    NSDictionary *dic = @{@"open_id" : open_id,
                          @"payok" : @"1",
                          @"page" : [NSNumber numberWithInteger:page],
                          @"method" : Method_Get,
                          };
    
    [AFAppDotNetAPIClient dealWithNet:@"scorelog"
                                param:dic
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                                    block(posts,code,errorMsg);
                                }];
    
}

+ (void)wallet_orderHas_gift:(BOOL)has_Gift
                      amount:(CGFloat)money
                     channel:(NSString*)channel //支付通道，alipay：支付宝、wxpay：微信
                       block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    NSString *open_id = [AFAppDotNetAPIClient getOpenId];
    if([open_id isEmpty]) {
        return;
    }
    
    NSDictionary *dic = @{@"open_id" : open_id,
                          @"field" : @"1",
                          @"has_gift" : [NSNumber numberWithBool:has_Gift],
                          @"amount" : [NSNumber numberWithFloat:money],
                          @"channel" : channel,
                          @"method" : Method_Post,
                          };
    
    [AFAppDotNetAPIClient dealWithNet:@"wallet_order"
                                param:dic
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                                    block(posts,code,errorMsg);
                                }];
}
+ (void)friends_scorePage:(NSInteger)page
                    block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    
    NSString *open_id = [AFAppDotNetAPIClient getOpenId];
    if([open_id isEmpty]) {
        return;
    }
    
    NSDictionary *dic = @{@"open_id" : open_id,
                          @"page" : [NSNumber numberWithInteger:page],
                          @"method" : Method_Get,
                          };
    
    [AFAppDotNetAPIClient dealWithNet:@"friends_score"
                                param:dic
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                                    block(posts,code,errorMsg);
                                }];
}

@end
