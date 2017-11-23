//
//  ScrollViewTableViewCell.h
//  sevenGo
//
//  Created by zhengkai on 17/9/18.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewMode.h"

@interface ScrollViewTableViewCell : UITableViewCell <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

- (void)setViewMode:(HomeViewMode*)viewModel
             height:(CGFloat)heigh;

@property (nonatomic, strong) HomeViewMode *homeViewMode;
@property (nonatomic, assign) CGFloat viewHeight;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *arrDataSource;
@property (nonatomic, strong) UIScrollView *scrollView;

@end
