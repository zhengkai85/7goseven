//
//  AreaAddViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/10/30.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "AreaAddViewController.h"
#import "AreaAddTxtTableViewCell.h"
#import "PhotoTableViewCell.h"
#import "AreaAddLocationTableViewCell.h"
#import "AreaAddAppendTableViewCell.h"
#import "AreaAddTagTableViewCell.h"
#import "AreaAddNet.h"
#import "ReactiveCocoa.h"
#import "LocationDemoViewController.h"
#import "LCProgressHUD.h"
#import "PubFunction.h"

@interface AreaAddViewController ()
@property (nonatomic, strong)NSMutableArray *arrPhoto;
@property (nonatomic, strong)AreaAddTxtTableViewCell *txtCell;
@property (nonatomic, strong)PhotoTableViewCell *photoCell;
@property (nonatomic, strong)AreaAddLocationTableViewCell *locationCell;
@property (nonatomic, strong)AreaAddAppendTableViewCell *appendCell;
@property (nonatomic, strong)AreaAddTagTableViewCell *tagCell;
@property (nonatomic, strong)NSDictionary *dicLocationMeg;
@end

#define ReuseAreaAddTxtTableViewCell                   @"AreaAddTxtTableViewCell"
#define ReuseAreaAddPhotoTableViewCell                 @"PhotoTableViewCell"
#define ReuseAreaAddLocationTableViewCell              @"AreaAddLocationTableViewCell"
#define ReuseAreaAddAppendTableViewCell                @"AreaAddAppendTableViewCell"
#define ReuseAreaAddTagTableViewCell                   @"AreaAddTagTableViewCell"



typedef enum : NSUInteger {
    CellType_Tag = 0,
    CellType_Txt,
    CellType_Photo,
    CellType_Location,
    CellType_Append
} CellType;



@implementation AreaAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"发布";
    
    self.tableView.separatorColor  = COLOR_LINECOLOR;
    
    [self.tableView registerClass:[AreaAddTxtTableViewCell class]
           forCellReuseIdentifier:ReuseAreaAddTxtTableViewCell];
    [self.tableView registerClass:[PhotoTableViewCell class]
           forCellReuseIdentifier:ReuseAreaAddPhotoTableViewCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"AreaAddLocationTableViewCell" bundle:nil] forCellReuseIdentifier:ReuseAreaAddLocationTableViewCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"AreaAddAppendTableViewCell" bundle:nil] forCellReuseIdentifier:ReuseAreaAddAppendTableViewCell];
    [self.tableView registerClass:[AreaAddTagTableViewCell class]
           forCellReuseIdentifier:ReuseAreaAddTagTableViewCell];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(doSubmit)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(doCancel)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == CellType_Tag) {
        return self.tagCell.cellHeight + 5;
    } else if(indexPath.section == CellType_Txt) {
        return self.txtCell.cellHeight + 5;
    } else if (indexPath.section == CellType_Photo) {
        return self.photoCell.cellHeight + 5;
    } else if (indexPath.section == CellType_Location) {
        return 40;
    } else if (indexPath.section == CellType_Append) {
        return 100;
    }
    return 0.0001;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    @weakify(self);
    if (indexPath.section == CellType_Tag) {
        if(!self.tagCell) {
            self.tagCell = [self.tableView dequeueReusableCellWithIdentifier:ReuseAreaAddTagTableViewCell
                                                                forIndexPath:[NSIndexPath indexPathForRow:0 inSection:CellType_Tag]];
        }

        [self.tagCell setGetHeightBlock:^{
            @strongify(self);
            [self.tableView reloadSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];
        }];
        return self.tagCell;
    } else if(indexPath.section == CellType_Txt) {
        if(!self.txtCell) {
            self.txtCell = [self.tableView dequeueReusableCellWithIdentifier:ReuseAreaAddTxtTableViewCell
                                                                forIndexPath:[NSIndexPath indexPathForRow:0 inSection:CellType_Txt]];
        }

        return self.txtCell;
    } else if (indexPath.section == CellType_Photo) {
        if(!self.photoCell) {
            self.photoCell = [self.tableView dequeueReusableCellWithIdentifier:ReuseAreaAddPhotoTableViewCell
                                                                  forIndexPath:[NSIndexPath indexPathForRow:0 inSection:CellType_Photo]];
            @weakify(self);
            [self.photoCell setReFresh:^{
                @strongify(self);
                [self.tableView reloadSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];
            }];
        }


        return self.photoCell;
    } else if (indexPath.section == CellType_Location) {
        if(!self.locationCell) {
            self.locationCell = [self.tableView dequeueReusableCellWithIdentifier:ReuseAreaAddLocationTableViewCell
                                                                     forIndexPath:[NSIndexPath indexPathForRow:0 inSection:CellType_Location]];
        }

        return self.locationCell;
    } else if (indexPath.section == CellType_Append) {
        if(!self.appendCell) {
            self.appendCell = [self.tableView dequeueReusableCellWithIdentifier:ReuseAreaAddAppendTableViewCell
                                                                   forIndexPath:[NSIndexPath indexPathForRow:0 inSection:CellType_Append]];
        }
        return self.appendCell;
    }
    
    return [[UITableViewCell alloc] init];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == CellType_Location) {
        LocationDemoViewController *vc = [[LocationDemoViewController alloc] init];
        [vc setSendLocation:^(NSDictionary *msg) {
            self.dicLocationMeg = [[NSDictionary alloc] initWithDictionary:msg];
            self.locationCell.lblContent.text = msg[@"address"];
        }];
        [[GotoAppdelegate sharedAppDelegate] pushViewController:vc];
    }
}

