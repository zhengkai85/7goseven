//
//  BrandTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 2017/9/25.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "BrandTableViewCell.h"

static NSString *cellIdentifier          = @"BrandTableViewCell.h";

@interface BrandTableViewCell()
@property (nonatomic, assign) CGFloat cellWidth;
@end

@implementation BrandTableViewCell

- (void)setViewMode:(HomeViewMode*)viewModel
             height:(CGFloat)height {
    
    [super setViewMode:viewModel height:height];
    self.cellWidth = height*5/4;
    self.arrDataSource = viewModel.arrBrand;
    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:cellIdentifier];
    
    [RACObserve(viewModel, arrBrand) subscribeNext:^(id x) {
        [self.collectionView reloadData];
    }];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier
                                                                            forIndexPath:indexPath];
    NSInteger tag = 1000;
    UIImageView *imgCover = (UIImageView*)[cell.contentView viewWithTag:++tag];
    if(!imgCover) {
        imgCover = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.cellWidth-10, self.viewHeight - 70)];
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
    
    UILabel *lblContnet = (UILabel*)[cell.contentView viewWithTag:++tag];
    if(!lblContnet) {
        lblContnet = [[UILabel alloc] initWithFrame:CGRectMake(lblTitle.left,
                                                               lblTitle.bottom + 10,
                                                               lblTitle.width,
                                                               13)];
        lblContnet.tag = tag;
        lblContnet.font = [UIFont systemFontOfSize:11];
        lblContnet.textColor = COLOR_DETAIL;
        [cell.contentView addSubview:lblContnet];
    }
    
    HomeMode *mode = self.arrDataSource[indexPath.row];
    [imgCover setImageURL:[NSURL URLWithString:mode.pic]];
    lblTitle.text = mode.title;
    lblContnet.text = mode.subtitle;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(self.cellWidth, self.viewHeight);
}
@end
