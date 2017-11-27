//
//  KeyValueNameObj.h
//  sevenGo
//
//  Created by zhengkai on 2017/11/27.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyValueNameObj : NSObject
@property (nonatomic, strong)NSString *key;
@property (nonatomic, strong)NSString *value;
@property (nonatomic, strong)NSString *name;

- (instancetype)initWithKey:(NSString*)key
                      vlaue:(NSString*)value
                       name:(NSString*)name;
@end
