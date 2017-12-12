//
//  RecommendTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 2017/9/26.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "RecommendTableViewCell.h"
#import "AuctionMode.h"

@interface RecommendTableViewCell ()
@property (nonatomic, strong) AuctionViewMode *viewMode;
@property (nonatomic, assign) CGFloat viewHeight;
@property (nonatomic, strong) NSArray *arrDataSource;

@end

@implementation RecommendTableViewCell

- (void)setViewMode:(AuctionViewMode*)viewModel
             height:(CGFloat)height
              index:(NSInteger)index {
    
    self.viewMode = viewModel;
    self.viewHeight = height;
    self.arrDataSource = viewModel.arrMetting;
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
    
    UIButton *btnRecommend =(UIButton*)[self.contentView viewWithTag:++tag];
    if(!btnRecommend) {
        btnRecommend = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 120,
                                                                  lblTitle.bottom - 10,
                                                                  100,
                                                                  30)];
        btnRecommend.layer.cornerRadius = 4.0;
        [btnRecommend setBackgroundColor:COLOR_NAV];
        [btnRecommend setTitle:@"报名" forState:UIControlStateNormal];
        btnRecommend.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:btnRecommend];
    }
    
    AuctionMode *mode = self.arrDataSource[index];

    
    NSArray *arr = mode.image_list;
    if(arr.count>0) {
        NSString *url = arr[0][@"thumb"];
        [imgCover setImageURL:[NSURL URLWithString:url]];
    }
    lblTitle.text = mode.title;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[mode.end_time longLongValue]];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"MM-dd HH:mm"];
    lblContnet.text = [NSString stringWithFormat:@"开拍时间:%@",[objDateformat stringFromDate: date]];
    
}


@end
