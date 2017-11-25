//
//  BMOrderHearderTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 2017/11/24.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "BMOrderHearderTableViewCell.h"

@interface BMOrderHearderTableViewCell()
@property (nonatomic, strong)IBOutlet UIImageView *imgIcon;
@property (nonatomic, strong)IBOutlet UILabel *lblTitle;
@property (nonatomic, strong)IBOutlet UILabel *lblContet;
@end
@implementation BMOrderHearderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lblTitle.textColor = COLOR_TEXT;
    self.lblContet.textColor = COLOR_NAV;
    self.lblTitle.font = self.lblContet.font = [UIFont systemFontOfSize:13];
}

- (void)drawWithObj:(BMOrderObj*)obj {
}
@end
