//
//  UIButton_Category.m
//  dream
//
//  Created by zhengkai on 14/12/21.
//  Copyright (c) 2014年 zhengkai. All rights reserved.
//

#import "UIButton_Category.h"

@implementation UIButton(ButtonExtention)


- (void)setRoundedBorder:(UIColor*)color {
    CALayer *roundedLayer = [self layer];
    [roundedLayer setMasksToBounds:YES];
    roundedLayer.cornerRadius = 5.0;
    roundedLayer.borderColor = [color CGColor];
}

- (void) setImage:(UIImage *)image
        withTitle:(NSString *)title
         sizeFont:(UIFont*)font
       titleColor:(UIColor*)color
         forState:(UIControlState)stateType {
    
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGSize titleSize = [title sizeWithAttributes:attributes];
    [self.imageView setContentMode:UIViewContentModeCenter];
    
    [self setImageEdgeInsets:UIEdgeInsetsMake(-self.frame.size.height/3,
                                              0.0,
                                              0.0,
                                              -titleSize.width)];
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:font];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(40.0,
                                              -image.size.width,
                                              0.0,
                                              0.0)];
    [self setTitle:title forState:stateType];
    [self setTitleColor:color forState:stateType];
}


- (void)setBorderTitle:(NSString *)title
              sizeFont:(UIFont*)font
                 color:(UIColor*)color {
    
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateNormal];
    [self.titleLabel setFont:font];
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 2.0;
    self.layer.borderColor = color.CGColor;
}
@end
