//
//  AreaAddAppendTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 2017/10/30.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "AreaAddAppendTableViewCell.h"
#import "UIView+BlocksKit.h"
#import "ReactiveCocoa.h"
#import "RechargeViewController.h"

@interface AreaAddAppendTableViewCell ()
@property (nonatomic, strong)IBOutlet UILabel *lblTitle;
@property (nonatomic, strong)IBOutlet UILabel *lblContent;
@property (nonatomic, strong)IBOutlet UILabel *lblContent2;
@property (nonatomic, strong)IBOutlet UIButton *btnAdd;
@property (nonatomic, strong)IBOutlet UIImageView *imgSel;

@end

@implementation AreaAddAppendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lblTitle.textColor = COLOR_TEXT;
    self.lblContent2.textColor = self.lblContent.textColor = COLOR_DETAIL;
    self.btnAdd.backgroundColor = COLOR_NAV;
    self.btnAdd.layer.cornerRadius = 4.0;
    
    NSString *str = [NSString stringWithFormat:@"您还有个%d币",10];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
    [text addAttribute:NSForegroundColorAttributeName
                 value:COLOR_NAV
                 range:NSMakeRange(4, str.length - 5)];
    self.lblContent2.attributedText = text;
    self.bSel = NO;
    self.imgSel.userInteractionEnabled = YES;
    [self.imgSel bk_whenTapped:^{
        self.bSel = !self.bSel;
    }];
    
    @weakify(self);
    [RACObserve(self, bSel) subscribeNext:^(id x) {
        @strongify(self);
        if(self.bSel) {
            [self.imgSel setImage:[YYImage imageNamed:@"areaAdd_unSel"]];
        } else {
            [self.imgSel setImage:[YYImage imageNamed:@"areaAdd_sel"]];
        }
    }];
    
}

- (IBAction)doAdd:(id)sender {
    RechargeViewController *vc = [[RechargeViewController alloc] init];
    [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
}

+ (CGFloat)getCellHeight {
    return 100;
}

@end
