//
//  VideoCommentTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 2017/9/29.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "VideoCommentTableViewCell.h"

@interface VideoCommentTableViewCell()
@property (nonatomic, strong) IBOutlet UIImageView *icon;
@property (nonatomic, strong) IBOutlet UILabel *lblTilte;
@property (nonatomic, strong) IBOutlet UILabel *lblContent;
@property (nonatomic, strong) IBOutlet UILabel *lblMessage;

@end

@implementation VideoCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setViewMode:(CommandViewMode*)viewModel {
    self.lblTilte.textColor = COLOR_NAV;
    self.icon.imageURL = [NSURL URLWithString:viewModel.creater_avatar];
    self.lblTilte.text = viewModel.creater_nickName;
    self.lblContent.text = viewModel.content;
    self.lblMessage.text = viewModel.create_time;
    
    
}
@end
