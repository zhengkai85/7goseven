//
//  AreaAddTag.m
//  sevenGo
//
//  Created by zhengkai on 2017/10/31.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "AreaAddTag.h"
#import "ReactiveCocoa.h"
#import "BlocksKit+UIKit.h"

@implementation AreaAddTag

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.layer.cornerRadius = 4.0;
        self.layer.borderWidth = 1.0;
        self.clipsToBounds = YES;
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:13];
        
        @weakify(self);
        [RACObserve(self, bSel) subscribeNext:^(id x) {
            @strongify(self);
            if([x boolValue]) {
                self.backgroundColor = COLOR_NAV;
                self.textColor = [UIColor whiteColor];
                self.layer.borderColor = COLOR_NAV.CGColor;
            } else {
                self.backgroundColor = [UIColor whiteColor];
                self.textColor = COLOR_DETAIL;
                self.layer.borderColor = COLOR_DETAIL.CGColor;
            }
        }];
        
        self.userInteractionEnabled = YES;
        [self bk_whenTapped:^{
            @strongify(self);
            self.bSel = !self.bSel;
        }];
        
        
    }
    return self;
}


@end
