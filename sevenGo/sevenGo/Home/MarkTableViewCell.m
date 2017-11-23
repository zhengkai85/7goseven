//
//  MarkTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 2017/9/26.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "MarkTableViewCell.h"
static NSString *cellIdentifier          = @"MarkTableViewCell.h";

@implementation MarkTableViewCell

- (void)setViewMode:(HomeViewMode*)viewModel
             height:(CGFloat)height {
    
    [super setViewMode:viewModel height:height];
    
    self.arrDataSource = viewModel.arrBrand;
    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:cellIdentifier];
    
    [RACObserve(viewModel, arrBrand) subscribeNext:^(id x) {
        [self.collectionView reloadData];
    }];
}
@end
