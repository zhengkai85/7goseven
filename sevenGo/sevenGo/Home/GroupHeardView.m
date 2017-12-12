//
//  GroupHeardView.m
//  sevenGo
//
//  Created by zhengkai on 2017/9/26.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "GroupHeardView.h"

@implementation GroupHeardView

- (void)setViewMode:(HomeMode*)mode
             height:(CGFloat)heigh {
    
    self.backgroundColor = [UIColor whiteColor];
    
    
    NSInteger tag = 1000;
    UIView *line = [self viewWithTag:++tag];
    if(!line) {
        line = [[UIView alloc] initWithFrame:CGRectMake(8, 0, SCREEN_WIDTH-16, 1)];
        line.tag = tag;
        line.backgroundColor = COLOR_LINECOLOR;
        [self addSubview:line];
    }
    
    UILabel *lblTilte = [self viewWithTag:++tag];
    if(!lblTilte) {
        lblTilte = [[UILabel alloc] initWithFrame:CGRectMake(16, line.bottom+10, SCREEN_WIDTH-16, 15)];
        lblTilte.tag = tag;
        lblTilte.font = [UIFont boldSystemFontOfSize:14];
        lblTilte.textColor = COLOR_BLACK;
        [self addSubview:lblTilte];
    }
    
    UILabel *lblContent = [self viewWithTag:++tag];
    if(!lblContent) {
        lblContent = [[UILabel alloc] initWithFrame:CGRectMake(lblTilte.left, heigh/2 + 5, lblTilte.width, 14)];
        lblContent.font = [UIFont systemFontOfSize:13];
        lblContent.textColor = COLOR_DETAIL;
        [self addSubview:lblContent];
    }
    
    UIButton *btnGoto = [self viewWithTag:++tag];
    if(!btnGoto) {
        btnGoto = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 70, 0, 60, 50)];
        btnGoto.centerY = heigh/2;
        [btnGoto setTitle:@"查看更多" forState:UIControlStateNormal];
        [btnGoto setTitleColor:COLOR_NAV forState:UIControlStateNormal];
        btnGoto.titleLabel.font = [UIFont systemFontOfSize:13];
        [btnGoto addTarget:self action:@selector(gotoDetail) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnGoto];
    }
    
    if(mode) {
        lblTilte.text = mode.title;
        lblContent.text = mode.subtitle;
        btnGoto.hidden = [mode isEmpty];
    }
}

- (void)gotoDetail {
    if(self.gotoDetailBlock) {
        self.gotoDetailBlock();
    }
}
@end
