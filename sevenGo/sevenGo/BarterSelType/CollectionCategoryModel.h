//
//  CategoryModel.h
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//  代码下载地址https://github.com/leejayID/Linkage

#import <Foundation/Foundation.h>

@interface CollectionCategoryModel : NSObject

@property (nonatomic, copy) NSString *title;

@end

@interface SubCategoryModel : NSObject

@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *pid;

@end
