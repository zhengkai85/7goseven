//
//  BMOrderTableViewCell.h
//  sevenGo
//
//  Created by zhengkai on 2017/11/24.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "RootTableViewCell.h"
#import "BMOrderObj.h"

@interface BMOrderTableViewCell : RootTableViewCell
+ (CGFloat)getCellHeigt;
- (void)drawWithObj:(BMOrderObj*)obj;
@end
