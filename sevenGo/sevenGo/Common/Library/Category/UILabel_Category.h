//
//  UILabel_Category.h
//  dream
//
//  Created by zhengkai on 14/12/21.
//  Copyright (c) 2014年 zhengkai. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UILabel (LabelExtention)
/**
 *  自动设置宽度根据内容
 */
- (CGFloat)autoWidth;

/**
 *  自动设置高度根据内容
 *
 */
- (CGFloat)autoHeight;

/**
 *  添加行间距
 */
- (void)addLineOffSite;

/**
 *  设置多属性颜色
 */
- (void)addAttributedColor:(UIColor*)color
                      Font:(UIFont*)font
                     range:(NSRange)range;

/**
 *  设置html字符串
 */
- (void)setHtmlString:(NSString*)htmlString;

@end
