//
//  UIButton_Category.h
//  dream
//
//  Created by zhengkai on 14/12/21.
//  Copyright (c) 2014年 zhengkai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIButton (ButtonExtention)


/**
 *   设置圆角边框
 */
- (void)setRoundedBorder:(UIColor*)color;

/**
 *   设置图片和文字
 */
- (void) setImage:(UIImage *)image
        withTitle:(NSString *)title
         sizeFont:(UIFont*)font
       titleColor:(UIColor*)color
         forState:(UIControlState)stateType;

/**
 *   设置边框和文字
 */
- (void)setBorderTitle:(NSString *)title
              sizeFont:(UIFont*)font
                 color:(UIColor*)color;



@end
