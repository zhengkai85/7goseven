//
//  BMInputeViewController.m
//  sevenGo
//
//  Created by zhengkai on 2017/11/22.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "BMInputeViewController.h"
#import "UITextView+Placeholder.h"

@interface BMInputeViewController () <UITextViewDelegate>
@property (nonatomic, strong)IBOutlet UITextView *txt;
@property (nonatomic, strong)IBOutlet UILabel *lblNum;
@end

@implementation BMInputeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = COLOR_TABARVIEWGRAY;
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:@"保存"
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(save)];
    
    
    self.navigationItem.rightBarButtonItem = barItem;
    
    
    self.lblNum.font =  self.txt.font = [UIFont systemFontOfSize:14];
    self.lblNum.textColor = self.txt.textColor = COLOR_TEXT;
    
    self.txt.delegate = self;
    self.txt.placeholder = @"请输入商品描述";
    if([self.strContent isNoEmpty]) {
        self.txt.text = self.strContent;
    }
    self.lblNum.text = [NSString stringWithFormat:@"%lu/200",(unsigned long)self.txt.text.length];

}

- (void)save {
    self.strContent = self.txt.text;
    if(self.doSaveBlock) {
        self.doSaveBlock(self.strContent);
    }
    
    [[GotoAppdelegate sharedAppDelegate] popViewController];
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSInteger strLength = textView.text.length - range.length + text.length;
    return (strLength <= 200);
}

- (void)textViewDidChange:(UITextView *)textView {
    self.lblNum.text = [NSString stringWithFormat:@"%lu/200",(unsigned long)textView.text.length];
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
