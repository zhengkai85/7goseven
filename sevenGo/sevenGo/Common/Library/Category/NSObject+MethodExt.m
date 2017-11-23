//
//  NSObject+MethodExt.m
//  ND91U
//
//  Created by devp on 14-1-14.
//  Copyright (c) 2014年 nd. All rights reserved.
//

#import "NSObject+MethodExt.h"

@implementation NSObject (MethodExt)

- (void)performBlock:(performBlock)block
          afterDelay:(NSTimeInterval)delay {
    block = [block copy];
    [self performSelector:@selector(doBlock:)
               withObject:block
               afterDelay:delay];
}

- (void)performBlock:(performBlock)block
            duration:(NSTimeInterval)duration {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelegate:self];
    block();
    [UIView commitAnimations];
}


- (void)doBlock:(performBlock)block {
    block();
}


- (BOOL)makesureDictionary:(BOOL)needAssert {
    if (![self isKindOfClass:[NSDictionary class]] &&
        ![self isKindOfClass:[NSMutableDictionary class]]) {
        if (needAssert) {
            NSAssert(NO, @"该元素非NSDictionary对象");
        }
        return NO;
    }
    return YES;
}

- (BOOL)isNoEmpty {
    
    if(!self) {
        return NO;
    } else if ([self isKindOfClass:[NSNull class]]) {
        return NO;
    }
    else if ([self isKindOfClass:[NSString class]]) {
        if([self isEqual:@" "] || [self isEqual:@""]) {
            return NO;
        } else {
            return [(NSString *)self length] > 0;
        }
    }
    else if ([self isKindOfClass:[NSData class]]){
        return [(NSData *)self length] > 0;
    }
    else if ([self isKindOfClass:[NSArray class]]) {
        return [(NSArray *)self count] > 0;
    }
    else if ([self isKindOfClass:[NSDictionary class]]) {
        return [(NSDictionary *)self count] > 0;
    }
    
    return YES;
}

- (BOOL)isEmpty {
    return ![self isNoEmpty];
}

@end
