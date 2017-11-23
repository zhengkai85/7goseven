//
//  BidTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 17/9/19.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "BidTableViewCell.h"
#import "RootCollectionView.h"

@interface BidTableViewCell () <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic, assign) CGFloat cellWidth;
@end


static NSString *cellIdentifier          = @"BidTableViewCell";

@implementation BidTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}

- (void)setViewMode:(HomeViewMode*)viewModel
             height:(CGFloat)height {
    
    [super setViewMode:viewModel height:height];
    self.cellWidth = height*2/3;
    self.arrDataSource = viewModel.arrBid;
    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:cellIdentifier];
    
    [RACObserve(viewModel, arrBanner) subscribeNext:^(id x) {
        [self.collectionView reloadData];
    }];
}

#pragma mark - collection delegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier
                                                                            forIndexPath:indexPath];
    NSInteger tag = 1000;
    UIImageView *imgCover = (UIImageView*)[cell.contentView viewWithTag:++tag];
    if(!imgCover) {
        imgCover = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.cellWidth-10, self.viewHeight - 75)];
        imgCover.tag = tag;
        imgCover.layer.cornerRadius = 4;
        imgCover.clipsToBounds = YES;
        [cell.contentView addSubview:imgCover];
    }
    
    UILabel *lblTitle = (UILabel *)[cell.contentView viewWithTag:++tag];
    if(!lblTitle) {
        lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(imgCover.left, imgCover.bottom+15, imgCover.width, 12)];
        lblTitle.tag = tag;
        lblTitle.font = [UIFont systemFontOfSize:13];
        lblTitle.textColor = COLOR_TEXT;
        lblTitle.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:lblTitle];
    }

    UIImageView *icon = (UIImageView *)[cell.contentView viewWithTag:++tag];
    if(!icon) {
        icon = [[UIImageView alloc] initWithFrame:CGRectMake(lblTitle.left+8, lblTitle.bottom+10, 11, 15)];
        icon.tag = tag;
        icon.image = [YYImage imageNamed:@"home_paimai.png"];
        [cell.contentView addSubview:icon];
        
    }

    UILabel *lblContnet = (UILabel*)[cell.contentView viewWithTag:++tag];

    if(!lblContnet) {
        lblContnet = [[UILabel alloc] initWithFrame:CGRectMake(icon.right,
                                                               icon.top,
                                                               imgCover.width-icon.right - 10,
                                                               icon.height)];
        lblContnet.tag = tag;
        lblContnet.font = [UIFont systemFontOfSize:11];
        lblContnet.textColor = COLOR_DETAIL;
        [cell.contentView addSubview:lblContnet];
    }

    HomeMode *mode = self.arrDataSource[indexPath.row];
    [imgCover setImageURL:[NSURL URLWithString:mode.pic]];
    lblTitle.text = mode.title;
    
    NSString *content = [NSString stringWithFormat:@"起拍价：%@个7币",mode.subtitle];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:content];
    [attString addAttribute:NSForegroundColorAttributeName value:COLOR_NAV
                      range:NSMakeRange(3, [mode.subtitle length])];
    lblContnet.attributedText = attString;
    lblContnet.textAlignment = NSTextAlignmentRight;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(self.cellWidth, self.viewHeight);
}

@end
