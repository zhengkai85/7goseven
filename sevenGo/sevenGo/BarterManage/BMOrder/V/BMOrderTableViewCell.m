//
//  BMOrderTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 2017/11/24.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "BMOrderTableViewCell.h"

@interface BMOrderTableViewCell ()

@property (nonatomic, strong)IBOutlet UIImageView *imgBodyIcon;
@property (nonatomic, strong)IBOutlet UILabel *lblBodyTitle;
@property (nonatomic, strong)IBOutlet UILabel *lblBodyContet;

@end

@implementation BMOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lblBodyTitle.font = [UIFont systemFontOfSize:13];
    self.lblBodyContet.font = [UIFont systemFontOfSize:11];
    self.lblBodyTitle.textColor = COLOR_TEXT;
    self.lblBodyContet.textColor = COLOR_DETAIL;
    
}

- (void)drawWithObj:(BMOrderObj*)obj {
    self.lblBodyTitle.text = obj.goods_title;
    NSString *heard = @"成交价格：";
    
    self.lblBodyContet.text = [NSString stringWithFormat:@"%@%@",heard,obj.price];
    [self.lblBodyContet addAttributedColor:COLOR_RED
                                      Font:[UIFont systemFontOfSize:13]
                                     range:NSMakeRange(0, heard.length)];
    
}

+ (CGFloat)getCellHeigt {
    return 90;
}
@end
