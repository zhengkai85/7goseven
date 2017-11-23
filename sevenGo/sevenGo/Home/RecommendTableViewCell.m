//
//  RecommendTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 2017/9/26.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "RecommendTableViewCell.h"

@interface RecommendTableViewCell ()
@property (nonatomic, strong) HomeViewMode *homeViewMode;
@property (nonatomic, assign) CGFloat viewHeight;
@property (nonatomic, strong) NSArray *arrDataSource;

@end

@implementation RecommendTableViewCell

- (void)setViewMode:(HomeViewMode*)viewModel
             height:(CGFloat)height
              index:(NSInteger)index {
    
    self.homeViewMode = viewModel;
    self.viewHeight = height;
    self.arrDataSource = viewModel.arrRecommend;
    NSInteger tag = 1000;
    UIImageView *imgCover = (UIImageView*)[self.contentView viewWithTag:++tag];
    if(!imgCover) {
        imgCover = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, self.viewHeight - 70)];
        imgCover.tag = tag;
        imgCover.layer.cornerRadius = 4;
        imgCover.clipsToBounds = YES;
        [self.contentView addSubview:imgCover];
    }
    
    UILabel *lblTitle = (UILabel *)[self.contentView viewWithTag:++tag];
    if(!lblTitle) {
        lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(imgCover.left, imgCover.bottom+15, imgCover.width, 12)];
        lblTitle.tag = tag;
        lblTitle.font = [UIFont systemFontOfSize:13];
        lblTitle.textColor = COLOR_TEXT;
        lblTitle.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:lblTitle];
    }
    
    UILabel *lblContnet = (UILabel*)[self.contentView viewWithTag:++tag];
    if(!lblContnet) {
        lblContnet = [[UILabel alloc] initWithFrame:CGRectMake(lblTitle.left,
                                                               lblTitle.bottom + 10,
                                                               lblTitle.width,
                                                               13)];
        lblContnet.tag = tag;
        lblContnet.font = [UIFont systemFontOfSize:11];
        lblContnet.textColor = COLOR_DETAIL;
        [self.contentView addSubview:lblContnet];
    }
    
    HomeMode *mode = self.arrDataSource[index];
    [imgCover setImageURL:[NSURL URLWithString:mode.pic]];
    lblTitle.text = mode.title;
    lblContnet.text = mode.subtitle;
    
}


@end
