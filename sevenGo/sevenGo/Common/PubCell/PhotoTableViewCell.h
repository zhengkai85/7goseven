//
//  PhotoTableViewCell.h
//  sevenGo
//
//  Created by zhengkai on 2017/10/30.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "RootTableViewCell.h"

@interface PhotoTableViewCell : UITableViewCell 
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) NSMutableArray *arrDataSource;
@property (nonatomic, strong) void(^reFresh)(void);
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, assign) BOOL readOnly;
@end
