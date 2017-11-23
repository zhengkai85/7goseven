//
//  NSDictionary_Category.m
//  huimin
//
//  Created by zhengkai on 16/7/25.
//  Copyright © 2016年 zhengkai. All rights reserved.
//

#import "NSDictionary_Category.h"

@implementation NSDictionary (MethodExt)

- (NSString*)stringValue:(NSString*)key {
    
    if(!self) {
        return @"";
    }
    
    if([self.allKeys containsObject:key]) {
        id value = [self objectForKey:key];
        if([[value class] isKindOfClass:[NSNull class]]) {
            return @"";
        }
        else if([[value class] isKindOfClass:[NSNumber class]]) {
            return [NSString stringWithFormat:@"%ld",(long)[[self objectForKey:key] integerValue]];
        } else {
            return [NSString stringWithFormat:@"%@",value];
        }
    } else {
        return @"";
    }
    
    
}
@end
