//
//  AreaAddTxtTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 2017/10/30.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "AreaAddTxtTableViewCell.h"
#import "UITextView+Placeholder.h"

@implementation AreaAddTxtTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if(!self.txt) {
            self.cellHeight = 60;
            self.txt = [[UITextView alloc] initWithFrame:CGRectMake(8, 0, SCREEN_WIDTH - 16, self.cellHeight)];
            self.txt.placeholder = @"我的供求...";
            self.txt.placeholderLabel.font = [UIFont systemFontOfSize:14];
            [self.contentView addSubview:self.txt];
        }
    }
    return self;
}
@end
