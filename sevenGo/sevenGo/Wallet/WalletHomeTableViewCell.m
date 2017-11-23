//
//  WalletHomeTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 2017/10/20.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "WalletHomeTableViewCell.h"

@interface WalletHomeTableViewCell ()
@property (nonatomic, strong)IBOutlet UILabel *lblTitle;
@property (nonatomic, strong)IBOutlet UILabel *lblTime;
@property (nonatomic, strong)IBOutlet UILabel *lblAbout;
@property (nonatomic, strong)NSDictionary *dicMessage;
@end

@implementation WalletHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lblTitle.textColor = COLOR_TEXT;
    self.lblTime.textColor = COLOR_DETAIL;
    self.lblAbout.textColor = COLOR_NAV;
    
    self.lblTitle.font = [UIFont systemFontOfSize:14];
    self.lblTime.font = [UIFont systemFontOfSize:12];
    self.lblAbout.font = [UIFont systemFontOfSize:13];
}

- (void)setValue:(NSDictionary*)dic {
    self.dicMessage = dic;
    self.lblTitle.text = [dic stringValue:@"remark"];
    self.lblTime.text = [dic stringValue:@"create_time"];
    self.lblAbout.text = [dic stringValue:@"value"];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
