//
//  VideoNoRecommendTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 2017/9/29.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "VideoNoRecommendTableViewCell.h"

@interface VideoNoRecommendTableViewCell ()
@property (nonatomic, strong) IBOutlet UILabel *lblTitle;
@property (nonatomic, strong) IBOutlet UIView *line1;
@property (nonatomic, strong) IBOutlet UIView *line2;
@end

@implementation VideoNoRecommendTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle =  UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.lblTitle.font = [UIFont systemFontOfSize:13];
    self.lblTitle.textColor = COLOR_TEXT;
    self.lblTitle.text = @"暂无推荐视频";
    self.line1.backgroundColor = self.line2.backgroundColor = COLOR_LINECOLOR;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
