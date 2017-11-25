//
//  ProductTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 2017/11/17.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "ProductTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface ProductTableViewCell ()
@property (nonatomic, strong) IBOutlet UIImageView *imgIcon;
@property (nonatomic, strong) IBOutlet UILabel *lblTitle;
@property (nonatomic, strong) IBOutlet UILabel *lblPrice;
@property (nonatomic, strong) IBOutlet UILabel *lblStartTime;
@property (nonatomic, strong) IBOutlet UILabel *lblEndTime;
@property (nonatomic, strong) IBOutlet UILabel *lblState;
@end

@implementation ProductTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)drawWith:(BMProductObj*)obj {
    NSArray *arr = obj.image_list;
    if(arr.count>0) {
        [self.imgIcon sd_setImageWithURL:arr[0]];
    }
    
    self.lblTitle.text = obj.title;
    self.lblPrice.text = [NSString stringWithFormat:@"当前价格:%@",obj.now_price];
    
    if([self.lblStartTime isNoEmpty]) {
        self.lblStartTime.text = [NSString stringWithFormat:@"开始时间:%@",obj.start_time];
    }
    if([self.lblEndTime isNoEmpty]) {
        self.lblEndTime.text = [NSString stringWithFormat:@"结束时间:%@",obj.start_time];

    }
    
}


@end
