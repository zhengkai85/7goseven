//
//  VideoTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 17/9/11.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "VideoTableViewCell.h"
#import "ReactiveCocoa.h"
#import "UIView+BlocksKit.h"

@interface VideoTableViewCell ()
@property (nonatomic, strong) IBOutlet UILabel *lblTitle;
@property (nonatomic, strong) IBOutlet UILabel *lblView;
@property (nonatomic, strong) IBOutlet UIImageView *imgCover;
@property (nonatomic, strong) IBOutlet UIImageView *imgAvatar;
@property (nonatomic, strong) IBOutlet UILabel *lblNickName;
@property (nonatomic, strong) IBOutlet UIButton *btnCommand;
@property (nonatomic, strong) IBOutlet UIButton *btnDetail;
@property (nonatomic, strong) IBOutlet UIView *viewBottom;

@end



@implementation VideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.btnCommand setImage:[YYImage imageNamed:@"video_talk"] forState:UIControlStateNormal];
    [self.btnDetail setImage:[YYImage imageNamed:@"video_moreMenu"] forState:UIControlStateNormal];
    [self.imgAvatar.layer setCornerRadius:self.imgAvatar.height/2];
    self.imgAvatar.layer.masksToBounds = YES;
    
    [self.imgCover setContentMode:UIViewContentModeScaleAspectFit];
    self.imgCover.backgroundColor = [UIColor blackColor];
    @weakify(self);
    RAC(self.lblTitle, text) = RACObserve(self,viewModel.title);
    RAC(self.lblView, text) = RACObserve(self, viewModel.viewCount);
    RAC(self.lblNickName, text) = RACObserve(self, viewModel.creater_nickName);
    [RACObserve(self, viewModel.cover_url) subscribeNext:^(NSString *title) {
        @strongify(self);
        [self.imgCover setImageURL:[NSURL URLWithString:self.viewModel.cover_url]];
    }];
    [RACObserve(self, viewModel.creater_avatar) subscribeNext:^(NSString *title) {
        @strongify(self);
        [self.imgAvatar setImageURL:[NSURL URLWithString:self.viewModel.creater_avatar]];
    }];
    
    [RACObserve(self, viewModel.comment) subscribeNext:^(NSString *title) {
        @strongify(self);
        [self.btnCommand setTitle:self.viewModel.comment forState:UIControlStateNormal];
    }];
    
    [self.viewBottom bk_whenTapped:^{
        if(self.selectBlock) {
            self.selectBlock();
        }
    }];
    
}



+ (CGFloat)getCellHeight {
    return SCREEN_WIDTH/1.7 + 40;
}
@end
