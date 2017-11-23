//
//  TitleContentTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 2017/11/21.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "TitleContentTableViewCell.h"

@implementation TitleContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lblTitle.font = [UIFont systemFontOfSize:14];
    self.lblTitle.textColor = COLOR_TEXT;
    self.txtContent.font = [UIFont systemFontOfSize:14];
    self.txtContent.textColor = COLOR_TEXT;
    self.txtContent.textAlignment = NSTextAlignmentLeft;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
