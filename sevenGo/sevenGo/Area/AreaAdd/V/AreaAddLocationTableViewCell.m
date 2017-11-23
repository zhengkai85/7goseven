//
//  AreaAddLocationTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 2017/10/30.
//  Copyright © 2017年 zhengkai. All rights reserved.
//


#import "AreaAddLocationTableViewCell.h"

@interface AreaAddLocationTableViewCell ()
@property (nonatomic, strong)IBOutlet UILabel *lblTittle;
@end

@implementation AreaAddLocationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.height = 30;
    self.lblTittle.textColor = COLOR_BLACK;
    self.lblContent.textColor = COLOR_BLACK;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
}


@end
