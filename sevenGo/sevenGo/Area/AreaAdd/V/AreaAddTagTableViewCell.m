//
//  AreaAddTagTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 2017/10/30.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "AreaAddTagTableViewCell.h"
#import "AreaAddTag.h"
#import "UILabel_Category.h"
#import "AreaAddNet.h"



@implementation AreaAddTagTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.cellHeight = 30;
        [AreaAddNet quan_categoryBlock:^(id posts, NSInteger code, NSString *errorMsg) {
            if(posts) {
                NSArray *arr = posts[@"data"];
                [self setTagArray:arr];
            }
        }];
        
    }
    return self;
}

- (void)setTagArray:(NSArray *)arr {
    
    [self.contentView removeAllSubviews];
    CGFloat x = 8;
    CGFloat y = 12;
    CGFloat space = 10;
    for(NSInteger i=0; i<arr.count; i++) {
        NSDictionary *dic = arr[i];
        AreaAddTag *lblTag = [[AreaAddTag alloc] initWithFrame:CGRectMake(x, y, 100, 30)];
        lblTag.tag = [dic[@"id"] integerValue]+100;
        lblTag.text = dic[@"title"];
        lblTag.width = [lblTag autoWidth] + 8;
        [self.contentView addSubview:lblTag];

        x = lblTag.right + space;
        if(lblTag.right > SCREEN_WIDTH - 16) {
            x = 8;
            y = lblTag.bottom+space;
            
            lblTag.left = x;
            lblTag.top = y;
        }
        
        if(i == arr.count - 1) {
            self.cellHeight = lblTag.bottom + 8;
            if(self.getHeightBlock) {
                self.getHeightBlock();
            }
        }
    }
}

- (NSString*)getSelectTag {
    
    NSString *str = @"";
    for(UIView *view in self.contentView.subviews) {
        if([[view class] isEqual:[AreaAddTag class]]) {
            AreaAddTag *lblTag = (AreaAddTag*)view;
            if(lblTag.bSel) {
                str = [NSString stringWithFormat:@"%@#%ld",str,lblTag.tag - 100];
            }
        }
    }
    
    if(str.length > 1) {
        return [str substringFromIndex:1];
    }
    
    return @"";
}
@end

