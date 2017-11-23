//
//  PaySelTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 2017/10/25.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "PaySelTableViewCell.h"

@implementation PaySelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lblTitle.textColor = COLOR_BLACK;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
