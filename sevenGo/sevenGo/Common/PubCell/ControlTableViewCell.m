//
//  ControlTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 2017/11/25.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "ControlTableViewCell.h"

@implementation ControlTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)btnR1Click:(id)sender {
    if(self.btnR1ClickBLock) {
        self.btnR1ClickBLock();
    }
}

- (IBAction)btnR2Click:(id)sender {
    if(self.btnR2ClickBLock) {
        self.btnR2ClickBLock();
    }
}

- (IBAction)btnR3Click:(id)sender {
    if(self.btnR3ClickBLock) {
        self.btnR3ClickBLock();
    }
}

@end
