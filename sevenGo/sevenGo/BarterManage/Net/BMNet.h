//
//  BMNet.h
//  sevenGo
//
//  Created by zhengkai on 2017/11/20.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMNet : NSObject

//用于获取拍卖商品分类
+ (void)getBidCategoryBlock:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;


//用于获取商家的商品列表
////1-拍卖中（竞拍中）、2-未审核（待上架）、3-已成交（已结拍）、4-已流拍（已失败）、5-已下架（已下架）、6-已失败（已失败）
+ (void)getBidGoodsListState:(NSInteger)state
                        page:(NSInteger)page
                       block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;

//发布商品
+ (void)addbidGoodsTitle:(NSString*)title  //商品名称
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
                   brand:(NSString*)brand //品牌
                   color:(NSString*)color //颜色
                    size:(NSString*)size  //尺码
                  season:(NSString*)season //适用季节
                   block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;
@end