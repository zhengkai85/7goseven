//
//  ZKInPutTextView.h
//  huimin
//
//  Created by zhengkai on 17/5/25.
//  Copyright © 2017年 zhengkai. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTextViewHeight 34
#define kTOOLBarHeight  50



@interface ZKInPutTextView : UIView

@property (nonatomic, strong) void(^sendBlock)(NSString*str);
@property (nonatomic, assign) CGFloat txtTop;

@end
