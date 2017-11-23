//
//  RootTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 2017/9/30.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "RootTableViewCell.h"

@implementation RootTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle =  UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
}

@end
