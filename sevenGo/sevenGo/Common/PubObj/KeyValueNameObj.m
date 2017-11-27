//
//  KeyValueNameObj.m
//  sevenGo
//
//  Created by zhengkai on 2017/11/27.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "KeyValueNameObj.h"

@implementation KeyValueNameObj

- (instancetype)initWithKey:(NSString*)key
                      vlaue:(NSString*)value
                       name:(NSString*)name {
    self = [super init];
    if (self) {
        self.key = key;
        self.value = value;
        self.name = name;
    }
    return self;
}
@end
