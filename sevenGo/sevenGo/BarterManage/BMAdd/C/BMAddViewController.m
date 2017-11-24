//
//  BMAddViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/11/21.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "BMAddViewController.h"
#import "TitleDetailTableViewCell.h"
#import "PhotoTableViewCell.h"
#import "TitleContentTableViewCell.h"
#import "ReactiveCocoa.h"
#import "CollectionViewController.h"
#import "BMInputeViewController.h"
#import "PGDatePicker.h"
#import "BMExtraViewController.h"

@interface BMAddViewController ()<UITableViewDataSource,UITableViewDelegate,PGDatePickerDelegate>
@property (nonatomic, strong) UITableView      *tableView;
@property (nonatomic, assign) BidType bidType;
@property (nonatomic, strong) TitleDetailTableViewCell *cidCell;
@property (nonatomic, strong) PhotoTableViewCell *photoCell;
@property (nonatomic, strong) TitleContentTableViewCell *titleCell;
@property (nonatomic, strong) TitleContentTableViewCell *productIDCell;   //货号
@property (nonatomic, strong) TitleContentTableViewCell *noticeCell;      //属性
@property (nonatomic, strong) TitleContentTableViewCell *contentCell;     //描述
@property (nonatomic, strong) TitleContentTableViewCell *startPriceCell;  //起拍价
@property (nonatomic, strong) TitleContentTableViewCell *stepPriceCell;   //加价幅度
@property (nonatomic, strong) TitleContentTableViewCell *endPriceCell;    //一口价
@property (nonatomic, strong) TitleContentTableViewCell *refPriceCell;    //参考价
@property (nonatomic, strong) TitleContentTableViewCell *depositPriceCell;//保证金
@property (nonatomic, strong) TitleContentTableViewCell *startTimeCell;   //开始时间
@property (nonatomic, strong) TitleContentTableViewCell *endTimeCell;     //结束时间
@property (nonatomic, strong) TitleContentTableViewCell *startNumsCell;    //开始人数
@property (nonatomic, strong) TitleContentTableViewCell *keepTimeCell;     //拍卖时间
@property (nonatomic, strong) TitleContentTableViewCell *extraCell;        //批量内容

@property (nonatomic, strong) NSArray *arrCommodityType;  //商品
@property (nonatomic, strong) NSArray *arrAuctionType;    //拍卖

@end

#define ReuseCidCell              @"cidCell"
#define ReusePhotoCell            @"photoCell"
#define ReuseTitleCell            @"titleCell"
#define ReuseProductIDCell        @"productIDCell"
#define ReuseNoticeCell           @"noticeCell"
#define ReuseContentCell          @"contentCell"
#define ReuseStartPriceCell       @"startPriceCell"
#define ReuseStepPriceCell        @"stepPriceCell"
#define ReuseEndPriceCell         @"endPriceCell"
#define ReuseRefPriceCell         @"refPriceCell"
#define ReuseDepositPriceCell     @"reuseDepositPriceCell"
#define ReuseStartTimeCell        @"reuseStartTimeCell"
#define ReuseEndTimeCell          @"reuseEndTimeCell"
#define ReuseStartNumCell         @"reuseStartNumCell"
#define ReuseKeepTimeCell         @"keepTimeCell"
#define ReuseExtraCell            @"extraCell"

@implementation BMAddViewController

- (instancetype)initWithBid:(BidType)type {
    self = [super init];
    if(self) {
        self.bidType = type;
    }
    return self;
}

