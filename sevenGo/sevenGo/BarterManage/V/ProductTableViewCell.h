//
//  ProductTableViewCell.h
//  sevenGo
//
//  Created by zhengkai on 2017/11/17.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "RootTableViewCell.h"
#import "BMProductObj.h"

@interface ProductTableViewCell : RootTableViewCell

- (void)drawWith:(BMProductObj*)obj;
@end
