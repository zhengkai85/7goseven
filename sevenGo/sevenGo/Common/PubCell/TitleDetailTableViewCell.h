//
//  TitleDetailTableViewCell.h
//  sevenGo
//
//  Created by zhengkai on 2017/10/25.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "RootTableViewCell.h"

@interface TitleDetailTableViewCell : RootTableViewCell
@property (nonatomic, strong)IBOutlet UILabel *lblTitle;
@property (nonatomic, strong)IBOutlet UILabel *lblDetail;
@property (nonatomic, strong)NSString *value;
@end
