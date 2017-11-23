//
//  AreaAddTagTableViewCell.h
//  sevenGo
//
//  Created by zhengkai on 2017/10/30.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "RootTableViewCell.h"


@interface AreaAddTagTableViewCell : RootTableViewCell

- (NSString*)getSelectTag;

@property (nonatomic, strong)void(^getHeightBlock)(void);
@property (nonatomic, assign)CGFloat cellHeight;
@end