- (void)dealloc {
    ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商品详细";
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   CGRectGetWidth(self.view.frame),
                                                                   CGRectGetHeight(self.view.frame) - TOP_HEIGHT)
                                                  style:UITableViewStyleGrouped];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionHeaderHeight = 0.0001;
    self.tableView.sectionFooterHeight = 0.0001;
    [self.view addSubview:self.tableView];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleDetailTableViewCell" bundle:nil]
         forCellReuseIdentifier:ReuseCidCell];
    
    [self.tableView registerClass:[PhotoTableViewCell class]
           forCellReuseIdentifier:ReusePhotoCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleContentTableViewCell" bundle:nil]
         forCellReuseIdentifier:ReuseTitleCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleContentTableViewCell" bundle:nil]
         forCellReuseIdentifier:ReuseProductIDCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleContentTableViewCell" bundle:nil]
         forCellReuseIdentifier:ReuseNoticeCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleContentTableViewCell" bundle:nil]
         forCellReuseIdentifier:ReuseContentCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleContentTableViewCell" bundle:nil]
         forCellReuseIdentifier:ReuseStartPriceCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleContentTableViewCell" bundle:nil]
         forCellReuseIdentifier:ReuseStepPriceCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleContentTableViewCell" bundle:nil]
         forCellReuseIdentifier:ReuseEndPriceCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleContentTableViewCell" bundle:nil]
         forCellReuseIdentifier:ReuseRefPriceCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleContentTableViewCell" bundle:nil]
         forCellReuseIdentifier:ReuseDepositPriceCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleContentTableViewCell" bundle:nil]
         forCellReuseIdentifier:ReuseStartTimeCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleContentTableViewCell" bundle:nil]
         forCellReuseIdentifier:ReuseEndTimeCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleContentTableViewCell" bundle:nil]
         forCellReuseIdentifier:ReuseStartNumCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleContentTableViewCell" bundle:nil]
         forCellReuseIdentifier:ReuseKeepTimeCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleContentTableViewCell" bundle:nil]
         forCellReuseIdentifier:ReuseExtraCell];
    
    
    if(self.bidType == BidType_mode) {
        self.arrCommodityType = @[ReuseProductIDCell,ReuseNoticeCell,ReuseContentCell];
        self.arrAuctionType = @[ReuseStartPriceCell,ReuseStepPriceCell,ReuseEndPriceCell,
                                ReuseRefPriceCell,ReuseDepositPriceCell,ReuseStartTimeCell,ReuseEndTimeCell];
    } else if (self.bidType == BidType_batch) {
        self.arrCommodityType = @[ReuseProductIDCell,ReuseNoticeCell,ReuseExtraCell,ReuseContentCell];
        self.arrAuctionType = @[ReuseStartPriceCell,ReuseStepPriceCell,ReuseEndPriceCell,
                                ReuseRefPriceCell,ReuseDepositPriceCell,ReuseStartTimeCell,ReuseEndTimeCell];
    } else if (self.bidType == BidType_meeting) {
        self.arrCommodityType = @[ReuseProductIDCell,ReuseNoticeCell,ReuseContentCell];
        self.arrAuctionType = @[ReuseStartNumCell,ReuseStartPriceCell,ReuseStepPriceCell,ReuseEndPriceCell,
                                ReuseRefPriceCell,ReuseKeepTimeCell];
    }

