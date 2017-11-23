//
//  ScrollViewTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 17/9/18.
//  Copyright © 2017年 zhengkai. All rights reserved.
//


#import "ScrollViewTableViewCell.h"
#import "BidTableViewCell.h"

@interface ScrollViewTableViewCell ()
@end


@implementation ScrollViewTableViewCell

- (void)setViewMode:(HomeViewMode*)viewModel
             height:(CGFloat)height {
    
    self.homeViewMode = viewModel;
    self.viewHeight = height;
    
    if(!self.collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 10;
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-10, self.viewHeight)
                                                 collectionViewLayout:layout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.scrollsToTop = NO;
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:self.collectionView];
    }
}

#pragma mark - collection delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrDataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {        
    return [UICollectionViewCell new];
}


@end
