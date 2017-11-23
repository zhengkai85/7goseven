//
//  UILabel_Category.m
//  dream
//
//  Created by zhengkai on 14/12/21.
//  Copyright (c) 2014年 zhengkai. All rights reserved.
//

#import "UILabel_Category.h"

@implementation UILabel (LabelExtention)

- (CGFloat)autoWidth {
    if(!self.text && self.text.length == 0)
        return 0;
    
    CGRect rect = self.frame;
    CGRect textSize = [self.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGRectGetHeight(rect))
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{ NSFontAttributeName : self.font}
                                              context:nil];
    rect.size.width = textSize.size.width;
    self.frame = rect;
    return textSize.size.width;
}

- (CGFloat)autoHeight {
    
    CGRect rect = self.frame;
    CGRect textSize = [self.text boundingRectWithSize:CGSizeMake(CGRectGetWidth(rect), CGFLOAT_MAX)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{ NSFontAttributeName : self.font}
                                              context:nil];
    rect.size.height = textSize.size.height;
    self.frame = rect;
    return textSize.size.height;
}

- (void)addLineOffSite {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5.0];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
}

- (void)addAttributedColor:(UIColor*)color
                      Font:(UIFont*)font
                     range:(NSRange)range {
    
    if(self && self.text.length > 0) {
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:self.text];
        if(color) {
            [attri addAttribute:NSForegroundColorAttributeName value:color range:range];
        }
        if(font) {
            [attri addAttribute:NSFontAttributeName value:font range:range];
        }
        [self setAttributedText:attri];
    }
}

- (void)setHtmlString:(NSString*)htmlString {
    NSAttributedString * attrStr = [[NSAttributedString alloc]
                                    initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding]
                                    options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                    documentAttributes:nil error:nil];
    self.attributedText = attrStr;
}
@end