//        self.arrAuctionType = @[ReuseStartPriceCell];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
       return self.photoCell.cellHeight + 5;
    }
    
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 3) {
        return self.arrCommodityType.count;
    } else if (section == 4) {
        return self.arrAuctionType.count;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        if(!self.cidCell) {
            self.cidCell = [self.tableView dequeueReusableCellWithIdentifier:ReuseCidCell
                                                                forIndexPath:indexPath];
            self.cidCell.lblTitle.text = @"类目";
            self.cidCell.lblDetail.text = @"";
            self.cidCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return self.cidCell;
    } else if(indexPath.section == 1) {
        if(!self.photoCell) {
            self.photoCell = [self.tableView dequeueReusableCellWithIdentifier:ReusePhotoCell
                                                                  forIndexPath:indexPath];
            @weakify(self);
            [self.photoCell setReFresh:^{
                @strongify(self);
                [self.tableView reloadSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];
            }];
        }
        
        return self.photoCell;
    } else if(indexPath.section == 2) {
        if(!self.titleCell) {
            self.titleCell = [self.tableView dequeueReusableCellWithIdentifier:ReuseTitleCell
                                                                  forIndexPath:indexPath];
            self.titleCell.lblTitle.text = @"标题";
            self.titleCell.txtContent.placeholder = @"标题不超过40个字";
        }
        return self.titleCell;
    } else if(indexPath.section == 3) {
        NSString *cellReuse = self.arrCommodityType[indexPath.row];
        if([cellReuse isEqualToString:ReuseProductIDCell]) {
            if(!self.productIDCell) {
                self.productIDCell = [self.tableView dequeueReusableCellWithIdentifier:cellReuse
                                                                          forIndexPath:indexPath];
                self.productIDCell.lblTitle.text = @"商品货号";
                self.productIDCell.txtContent.placeholder = @"请输入商品货号";
            }
            return self.productIDCell;
        } else if([cellReuse isEqualToString:ReuseNoticeCell]) {
            if(!self.noticeCell) {
                self.noticeCell = [self.tableView dequeueReusableCellWithIdentifier:cellReuse
                                                                       forIndexPath:indexPath];
                self.noticeCell.lblTitle.text = @"批量内容";
                self.noticeCell.txtContent.userInteractionEnabled = NO;
                self.noticeCell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
            }
            return self.noticeCell;
        } else if([cellReuse isEqualToString:ReuseContentCell]) {
            if(!self.contentCell) {
                self.contentCell = [self.tableView dequeueReusableCellWithIdentifier:cellReuse
                                                                        forIndexPath:indexPath];
                self.contentCell.lblTitle.text = @"商品描述";
                self.contentCell.txtContent.userInteractionEnabled = NO;
                self.contentCell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
            }
            return self.contentCell;
        } else if ([cellReuse isEqualToString:ReuseExtraCell]) {
            if(!self.extraCell) {
                self.extraCell = [self.tableView dequeueReusableCellWithIdentifier:cellReuse
                                                                        forIndexPath:indexPath];
                self.extraCell.lblTitle.text = @"批量内容";
                self.extraCell.txtContent.userInteractionEnabled = NO;
                self.extraCell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
            }
            return self.contentCell;
        }
        
    } else if(indexPath.section == 4) {
        NSString *cellReuse = self.arrAuctionType[indexPath.row];
        if([cellReuse isEqualToString:ReuseStartPriceCell]) {
            if(!self.startPriceCell) {
                self.startPriceCell = [self.tableView dequeueReusableCellWithIdentifier:cellReuse
                                                                           forIndexPath:indexPath];
                self.startPriceCell.lblTitle.text = @"起拍价";
                self.startPriceCell.txtContent.placeholder = @"请输入定价";
                self.startPriceCell.txtContent.keyboardType = UIKeyboardTypeNumberPad;
            }
            return self.startPriceCell;
        } else if([cellReuse isEqualToString:ReuseStepPriceCell]) {
            if(!self.stepPriceCell) {
                self.stepPriceCell = [self.tableView dequeueReusableCellWithIdentifier:cellReuse
                                                                          forIndexPath:indexPath];
                self.stepPriceCell.lblTitle.text = @"加价幅度";
                self.stepPriceCell.txtContent.placeholder = @"请输入加价幅度";
                self.stepPriceCell.txtContent.keyboardType = UIKeyboardTypeNumberPad;
            }
            return self.stepPriceCell;
        } else if([cellReuse isEqualToString:ReuseEndPriceCell]) {
            if(!self.endPriceCell) {
                self.endPriceCell = [self.tableView dequeueReusableCellWithIdentifier:cellReuse
                                                                         forIndexPath:indexPath];
                self.endPriceCell.lblTitle.text = @"一口价";
                self.endPriceCell.txtContent.placeholder = @"请输入一口价";
                self.endPriceCell.txtContent.keyboardType = UIKeyboardTypeNumberPad;
            }
            return self.endPriceCell;
        } else if ([cellReuse isEqualToString:ReuseRefPriceCell]) {
            if(!self.refPriceCell) {
                self.refPriceCell = [self.tableView dequeueReusableCellWithIdentifier:cellReuse
                                                                         forIndexPath:indexPath];
                self.refPriceCell.lblTitle.text = @"参考价";
                self.refPriceCell.txtContent.placeholder = @"请输入参考价";
                self.refPriceCell.txtContent.keyboardType = UIKeyboardTypeNumberPad;
            }
            return self.refPriceCell;
        } else if([cellReuse isEqualToString:ReuseDepositPriceCell]) {
            if(!self.depositPriceCell) {
                self.depositPriceCell =  [self.tableView dequeueReusableCellWithIdentifier:cellReuse
                                                                              forIndexPath:indexPath];
                self.depositPriceCell.lblTitle.text = @"竞拍保证金";
                self.depositPriceCell.txtContent.placeholder = @"请输入竞拍保证金";
                self.depositPriceCell.txtContent.keyboardType = UIKeyboardTypeNumberPad;
            }
            return self.depositPriceCell;
        } else if([cellReuse isEqualToString:ReuseStartTimeCell]) {
            if(!self.startTimeCell) {
                self.startTimeCell =  [self.tableView dequeueReusableCellWithIdentifier:cellReuse
                                                                           forIndexPath:indexPath];
                self.startTimeCell.lblTitle.text = @"开拍时间";
                self.startTimeCell.txtContent.placeholder = @"请选择开拍时间";
                self.startTimeCell.txtContent.userInteractionEnabled = NO;
                self.startTimeCell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;

            }
            return self.startTimeCell;
        } else if ([cellReuse isEqualToString:ReuseEndTimeCell]) {
            if(!self.endTimeCell) {
                self.endTimeCell =  [self.tableView dequeueReusableCellWithIdentifier:cellReuse
                                                                           forIndexPath:indexPath];
                self.endTimeCell.lblTitle.text = @"结束时间";
                self.endTimeCell.txtContent.placeholder = @"请选择结束时间";
                self.endTimeCell.txtContent.userInteractionEnabled = NO;
                self.endTimeCell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;

            }
            return self.endTimeCell;
        } else if (([cellReuse isEqualToString:ReuseStartNumCell])) {
            if(!self.startNumsCell) {
                self.startNumsCell = [self.tableView dequeueReusableCellWithIdentifier:cellReuse
                                                                          forIndexPath:indexPath];
                self.startNumsCell.lblTitle.text = @"需几人开拍";
                self.startNumsCell.txtContent.placeholder = @"请输入起拍人数";
                self.startNumsCell.txtContent.keyboardType = UIKeyboardTypeNumberPad;
            }
            return self.startNumsCell;
        } else if (([cellReuse isEqualToString:ReuseKeepTimeCell])) {
            if(!self.keepTimeCell) {
                self.keepTimeCell = [self.tableView dequeueReusableCellWithIdentifier:cellReuse
                                                                          forIndexPath:indexPath];
                self.keepTimeCell.lblTitle.text = @"拍卖时间";
                self.keepTimeCell.txtContent.text = @"2个小时";
                self.keepTimeCell.txtContent.userInteractionEnabled = NO;
            }
            return self.keepTimeCell;
        }
    }
    return [[UITableViewCell alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        CollectionViewController *vc = [[CollectionViewController alloc] init];
        [vc setSelValueBlock:^(SubCategoryModel *mode) {
            self.cidCell.lblDetail.text = mode.title;
            self.cidCell.value = mode.pid;
        }];
        [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
    } else if (indexPath.section == 3) {
        NSString *cellReuse = self.arrCommodityType[indexPath.row];
        if([cellReuse isEqualToString:ReuseNoticeCell]) {
            BMInputeViewController *vc = [[BMInputeViewController alloc] init];
            vc.title = @"填写内容";
            vc.strContent = self.noticeCell.txtContent.text;
            [vc setDoSaveBlock:^(NSString *txt) {
                self.noticeCell.txtContent.text = txt;
            }];
            [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
        } else if ([cellReuse isEqualToString:ReuseContentCell]) {
            BMInputeViewController *vc = [[BMInputeViewController alloc] init];
            vc.title = @"填写描述";
            vc.strContent = self.contentCell.txtContent.text;
            [vc setDoSaveBlock:^(NSString *txt) {
                self.contentCell.txtContent.text = txt;
            }];
            [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
        } else if ([cellReuse isEqualToString:ReuseExtraCell]) {
            BMExtraViewController *vc = [[BMExtraViewController alloc] init];
            [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
        }
    } else if(indexPath.section == 4) {
        NSString *cellReuse = self.arrAuctionType[indexPath.row];
        if([cellReuse isEqualToString:ReuseStartTimeCell]) {
            PGDatePicker *datePicker = [self getDatePicker];
            datePicker.tag = 100;
            if(self.startTimeCell.value) {
                [datePicker setDate:self.startTimeCell.value animated:NO];
            }
            [datePicker show];

        } else if ([cellReuse isEqualToString:ReuseEndTimeCell]) {
            PGDatePicker *datePicker = [self getDatePicker];
            datePicker.tag = 200;
            if(self.endTimeCell.value) {
                [datePicker setDate:self.endTimeCell.value animated:NO];
            }
            [datePicker show];
        }
    }
}


- (PGDatePicker *)getDatePicker {
    PGDatePicker *datePicker = [[PGDatePicker alloc]init];
    datePicker.delegate = self;
    datePicker.datePickerMode = PGDatePickerModeDate;
    datePicker.datePickerMode = PGDatePickerModeDateHourMinute;
    datePicker.lineBackgroundColor = [UIColor grayColor];
    datePicker.textColorOfSelectedRow = [UIColor blackColor];
    datePicker.textColorOfOtherRow = [UIColor grayColor];
    datePicker.confirmButtonTextColor = [UIColor blackColor];

    return datePicker;
}

#pragma PGDatePickerDelegate
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    if(datePicker.tag == 100) {
        NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
        NSDateFormatter *dateFormatter=[NSDateFormatter new];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        self.startTimeCell.txtContent.text = [dateFormatter stringFromDate:date];
        self.startTimeCell.value = date;
    } else if (datePicker.tag == 200) {
        NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
        NSDateFormatter *dateFormatter=[NSDateFormatter new];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        self.endTimeCell.txtContent.text = [dateFormatter stringFromDate:date];
        self.endTimeCell.value = date;
    }
}

@end
