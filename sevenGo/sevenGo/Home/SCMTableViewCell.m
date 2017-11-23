//
//  SCMTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 2017/9/26.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "SCMTableViewCell.h"

static NSString *cellIdentifier          = @"ScmTableViewCell";

@implementation SCMTableViewCell
- (void)setViewMode:(HomeViewMode*)viewModel
             height:(CGFloat)height {
    
    [super setViewMode:viewModel height:height];
    
    self.arrDataSource = viewModel.arrScm;
    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:cellIdentifier];
    
    [RACObserve(viewModel, arrScm) subscribeNext:^(id x) {
        [self.collectionView reloadData];
    }];
}
@end
