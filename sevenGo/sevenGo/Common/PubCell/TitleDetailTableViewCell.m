//
//  TitleDetailTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 2017/10/25.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "TitleDetailTableViewCell.h"

@implementation TitleDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lblTitle.font = [UIFont systemFontOfSize:14];
    self.lblDetail.font = [UIFont systemFontOfSize:12];
    self.lblTitle.textColor = COLOR_TEXT;
    self.lblDetail.textColor = COLOR_DETAIL;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
