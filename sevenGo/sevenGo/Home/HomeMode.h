//
//  HomeMode.h
//  sevenGo
//
//  Created by zhengkai on 17/9/18.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeMode : NSObject

- (instancetype)initWithTitle:(NSString*)title
                     subtitle:(NSString*)subTitle
                          url:(NSString*)url;

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@end
