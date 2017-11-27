//
//  BMExtraViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/11/23.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "BMExtraViewController.h"
#import "TitleContentTableViewCell.h"
#import "KeyValueNameObj.h"
#import "ReactiveCocoa.h"
#import "UIViewController+BackButtonHandler.h"

@interface BMExtraViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView      *tableView;
@property (nonatomic, strong) NSString *appendString;

@end


#define ReuseTitleContentCell              @"TitleContentCell"


@implementation BMExtraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商品属性";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   CGRectGetWidth(self.view.frame),
                                                                   CGRectGetHeight(self.view.frame))
                                                  style:UITableViewStyleGrouped];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionHeaderHeight = 0.0001;
    self.tableView.sectionFooterHeight = 0.0001;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleContentTableViewCell" bundle:nil]
         forCellReuseIdentifier:ReuseTitleContentCell];
}

- (BOOL) navigationShouldPopOnBackButton {
    if(self.getMessage) {
        self.getMessage(self.arrDataSource);
    }
    return YES;
}

+ (NSDictionary*)getAppendMeg:(NSArray*)arr {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:arr.count];
    for(KeyValueNameObj *obj in arr) {
        [dic setValue:obj.value forKey:obj.key];
    }
    return dic;
}

- (void)fillData:(NSString*)str {
    NSArray *arr = [str componentsSeparatedByString:@","];
    NSArray *arrAllData = [self getAllData];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.key in %@", arr];
    self.arrDataSource = [arrAllData filteredArrayUsingPredicate:predicate];
    ;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TitleContentTableViewCell *cell =  [self.tableView dequeueReusableCellWithIdentifier:ReuseTitleContentCell
                                                                            forIndexPath:indexPath];
    KeyValueNameObj *obj = self.arrDataSource[indexPath.row];
    cell.lblTitle.text = obj.name;
    cell.txtContent.placeholder = [NSString stringWithFormat:@"请输入%@",obj.name];
    cell.txtContent.text = obj.value;
    [RACObserve(cell, txtContent.text) subscribeNext:^(id x) {
        obj.value = x;
    }];
    return cell;
}



- (NSArray*)getAllData
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    [arr addObject:[[KeyValueNameObj alloc] initWithKey:@"product_id"
                                                  vlaue:@""
                                                   name:@"货号"]];
    
    [arr addObject:[[KeyValueNameObj alloc] initWithKey:@"color"
                                                  vlaue:@""
                                                   name:@"颜色"]];
    
    [arr addObject:[[KeyValueNameObj alloc] initWithKey:@"size"
                                                  vlaue:@""
                                                   name:@"尺码"]];
    
    [arr addObject:[[KeyValueNameObj alloc] initWithKey:@"style"
                                                  vlaue:@""
                                                   name:@"风格"]];
    
    [arr addObject:[[KeyValueNameObj alloc] initWithKey:@"season"
                                                  vlaue:@""
                                                   name:@"适用季节"]];
    
    [arr addObject:[[KeyValueNameObj alloc] initWithKey:@"other"
                                                  vlaue:@""
                                                   name:@"其他"]];
    
    [arr addObject:[[KeyValueNameObj alloc] initWithKey:@"main_component_material"
                                                  vlaue:@""
                                                   name:@"面料主成分"]];
    
    [arr addObject:[[KeyValueNameObj alloc] initWithKey:@"main_component_material"
                                                  vlaue:@""
                                                   name:@"面料主成分"]];
    
    [arr addObject:[[KeyValueNameObj alloc] initWithKey:@"product_grade"
                                                  vlaue:@""
                                                   name:@"产品等级"]];
    
    [arr addObject:[[KeyValueNameObj alloc] initWithKey:@"dimensions"
                                                  vlaue:@""
                                                   name:@"尺寸规格"]];
    
    [arr addObject:[[KeyValueNameObj alloc] initWithKey:@"composition_content"
                                                  vlaue:@""
                                                   name:@"成分及含量"]];
    
    [arr addObject:[[KeyValueNameObj alloc] initWithKey:@"gram_weight"
                                                  vlaue:@""
                                                   name:@"克重"]];
    
    [arr addObject:[[KeyValueNameObj alloc] initWithKey:@"breadth"
                                                  vlaue:@""
                                                   name:@"幅宽"]];
    
    [arr addObject:[[KeyValueNameObj alloc] initWithKey:@"purpose"
                                                  vlaue:@""
                                                   name:@"具体用途"]];
    
    [arr addObject:[[KeyValueNameObj alloc] initWithKey:@"kind"
                                                  vlaue:@""
                                                   name:@"种类"]];
    
    [arr addObject:[[KeyValueNameObj alloc] initWithKey:@"texture"
                                                  vlaue:@""
                                                   name:@"材质"]];
    
    [arr addObject:[[KeyValueNameObj alloc] initWithKey:@"action_object"
                                                  vlaue:@""
                                                   name:@"作用对象"]];
    
    [arr addObject:[[KeyValueNameObj alloc] initWithKey:@"model"
                                                  vlaue:@""
                                                   name:@"型号"]];
    
    
    [arr addObject:[[KeyValueNameObj alloc] initWithKey:@"brand"
                                                  vlaue:@""
                                                   name:@"品牌"]];
    
    [arr addObject:[[KeyValueNameObj alloc] initWithKey:@"model"
                                                  vlaue:@""
                                                   name:@"型号"]];
    
    [arr addObject:[[KeyValueNameObj alloc] initWithKey:@"target_user"
                                                  vlaue:@""
                                                   name:@"适用人群"]];
 
    return arr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
