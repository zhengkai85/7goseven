//
//  CollectionViewController.h
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//  代码下载地址https://github.com/leejayID/Linkage

#import <UIKit/UIKit.h>
#import "CollectionCategoryModel.h"

@interface CollectionViewController : UIViewController
@property (nonatomic, strong) void(^selValueBlock)(CollectionCategoryModel *mode,SubCategoryModel *smode);
@end
