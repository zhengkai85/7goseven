//
//  AuctionTableViewCell.m
//  sevenGo
//
//  Created by zhengkai on 2017/12/2.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "AuctionTableViewCell.h"
#import "AuctionMode.h"

@interface AuctionTableViewCell()

@property (nonatomic, strong)IBOutlet UILabel *lblNo;

@property (nonatomic, strong)IBOutlet UIView *leftView;
@property (nonatomic, strong)IBOutlet UIImageView *leftImg;
@property (nonatomic, strong)IBOutlet UILabel *leftLblCount;
@property (nonatomic, strong)IBOutlet UILabel *leftLblTitle;
@property (nonatomic, strong)IBOutlet UILabel *leftLblTime;

@property (nonatomic, strong)IBOutlet UIView *rightView;
@property (nonatomic, strong)IBOutlet UIImageView *rightImg;
@property (nonatomic, strong)IBOutlet UILabel *rightLblCount;
@property (nonatomic, strong)IBOutlet UILabel *rightLblTitle;
@property (nonatomic, strong)IBOutlet UILabel *rightLblTime;

@end

@implementation AuctionTableViewCell

- (void)setViewMode:(AuctionViewMode*)viewModel
                row:(NSInteger)row
               type:(NSInteger)type;
{
    
        
    @weakify(self);
    if(type == 0) {
        [RACObserve(viewModel, arrMode) subscribeNext:^(id x) {
            @strongify(self);
            [self setState:viewModel.arrMode row:row];
        }];
    } else if (type == 1) {
        [RACObserve(viewModel, arrBatch) subscribeNext:^(id x) {
            @strongify(self);
            [self setState:viewModel.arrBatch row:row];
        }];
    } else if (type == 2) {
        [RACObserve(viewModel, arrMetting) subscribeNext:^(id x) {
            @strongify(self);
            [self setState:viewModel.arrMetting row:row];
        }];
    }
}

- (void)setState:(NSArray*)arr
             row:(NSInteger)row {
    if(row == 0) {
        if(arr.count == 0) {
            self.lblNo.hidden = NO;
            self.leftView.hidden = YES;
            self.rightView.hidden = YES;
        } else if (arr.count == 1) {
            self.lblNo.hidden = YES;
            self.leftView.hidden = NO;
            self.rightView.hidden = YES;
            [self setCellValue:arr[0] type:0];
        } else {
            self.leftView.hidden = NO;
            self.rightView.hidden = NO;
            self.lblNo.hidden = YES;
            [self setCellValue:arr[0] type:0];
            [self setCellValue:arr[1] type:1];

        }
    } else {
        if(row == 1) {
            if(arr.count == 2) {
                self.lblNo.hidden = NO;
                self.leftView.hidden = YES;
                self.rightView.hidden = YES;
            } else if (arr.count == 3) {
                self.lblNo.hidden = YES;
                self.leftView.hidden = NO;
                self.rightView.hidden = YES;
                [self setCellValue:arr[2] type:0];
            } else {
                self.lblNo.hidden = YES;
                self.leftView.hidden = NO;
                self.rightView.hidden = NO;
                [self setCellValue:arr[2] type:0];
                [self setCellValue:arr[3] type:1];
            }
        }
    }
}

- (void)setCellValue:(AuctionMode*)mode
                type:(NSUInteger)type
{
    if(!mode)
        return;
    
    if(type == 0) {
        NSArray *arr = mode.image_list;
        if(arr.count>0) {
            NSString *url = arr[0][@"thumb"];
            [self.leftImg setImageURL:[NSURL URLWithString:url]];
        }
        self.leftLblCount.text = [NSString stringWithFormat:@"%@次出价",mode.bid_times];
        self.leftLblTitle.text = mode.title;
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[mode.start_time longLongValue]];
        NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
        [objDateformat setDateFormat:@"MM-dd HH:mm"];
        self.leftLblTime.text = [NSString stringWithFormat:@"截拍时间:%@",[objDateformat stringFromDate: date]];
    } else {
        NSArray *arr = mode.image_list;
        if(arr.count>0) {
            NSString *url = arr[0][@"thumb"];
            [self.rightImg setImageURL:[NSURL URLWithString:url]];
        }
        self.rightLblCount.text = [NSString stringWithFormat:@"%@次出价",mode.bid_times];
        self.rightLblTitle.text = mode.title;
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[mode.start_time longLongValue]];
        NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
        [objDateformat setDateFormat:@"MM-dd HH:mm"];
        self.rightLblTime.text = [NSString stringWithFormat:@"截拍时间:%@",[objDateformat stringFromDate: date]];
    }
}



@end
