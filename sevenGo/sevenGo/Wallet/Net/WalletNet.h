//
//  WalletNet.h
//  sevenGo
//
//  Created by zhengkai on 2017/10/20.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WalletNet : NSObject

+ (void)getwalletListPage:(NSInteger)page
                    block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;


//获取积分变更记录
+ (void)getScorelogListPage:(NSInteger)page
                    block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;


+ (void)wallet_orderHas_gift:(BOOL)has_Gift
                      amount:(CGFloat)money
                     channel:(NSString*)channel //支付通道，alipay：支付宝、wxpay：微信
                       block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;

//获取好友邀请记录
+ (void)friends_scorePage:(NSInteger)page
                    block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;

@end
