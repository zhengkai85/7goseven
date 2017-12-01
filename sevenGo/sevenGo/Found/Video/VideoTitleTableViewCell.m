//
//  VideoTitleTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 2017/9/28.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "VideoTitleTableViewCell.h"
#import "PlugNet.h"
#import "GotoRoute.h"
#import "PubFunction.h"
@interface VideoTitleTableViewCell ()

@property (strong, nonatomic) VideoDetailViewMode *viewModel;

@property (assign, nonatomic) CGFloat cellHeight;


@property (nonatomic, strong) IBOutlet UILabel *lblTitle;
@property (nonatomic, strong) IBOutlet UILabel *lblView;
@property (nonatomic, strong) IBOutlet UIImageView *imgAvatar;
@property (nonatomic, strong) IBOutlet UILabel *lblNickName;
@property (nonatomic, strong) IBOutlet UILabel *lblAgree;
@property (nonatomic, strong) IBOutlet UILabel *lblCollect;
@end

@implementation VideoTitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lblTitle.font = [UIFont systemFontOfSize:13];
    self.lblView.font = [UIFont systemFontOfSize:11];
    self.lblNickName.font = [UIFont systemFontOfSize:13];
    self.lblAgree.font = self.lblCollect.font = [UIFont systemFontOfSize:11];
    
    self.lblTitle.textColor = COLOR_BLACK;
    self.lblView.textColor = COLOR_DETAIL;
    self.lblAgree.textColor = self.lblCollect.textColor = COLOR_TEXT;
    
    [self.imgAvatar.layer setCornerRadius:self.imgAvatar.height/2];
    self.imgAvatar.layer.masksToBounds = YES;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    

}

- (void)setViewMode:(VideoDetailViewMode*)viewModel
             height:(CGFloat)heigh {
    
    if(viewModel) {
        self.viewModel = viewModel;
        self.cellHeight = heigh;
        self.lblTitle.text = viewModel.title;
        self.lblView.text = viewModel.viewCount;
        self.lblNickName.text = viewModel.creater_nickName;
        self.lblAgree.text = viewModel.support;
        self.lblCollect.text = viewModel.collection;
        [self.imgAvatar setImageURL:[NSURL URLWithString:self.viewModel.creater_avatar]];
        
//        RAC(self.lblTitle, text) = RACObserve(self.viewModel,title);
//        RAC(self.lblView, text) = RACObserve(self.viewModel, viewCount);
//        RAC(self.lblNickName, text) = RACObserve(self.viewModel, creater_nickName);
//        RAC(self.lblAgree, text) = RACObserve(self.viewModel, support);
//        RAC(self.lblCollect, text) = RACObserve(self.viewModel, collection);
//        @weakify(self);
//        [RACObserve(self, viewModel.creater_avatar) subscribeNext:^(NSString *title) {
//            @strongify(self);
//            [self.imgAvatar setImageURL:[NSURL URLWithString:self.viewModel.creater_avatar]];
//        }];
    }
}

- (IBAction)doCollect:(id)sender {
    if([GotoRoute isLogin]) {
        return;
    }
    
    self.viewModel.is_collect = !self.viewModel.is_collect;
    if(self.viewModel.is_collect) {
        self.viewModel.collection = [NSString stringWithFormat:@"%ld",[self.viewModel.collection integerValue]+1];
    } else {
        self.viewModel.collection = [NSString stringWithFormat:@"%ld",[self.viewModel.collection integerValue]-1];
    }
    NSInteger row = [self.viewModel.videoID integerValue];
    [PlugNet changeCollectMegApp:@"Video"
                             mod:@"video"
                          row_id:row
                           isAdd:self.viewModel.is_collect
                           block:^(id posts, NSInteger code, NSString *errorMsg) {
                               if(code != 200) {
                                   [PubFunction showNetErrorLocalStr:@"操作失败" serverStr:errorMsg];
                                   if(self.viewModel.is_collect) {
                                       self.viewModel.collection = [NSString stringWithFormat:@"%ld",[self.viewModel.collection integerValue]-1];
                                   } else {
                                       self.viewModel.collection = [NSString stringWithFormat:@"%ld",[self.viewModel.collection integerValue]+1];
                                   }
                                   self.viewModel.is_collect = !self.viewModel.is_collect;

                               }
                           }];
    
}

- (IBAction)doSupport:(id)sender {
    if([GotoRoute isLogin]) {
        return;
    }
    
    if(self.viewModel.is_support) {
        self.viewModel.support = [NSString stringWithFormat:@"%ld",[self.viewModel.support integerValue]+1];
    } else {
        self.viewModel.support = [NSString stringWithFormat:@"%ld",[self.viewModel.support integerValue]-1];
    }
    self.viewModel.is_support = !self.viewModel.is_support;
    NSInteger row = [self.viewModel.videoID integerValue];
    [PlugNet changeSupportApp:@"Video"
                        table:@"video"
                       row_id:row
                        isAdd:self.viewModel.is_support
                        block:^(id posts, NSInteger code, NSString *errorMsg) {
                            if(code != 200) {
                                [PubFunction showNetErrorLocalStr:@"操作失败" serverStr:errorMsg];
                                if(self.viewModel.is_support) {
                                    self.viewModel.support = [NSString stringWithFormat:@"%ld",[self.viewModel.support integerValue]-1];
                                } else {
                                    self.viewModel.support = [NSString stringWithFormat:@"%ld",[self.viewModel.support integerValue]+1];
                                }
                                self.viewModel.is_support = !self.viewModel.is_support;
                            } else {
                            }
                        }];
}



@end
