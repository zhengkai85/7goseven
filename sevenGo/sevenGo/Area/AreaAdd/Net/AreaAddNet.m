//
//  AreaAddNet.m
//  sevenGo
//
//  Created by zhengkai on 2017/10/30.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "AreaAddNet.h"
#import "AFAppDotNetAPIClient.h"
#import "AppCacheData.h"

@implementation AreaAddNet

+ (void)quan_categoryBlock:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    
    NSDictionary *dic = @{@"method" : Method_Get};

    [AFAppDotNetAPIClient dealWithNet:@"quan_category"
                                param:dic
                           isShowLoad:NO
                           cacheBlock:^(id cache) {
                               block(cache,1,nil);
                           } block:^(id posts, NSInteger code, NSString *errorMsg) {
                                block(posts,code,errorMsg);
                            }];
}

+ (void)quanImg:(NSData*)data
          block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    
    NSDictionary *dic = @{@"method" : Method_Post,
                          @"data" : [data base64EncodedString],
                          @"ext" : @"jpg"
                          };
    
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    NSString *openId = [[AppCacheData shareCachData] getOpen_id];
    if([openId isNoEmpty]) {
        [muDic setObject:openId forKey:@"open_id"];
    }
    
    [AFAppDotNetAPIClient dealWithNet:@"picture"
                                param:muDic
                           isShowLoad:NO
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                                    block(posts,code,errorMsg);
                           }];
}

+ (void)quanAddImgs:(NSArray*)imgs
        description:(NSString*)description
               tags:(NSString*)tag
                lng:(CGFloat)lng
                lat:(CGFloat)lat
           province:(NSInteger)province
               city:(NSInteger)city
            address:(NSString*)address
           position:(BOOL)position
              block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    
    NSDictionary *dic = @{@"method" : Method_Post};
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    NSString *openId = [[AppCacheData shareCachData] getOpen_id];
    if([openId isNoEmpty]) {
        [muDic setObject:openId forKey:@"open_id"];
    }
    
    if([imgs isNoEmpty]) {
        [muDic setObject:imgs forKey:@"description"];
    }
    
    
    if([description isNoEmpty]) {
        [muDic setObject:description forKey:@"description"];
    }
    
    if([tag isNoEmpty]) {
        [muDic setObject:tag forKey:@"tags"];
    }
    
    if(lng != 0) {
        [muDic setObject:tag forKey:@"lng"];
    }
    
    if(lat != 0) {
        [muDic setObject:tag forKey:@"lat"];
    }
    
    if(province > 0) {
        [muDic setObject:[NSNumber numberWithInteger:province] forKey:@"province"];
    }
    
    if(city > 0) {
        [muDic setObject:[NSNumber numberWithInteger:city] forKey:@"city"];
    }
    
    if([address isNoEmpty]) {
        [muDic setObject:address forKey:@"address"];
    }
    
    [muDic setObject:[NSNumber numberWithBool:position] forKey:@"position"];
    
    [AFAppDotNetAPIClient dealWithNet:@"quan"
                                param:muDic
                           isShowLoad:NO
                                block:^(id posts, NSInteger code, NSString *errorMsg) {
                                    block(posts,code,errorMsg);
                                }];
    

}

@end
