//
//  ZKInPutTextView.m
//  huimin
//
//  Created by zhengkai on 17/5/25.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import "ZKInPutTextView.h"
#import "UITextView+Placeholder.h"

#define kTextViewMaxHeight 72

@interface ZKInPutTextView () <UITextViewDelegate>
@property (nonatomic, strong)UITextView *txt;
@property (nonatomic, assign) CGFloat  contentHeight;
@end

@implementation ZKInPutTextView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if(self == [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        

        
        
        self.txt = [[UITextView alloc] initWithFrame:CGRectMake(5, 8, frame.size.width-65, kTextViewHeight)];
        [self addSubview:self.txt];
        
        self.txt.layer.cornerRadius = 4;
        self.txt.layer.masksToBounds = YES;
        self.txt.layer.borderWidth = 1.0;
        self.txt.layer.borderColor = [UIColor grayColor].CGColor;
        
        self.txt.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.txt.scrollEnabled = YES;
        self.txt.returnKeyType = UIReturnKeySend;
        self.txt.enablesReturnKeyAutomatically = YES; // UITextView内部判断send按钮是否可以用
        self.txt.delegate = self;
        self.txt.layer.borderColor = [UIColor colorWithWhite:0.8f alpha:1.0f].CGColor;
        self.txt.layer.borderWidth = 0.6;
        self.txt.layer.cornerRadius = 6;
        self.txt.font = [UIFont systemFontOfSize:14];
        
        self.txt.textContainerInset = UIEdgeInsetsMake(6, 6, 6, 6);
        self.txt.placeholder = @"写评论";
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.txt.right, self.txt.top, SCREEN_WIDTH - self.txt.right, self.txt.height)];
        [btn setTitle:@"发送" forState:UIControlStateNormal];
        [btn setTitleColor:COLOR_TEXT forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(sendTxt) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onKeyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onKeyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification object:nil];
        
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.6)];
        line.backgroundColor = [UIColor colorWithWhite:0.8f alpha:1.0f];
        [self addSubview:line];
        
    }
    
    return self;
}


- (void)sendTxt {
    if(self.sendBlock) {
        if (self.txt.text.length > 0) {
            self.sendBlock(self.txt.text);
            self.txt.text = @"";
            [self willShowZKInPutTextViewToHeight:[self getTextViewContentH:self.txt]];
        }
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"])
    {
        [self sendTxt];
        return NO;
    }
    
    NSInteger strLength = textView.text.length - range.length + text.length;
    return (strLength <= 40);
}

- (NSInteger)getTextViewContentH:(UITextView *)textView {
    if (textView.text.length == 0){
        return kTextViewHeight;
    } else {
        return (NSInteger)([textView sizeThatFits:textView.bounds.size].height + 1);
    }
}


- (void)textViewDidChange:(UITextView *)textView {
    
    [self willShowZKInPutTextViewToHeight:[self getTextViewContentH:textView]];
}

- (void)willShowZKInPutTextViewToHeight:(CGFloat)toHeight {
    
    CGFloat textViewToHeight = toHeight;
    if (toHeight < kTextViewHeight) {
        textViewToHeight = kTextViewHeight;
    }
    
    if (toHeight > kTextViewMaxHeight) {
        textViewToHeight = kTextViewMaxHeight;
    }

    NSInteger conHeight = textViewToHeight;
    CGFloat off = conHeight - kTOOLBarHeight;
    if(off != 0) {
        self.txt.height = conHeight;
        self.top = SCREEN_HEIGHT - TOP_HEIGHT - kTOOLBarHeight - self.contentHeight;
        self.txtTop = self.top;
    }

     off = self.txt.contentSize.height - textViewToHeight;
    if (off > 0) {
        [self.txt setContentOffset:CGPointMake(0, off) animated:YES];
    }
}


- (void)onKeyboardWillHide:(NSNotification *)notification {
    
    NSDictionary* userInfo = [notification userInfo];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSInteger contentHeight = kTOOLBarHeight;
    if (_contentHeight != contentHeight) {
        [UIView animateWithDuration:duration animations:^{
            self.top = SCREEN_HEIGHT - TOP_HEIGHT - contentHeight;
            self.txtTop = self.top;
            self.contentHeight = contentHeight;
        }];
    }
}


- (void)onKeyboardWillShow:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    NSInteger contentHeight = endFrame.size.height;
    if (contentHeight != self.contentHeight) {
        [UIView animateWithDuration:duration animations:^{
            self.top = endFrame.origin.y - kTOOLBarHeight - TOP_HEIGHT;
            self.txtTop = self.top;
            self.contentHeight = contentHeight;
        }];
    }
}

@end
