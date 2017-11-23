//
//  TitleContentTableViewCell.h
//  sevenGo
//
//  Created by zhengkai on 2017/11/21.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "RootTableViewCell.h"

@interface TitleContentTableViewCell : RootTableViewCell
@property (nonatomic, strong)IBOutlet UILabel *lblTitle;
@property (nonatomic, strong)IBOutlet UITextField *txtContent;
@end
