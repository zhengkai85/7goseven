//
//  BMNet.m
//  sevenGo
//
//  Created by zhengkai on 2017/11/20.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "BMNet.h"
#import "AppCacheData.h"
#import "AFAppDotNetAPIClient.h"

@implementation BMNet

+ (void)getBidCategoryBlock:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    
    NSDictionary *dic = @{@"method" : Method_Get,
                          };
    [AFAppDotNetAPIClient dealWithNet:@"bid_category"
                                param:dic
                           isShowLoad:NO
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                                    block(posts,code,errorMsg);
                           }];
    
}



+ (void)getBidGoodsListState:(NSInteger)state
                        page:(NSInteger)page
                       block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    
    NSDictionary *dic = @{@"method" : Method_Get,
                          @"status" : [NSNumber numberWithInteger:state],
                          @"page"   : [NSNumber numberWithInteger:page],
                          };
    
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithDictionary:dic];

    NSString *openid = [[AppCacheData shareCachData] getOpen_id];
    if([openid isNoEmpty]) {
        [muDic setObject:openid forKey:@"open_id"];
    }
    
    
    [AFAppDotNetAPIClient dealWithNet:@"bid_goods_list"
                                param:muDic
                           isShowLoad:NO
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                               block(posts,code,errorMsg);
                           }];
}

+ (void)addBidGoodsTitle:(NSString*)title  //商品名称
                     cid:(NSInteger)cid    //品分类，只允许传入二级分类ID
                   image:(NSString*)images  //商品图片 (690px800px)集合，最多设置20个，例如：1,2,3
              product_id:(NSString*)product_id //商品编号
                  notice:(NSString*)notice   //拍品须知
                 content:(NSString*)content   //商品详情
               bid_class:(NSString*)bid_class  //拍卖分类：1-样版拍, 2-批量拍, 3-拍卖会
              start_nums:(NSString*)start_nums  //起拍参与人数，当bid_class=3时必传，其他无效
              start_time:(NSString*)start_time  //开始时间，时间戳，默认值：当前时间
                end_time:(NSString*)end_time    //结束时间，时间戳，默认值：当前时间 1天
             start_price:(NSInteger)start_price //起拍价，正整数
            retain_price:(NSInteger)retain_price //保留价，正整数，竞拍模式下，若没人出价大于等于保留价，拍卖会流拍
               end_price:(NSInteger)end_price  //一口价，正整数，竞拍模式下，一口价直接拍下
  market_reference_price:(NSInteger)market_reference_price  //市场参考价，正整数，仅用于展示
              step_price:(NSInteger)step_price  //每次加价幅度，竞拍模式下有效，必须为5的整数倍，默认值：5
                 deposit:(NSInteger)deposit  //竞拍保证金，正整数，竞拍模式下有效
              appdendDic:(NSDictionary*)appendDic
                   block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    
    NSDictionary *dic = @{@"method" : Method_Get,
                          @"title" : title,
                          @"cid"   : [NSNumber numberWithInteger:cid],
                          @"image" : images,
                          @"product_id" : product_id,
                          @"notice" : notice,
                          @"content" : content,
                          @"bid_class" : bid_class,
                          @"start_nums" : start_nums,
                          @"start_time" : start_time,
                          @"end_time" : end_time,
                          @"start_price" : [NSNumber numberWithInteger:start_price],
                          @"retain_price" : [NSNumber numberWithInteger:retain_price],
                          @"end_price" : [NSNumber numberWithInteger:end_price],
                          @"market_reference_price": [NSNumber numberWithInteger:market_reference_price],
                          @"step_price" : [NSNumber numberWithInteger:step_price],
                          @"deposit" : [NSNumber numberWithInteger:deposit],
                          };
    
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    [muDic addEntriesFromDictionary:appendDic];
    
    NSString *openid = [[AppCacheData shareCachData] getOpen_id];
    if([openid isNoEmpty]) {
        [muDic setObject:openid forKey:@"open_id"];
    }
    
        
    [AFAppDotNetAPIClient dealWithNet:@"bid_goods_list"
                                param:muDic
                           isShowLoad:NO
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                               block(posts,code,errorMsg);
                           }];
}


