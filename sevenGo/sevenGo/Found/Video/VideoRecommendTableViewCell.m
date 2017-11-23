//
//  VideoRecommendTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 2017/9/29.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "VideoRecommendTableViewCell.h"

@interface VideoRecommendTableViewCell ()
@property (nonatomic, strong) IBOutlet UILabel *lblTitle;
@property (nonatomic, strong) IBOutlet UILabel *lblFrome;
@property (nonatomic, strong) IBOutlet UILabel *lblComment;
@property (nonatomic, strong) IBOutlet UIImageView *lblCover;
@property (strong, nonatomic) VideoViewMode *viewModel;

@end

@implementation VideoRecommendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setViewMode:(VideoViewMode*)viewModel {
    if(viewModel) {
        self.viewModel = viewModel;
        
        @weakify(self);
        RAC(self.lblTitle, text) = RACObserve(self,viewModel.title);
        RAC(self.lblFrome, text) = RACObserve(self,viewModel.source);
        RAC(self.lblComment, text) = RACObserve(self,viewModel.commetCount);

        [RACObserve(self, viewModel.creater_avatar) subscribeNext:^(NSString *title) {
            @strongify(self);
            [self.lblCover setImageURL:[NSURL URLWithString:self.viewModel.cover_url]];
        }];
    }
}


@end
