//
//  PhotoTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 2017/10/30.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "PhotoTableViewCell.h"
#import "ZLPhotoActionSheet.h"
#import "ReactiveCocoa.h"

@interface PhotoTableViewCell () <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) CGFloat cellWidth;
@property (nonatomic, strong) NSMutableArray<UIImage *> *lastSelectPhotos;
@property (nonatomic, strong) NSMutableArray<PHAsset *> *lastSelectAssets;
@property (nonatomic, assign) BOOL isOriginal;

@end

static NSString *cellIdentifier          = @"photoTableViewCell";

@implementation PhotoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.cellWidth = (SCREEN_WIDTH-20)/4;
        self.cellHeight = self.cellWidth + 25;
        self.arrDataSource = [[NSMutableArray alloc] init];
        
        CGFloat width = SCREEN_WIDTH;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((width-9)/4, (width-9)/4);
        layout.minimumInteritemSpacing = 1.5;
        layout.minimumLineSpacing = 1.5;
        layout.sectionInset = UIEdgeInsetsMake(3, 0, 3, 0);
        
        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(16, 5, 100, 15)];
        self.lblTitle.textColor = COLOR_TEXT;
        self.lblTitle.font = [UIFont systemFontOfSize:14];
        self.lblTitle.text = @"添加图片";
        [self.contentView addSubview:self.lblTitle];
        
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(4, self.lblTitle.bottom + 3, SCREEN_WIDTH-8, self.cellWidth + 5)
                                                 collectionViewLayout:layout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.scrollsToTop = NO;
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:self.collectionView];
        
        [self.collectionView registerClass:[UICollectionViewCell class]
                forCellWithReuseIdentifier:cellIdentifier];
        
        @weakify(self);
        [RACObserve(self, cellHeight) subscribeNext:^(id x) {
            @strongify(self);
            self.collectionView.height = self.cellHeight - 20;
        }];
        
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(self.readOnly) {
        return self.arrDataSource.count;
    } else {
        return self.arrDataSource.count+1;
    }
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier
                                                                            forIndexPath:indexPath];
    NSInteger tag = 1000;
    UIImageView *imgCover = (UIImageView*)[cell.contentView viewWithTag:tag];
    if(!imgCover) {
        imgCover = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, self.cellWidth-4, self.cellWidth - 4)];
        imgCover.tag = tag;
        [cell.contentView addSubview:imgCover];
    }
    
    if(indexPath.row == self.arrDataSource.count) {
        imgCover.image = [YYImage imageNamed:@"areaAdd_add.png"];
    } else {
        UIImage *img = self.arrDataSource[indexPath.row];
        imgCover.image = img;
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(self.cellWidth, self.cellWidth);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == self.arrDataSource.count) {
        ZLPhotoActionSheet *a = [self getPas];
        [a showPhotoLibrary];
    } else {
        [[self getPas] previewSelectedPhotos:self.lastSelectPhotos assets:self.lastSelectAssets index:indexPath.row isOriginal:self.isOriginal];
    }
}

- (ZLPhotoActionSheet *)getPas
{
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    actionSheet.arrSelectedAssets = self.lastSelectAssets;
    actionSheet.navBarColor = [UIColor whiteColor];
    actionSheet.navTitleColor = [UIColor blackColor];
#pragma optional
    actionSheet.sortAscending = NO;
    actionSheet.allowSelectGif = NO;
    actionSheet.allowSelectVideo = NO;
    actionSheet.allowSelectLivePhoto = NO;
    actionSheet.allowForceTouch = NO;
    actionSheet.allowEditImage = NO;
    actionSheet.allowEditVideo = NO;
    actionSheet.allowSelectOriginal = NO;
    actionSheet.allowSlideSelect = NO;
    actionSheet.allowMixSelect = NO;
    actionSheet.allowDragSelect = YES;
    actionSheet.allowTakePhotoInLibrary = YES;
    actionSheet.maxPreviewCount = 9;
    actionSheet.maxSelectCount = 9;
    actionSheet.showSelectBtn = NO;
    actionSheet.editAfterSelectThumbnailImage = NO;
    actionSheet.showSelectedMask = YES;
    actionSheet.shouldAnialysisAsset = YES;
#pragma required
    
    actionSheet.sender = [GotoAppdelegate sharedAppDelegate].topViewController;
    
    @weakify(self);
    [actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        @strongify(self);
        [self.arrDataSource removeAllObjects];
        [self.arrDataSource addObjectsFromArray:images];
        self.isOriginal = isOriginal;
        self.lastSelectAssets = assets.mutableCopy;
        self.lastSelectPhotos = images.mutableCopy;
        [self.collectionView reloadData];
        
        self.cellHeight = ((self.arrDataSource.count)/4 + 1)*self.cellWidth + 25;
        if(self.reFresh) {
            self.reFresh();
        }
        
    }];
    
    return actionSheet;
}


@end
