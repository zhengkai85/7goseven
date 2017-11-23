//
//  CommentNet.h
//  sevenGo
//
//  Created by zhengkai on 2017/9/27.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlugNet : NSObject

/*
 评论列表
            app(appname)     mod(table)
 资讯        News             news
 活动        Event            event
 视频        Video            video
 公司        Company          company
 供求（商圈）  Quan             quan
*/
+ (void)getCommentListApp:(NSString*)app
                      mod:(NSString*)mod
                   row_id:(NSInteger)row_id
                     page:(NSInteger)page
                    block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;


//发布评论
+ (void)sendCommentApp:(NSString*)app
                   mod:(NSString*)mod
                row_id:(NSInteger)row_id
                   pid:(NSUInteger)pid
               content:(NSString*)content
                 block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;


//删除评论
+ (void)delComment:(NSInteger)command_id
               app:(NSString*)app
               mod:(NSString*)mod
            row_id:(NSInteger)row_id
             block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;


//用于获取我的收藏信息列表
+ (void)getCollectListApp:(NSString*)app
                      mod:(NSString*)mod
                     page:(NSInteger)page
                    block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;


//用于收藏/取消收藏某条信息
+ (void)changeCollectMegApp:(NSString*)app
                        mod:(NSString*)mod
                     row_id:(NSInteger)row_id
                      isAdd:(BOOL)add
                      block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;

//用于获取我的点赞信息列表
+ (void)getSupportListApp:(NSString*)app
                      mod:(NSString*)mod
                   row_id:(NSInteger)row_id
                    block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;

// 点赞/取消点赞
+ (void)changeSupportApp:(NSString*)app
                   table:(NSString*)table
                  row_id:(NSInteger)row_id
                   isAdd:(BOOL)add
                   block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;





@end
