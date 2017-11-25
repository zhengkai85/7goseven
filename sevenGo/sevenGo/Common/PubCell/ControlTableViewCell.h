//
//  ControlTableViewCell.h
//  sevenGo
//
//  Created by zhengkai on 2017/11/25.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "RootTableViewCell.h"

@interface ControlTableViewCell : RootTableViewCell
@property (nonatomic, strong)IBOutlet UIButton *btnRight1;
@property (nonatomic, strong)IBOutlet UIButton *btnRight2;
@property (nonatomic, strong)IBOutlet UIButton *btnRight3;
@property (nonatomic, strong)void(^btnR1ClickBLock)(void);
@property (nonatomic, strong)void(^btnR2ClickBLock)(void);
@property (nonatomic, strong)void(^btnR3ClickBLock)(void);

@end
