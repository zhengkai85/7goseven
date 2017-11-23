//
//  AreaAddNet.h
//  sevenGo
//
//  Created by zhengkai on 2017/10/30.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaAddNet : NSObject

+ (void)quan_categoryBlock:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;


+ (void)quanImg:(NSData*)data
          block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;


+ (void)quanAddImgs:(NSArray*)imgs
        description:(NSString*)description
               tags:(NSString*)tag
                lng:(CGFloat)lng
                lat:(CGFloat)lat
           province:(NSInteger)province
               city:(NSInteger)city
            address:(NSString*)address
           position:(BOOL)position
              block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block;
@end
