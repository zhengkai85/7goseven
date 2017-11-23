//
//  RootCollectionView.m
//  huimin
//
//  Created by zhengkai on 16/4/12.
//  Copyright © 2016年 zhengkai. All rights reserved.
//

#import "RootCollectionView.h"
#import "UIImageView+WebCache.h"

@interface RootCollectionView ()
@property (nonatomic, strong)NSMutableArray *arrDataSource;
@property (nonatomic, assign)CGFloat widthValue;
@property (nonatomic, assign)CGFloat heightValue;

@end

static NSString *cellIdentifier = @"cellIdentifier";

@implementation RootCollectionView

- (id)initWithFrame:(CGRect)frame {
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];//
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if(self) {
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}




@end
