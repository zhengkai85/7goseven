//
//  HomeMode.m
//  sevenGo
//
//  Created by zhengkai on 17/9/18.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "HomeMode.h"

@implementation HomeMode
- (instancetype)initWithTitle:(NSString*)title
                     subtitle:(NSString*)subTitle
                          url:(NSString*)url {
    
    self = [super init];
    if(self) {
        self.title = title;
        self.subtitle = subTitle;
        self.url = url;
    }
    return self;
}
@end
