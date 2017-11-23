//
//  MyNet.m
//  sevenGo
//
//  Created by zhengkai on 2017/10/18.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "MyNet.h"
#import "AFAppDotNetAPIClient.h"
#import "AppCacheData.h"

@implementation MyNet

+ (void)userDataBlock:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    
    NSDictionary *dic = @{@"method" : Method_Get,
                          @"account" : [[AppCacheData shareCachData] getU_id],
                          };
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    NSString *openId = [[AppCacheData shareCachData] getOpen_id];
    if([openId isNoEmpty]) {
        [muDic setObject:openId forKey:@"open_id"];
    }
    
    NSString *uId = [[AppCacheData shareCachData] getU_id];
    if([uId isNoEmpty]) {
        [muDic setObject:uId forKey:@"id"];

    }
    
    [AFAppDotNetAPIClient dealWithNet:@"user_data"
                                param:muDic
                           isShowLoad:NO
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                                    if(code == 200) {
                                        NSDictionary *dicData = posts[@"data"];
                                        NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithDictionary:dicData];
                                        [muDic setObject:dicData[@"avatar"][@"avatar128"] forKey:@"avatar128"];
                                        [muDic setObject:dicData[@"show_role"] forKey:@"role_id"];
                                        if([dicData.allKeys containsObject:@"company"]) {
                                            [muDic setObject:dicData[@"company"][@"id"] forKey:@"computer_name"];
                                            [muDic setObject:dicData[@"company"][@"title"] forKey:@"computer_id"];
                                        } else {
                                            [muDic setObject:@"" forKey:@"computer_name"];
                                            [muDic setObject:@"" forKey:@"computer_id"];
                                        }
                                        UserViewMode *user = [UserViewMode modelWithDictionary:muDic];
                                        [[AppCacheData shareCachData] setAllUserMessage:user];
                                    }
                           }];
}
@end