+ (void)changeBidGoods:(NSString*)bid
                 title:(NSString*)title  //商品名称
                   cid:(NSInteger)cid    //品分类，只允许传入二级分类ID
                   image:(NSString*)images  //商品图片 (690px800px)集合，最多设置20个，例如：1,2,3
              product_id:(NSString*)product_id //商品编号
                  notice:(NSString*)notice   //拍品须知
                 content:(NSString*)content   //商品详情
               bid_class:(NSString*)bid_class  //拍卖分类：1-样版拍, 2-批量拍, 3-拍卖会
              start_nums:(NSString*)start_nums  //起拍参与人数，当bid_class=3时必传，其他无效
              start_time:(NSString*)start_time  //开始时间，时间戳，默认值：当前时间
                end_time:(NSString*)end_time    //结束时间，时间戳，默认值：当前时间 1天
             start_price:(NSInteger)start_price //起拍价，正整数
            retain_price:(NSInteger)retain_price //保留价，正整数，竞拍模式下，若没人出价大于等于保留价，拍卖会流拍
               end_price:(NSInteger)end_price  //一口价，正整数，竞拍模式下，一口价直接拍下
  market_reference_price:(NSInteger)market_reference_price  //市场参考价，正整数，仅用于展示
              step_price:(NSInteger)step_price  //每次加价幅度，竞拍模式下有效，必须为5的整数倍，默认值：5
                 deposit:(NSInteger)deposit  //竞拍保证金，正整数，竞拍模式下有效
              appdendDic:(NSDictionary*)appendDic
                   block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    
    NSDictionary *dic = @{@"method" : Method_Get,
                          @"title" : title,
                          @"cid"   : [NSNumber numberWithInteger:cid],
                          @"image" : images,
                          @"product_id" : product_id,
                          @"notice" : notice,
                          @"content" : content,
                          @"bid_class" : bid_class,
                          @"start_nums" : start_nums,
                          @"start_time" : start_time,
                          @"end_time" : end_time,
                          @"start_price" : [NSNumber numberWithInteger:start_price],
                          @"retain_price" : [NSNumber numberWithInteger:retain_price],
                          @"end_price" : [NSNumber numberWithInteger:end_price],
                          @"market_reference_price": [NSNumber numberWithInteger:market_reference_price],
                          @"step_price" : [NSNumber numberWithInteger:step_price],
                          @"deposit" : [NSNumber numberWithInteger:deposit],
                          };
    
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    [muDic addEntriesFromDictionary:appendDic];
    
    NSString *openid = [[AppCacheData shareCachData] getOpen_id];
    if([openid isNoEmpty]) {
        [muDic setObject:openid forKey:@"open_id"];
    }
    
    
    [AFAppDotNetAPIClient dealWithNet:[NSString stringWithFormat:@"bid_goods/%@",bid]
                                param:muDic
                           isShowLoad:NO
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                               block(posts,code,errorMsg);
                           }];
}


+ (void)changeBidState:(NSString*)pId
                status:(NSInteger)status  //商品状态：1-上架、0-下架
                 block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    NSDictionary *dic = @{@"method" : Method_Put,
                          @"status" : [NSNumber numberWithInteger:status],
                          };
    
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    
    NSString *openid = [[AppCacheData shareCachData] getOpen_id];
    if([openid isNoEmpty]) {
        [muDic setObject:openid forKey:@"open_id"];
    }
    
    
    [AFAppDotNetAPIClient dealWithNet:[NSString stringWithFormat:@"bid_goods_status/%@",pId]
                                param:muDic
                           isShowLoad:NO
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                               block(posts,code,errorMsg);
                           }];
}

+ (void)getBidOrderListState:(NSInteger)state  //订单状态：1-新订单,2-已付款,3-已发货,4-已成交,5-已取消,6-已失败，默认值：1
                        page:(NSInteger)page
                       block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    
    NSDictionary *dic = @{@"method" : Method_Get,
                          @"status" : [NSNumber numberWithInteger:state],
                          @"page" : [NSNumber numberWithInteger:page],
                          };
    
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    
    NSString *openid = [[AppCacheData shareCachData] getOpen_id];
    if([openid isNoEmpty]) {
        [muDic setObject:openid forKey:@"open_id"];
    }
    
    
    [AFAppDotNetAPIClient dealWithNet:@"bid_order_list"
                                param:muDic
                           isShowLoad:NO
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                               block(posts,code,errorMsg);
                           }];
}

+ (void)getBidOrderDetail:(NSString*)bid
                    block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    
    
    NSDictionary *dic = @{@"method" : Method_Get,
                          };
    
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    
    NSString *openid = [[AppCacheData shareCachData] getOpen_id];
    if([openid isNoEmpty]) {
        [muDic setObject:openid forKey:@"open_id"];
    }
    
    
    [AFAppDotNetAPIClient dealWithNet:[NSString stringWithFormat:@"bid_order_detail/%@",bid]
                                param:muDic
                           isShowLoad:NO
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                               block(posts,code,errorMsg);
                           }];
}

+ (void)getBidExpresCompanyBlock:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    
    NSDictionary *dic = @{@"method" : Method_Get,
                          };
    [AFAppDotNetAPIClient dealWithNet:@"bid_express_company"
                                param:dic
                           isShowLoad:NO
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                                    block(posts,code,errorMsg);
                                }];
}

+ (void)changeBidOrderStatus:(NSString*)orderid
                  kd_company:(NSString*)kd_company
                   kd_number:(NSString*)kd_number
                       block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    NSDictionary *dic = @{@"method" : Method_Put,
                          @"kd_company" : kd_company,
                          @"kd_number" : kd_number,
                          };
    
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    
    NSString *openid = [[AppCacheData shareCachData] getOpen_id];
    if([openid isNoEmpty]) {
        [muDic setObject:openid forKey:@"open_id"];
    }
    
    
    [AFAppDotNetAPIClient dealWithNet:[NSString stringWithFormat:@"bid_order_status/%@",orderid]
                                param:muDic
                           isShowLoad:NO
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                                    block(posts,code,errorMsg);
                                }];
}

+ (void)getBidShopCcorePage:(NSInteger)page
                      block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    NSDictionary *dic = @{@"method" : Method_Get,
                          @"page" : [NSNumber numberWithInteger:page],
                          @"type" : @"1",
                          };
    
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    
    NSString *openid = [[AppCacheData shareCachData] getOpen_id];
    if([openid isNoEmpty]) {
        [muDic setObject:openid forKey:@"open_id"];
    }
    
    
    [AFAppDotNetAPIClient dealWithNet:@"bid_shop_score"
                                param:muDic
                           isShowLoad:NO
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                                    block(posts,code,errorMsg);
                                }];
}
@end
