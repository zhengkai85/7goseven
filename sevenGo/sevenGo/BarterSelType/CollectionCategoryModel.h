//
//  CategoryModel.h
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//  代码下载地址https://github.com/leejayID/Linkage

#import <Foundation/Foundation.h>

@interface CollectionCategoryModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *ext_field;

@end

@interface SubCategoryModel : NSObject

@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *pid;
@end