- (void)doSubmit {
    
    if([self.txtCell.txt isEmpty] || [self.photoCell.arrDataSource isEmpty]) {
        [LCProgressHUD showMessage:@"请填写发布内容"];
    }
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:self.photoCell.arrDataSource.count];
    __block BOOL bPicSend  = YES;
    if([self.photoCell.arrDataSource isNoEmpty]) {
        dispatch_group_t group = dispatch_group_create();
        for(UIImage *image in self.photoCell.arrDataSource) {
            dispatch_group_enter(group);
            [AreaAddNet quanImg: UIImageJPEGRepresentation(image, (CGFloat)0.7)
                          block:^(id posts, NSInteger code, NSString *errorMsg) {
                                  dispatch_group_leave(group);
                              if(code == 200) {
                                  NSDictionary *dicData = (NSDictionary*)posts[@"data"];
                                  [arr addObject:[dicData stringValue:@"id"]];
                              } else {
                                  bPicSend = NO;
                              }
            }];
        }
        
        if(!bPicSend) {
            [LCProgressHUD showMessage:@"发送失败"];
            return;
        }
        
        dispatch_queue_t mainQueue= dispatch_get_main_queue();
        dispatch_group_notify(group, mainQueue, ^{
            [AreaAddNet quanAddImgs:arr
                        description:self.txtCell.txt.text
                               tags:[self.tagCell getSelectTag]
                                lng:[self.dicLocationMeg[@"longitude"] doubleValue]
                                lat:[self.dicLocationMeg[@"latitude"] doubleValue]
                           province:0
                               city:0
                            address:self.dicLocationMeg[@"address"]
                           position:self.appendCell.bSel
                              block:^(id posts, NSInteger code, NSString *errorMsg) {
                                  if(code == 200) {
                                      [LCProgressHUD showMessage:@"发送成功"];
                                      [[GotoAppdelegate sharedAppDelegate] popViewController];
                                  } else {
                                      [PubFunction showNetErrorLocalStr:@"发送失败" serverStr:errorMsg];
                                  }
                              }];
        });
    }
}

- (void)doCancel {
    [[GotoAppdelegate sharedAppDelegate] popViewController];
}


@end
