//
//  FFPagingHeaderView.m
//  BasicFrameworkManager
//
//  Created by Fan on 16/9/27.
//  Copyright © 2016年 Fan. All rights reserved.
//

#import "FFPagingHeaderView.h"
#import "FFPagingViewItem.h"

#define kDefaultItemWidth       60.0f
#define KDefaultLineColor       [UIColor colorWithRed:234/255.0f green:237/255.0f blue:240/255.0f alpha:1];


#define kDefaultTextColor       [UIColor blackColor]
#define kDefaultSelectTextColor [UIColor colorWithRed:1.00f green:0.49f blue:0.65f alpha:1.00f]

#define kLineHeight             0//(1 / [UIScreen mainScreen].scale)
#define kDefaultFont            [UIFont systemFontOfSize:13.0]

@interface FFPagingHeaderView () <UIScrollViewDelegate>
@property(nonatomic, strong) UIScrollView *scrollview;
@property(nonatomic, strong) UIView *lineview;
@property(nonatomic, strong) CALayer *lineLayer;

@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation FFPagingHeaderView
- (instancetype)init
{
    if (self == [super init]) {
        _itemWidth = kDefaultItemWidth;
        _lineColor = KDefaultLineColor;
        _font = kDefaultFont;
        _textColor = kDefaultTextColor;
        _selectTextColor = kDefaultSelectTextColor;
        _scale = false;
    }
    return self;
}

- (void)updateTitleContentOffset:(NSInteger)index
{
    FFPagingViewItem *item = (FFPagingViewItem *)[self.scrollview viewWithTag:index+1];
    float offsetX = (item.center.x - self.scrollview.frame.size.width/2.0) > 0 ? (item.center.x - self.scrollview.frame.size.width/2.0) : 0;
    float maxOffsetX = self.scrollview.contentSize.width - self.scrollview.frame.size.width;
    if (offsetX < maxOffsetX) {
        [self.scrollview setContentOffset:CGPointMake(offsetX, 0) animated:true];
    } else {
        [self.scrollview setContentOffset:CGPointMake(maxOffsetX, 0) animated:true];
    }
}


#pragma mark - response Action
- (void)tapGesture:(UITapGestureRecognizer *)recognizer
{
    FFPagingViewItem *item = (FFPagingViewItem *)recognizer.view;
    if (item) {
        if (self.pagingViewItemClickHandle) {
            self.pagingViewItemClickHandle(self, item.text, item.tag - 1);
        }
        self.currentIndex = item.tag - 1;
        
        [self updateTitleContentOffset:self.currentIndex];
    }
}

#pragma mark - setter
- (void)setItemWidth:(CGFloat)itemWidth
{
    _itemWidth = itemWidth;
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
}

- (void)setSelectTextColor:(UIColor *)selectTextColor
{
    _selectTextColor = selectTextColor;
}

- (void)setScale:(BOOL)scale
{
    _scale = scale;
}

- (void)setTitles:(NSArray<NSString *> *)titles
{
    _titles = titles;
    
    self.scrollview.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - kLineHeight);
    self.scrollview.contentSize = CGSizeMake(titles.count * self.itemWidth, 0);
    CGFloat width = self.scrollview.bounds.size.width / titles.count;
    if (titles.count) {
        for (NSInteger i=0; i<titles.count; i++) {
            FFPagingViewItem *item = [[FFPagingViewItem alloc] init];
            [self.scrollview addSubview:item];
            
            //当自定义宽度小于平分title的宽度时，使用根据屏幕宽度进行等分宽度
            if (self.itemWidth <= width) {
                self.itemWidth = width;
            }
            
            item.frame = CGRectMake(i * self.itemWidth, 0, self.itemWidth, self.bounds.size.height);
            item.text = titles[i];

            if (i == 0 && self.scale) {
                item.transform = CGAffineTransformMakeScale(1.3, 1.3);
            }
            
            item.font = self.font;
            item.textColor = self.textColor;
            item.tag = i + 1;
            item.textAlignment = NSTextAlignmentCenter;
            item.userInteractionEnabled = true;
            [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)]];
        }
    }
    
    [self.scrollview addSubview:self.lineview];
    self.lineview.frame = CGRectMake(0, self.bounds.size.height-2, width, 2);
    self.lineLayer.frame = CGRectMake(0, self.scrollview.bounds.size.height, self.scrollview.bounds.size.width, kLineHeight);
    
    
    int64_t delayInSeconds = 0.5;      // 延迟的时间
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.scrollview setContentOffset:CGPointMake(0, 0) animated:NO];
    });
    

}

- (void)setContentOffset:(CGPoint)contentOffset
{
    _contentOffset = contentOffset;
    CGFloat offsetX = contentOffset.x;
    
    //当前索引
    NSInteger index = offsetX / [[UIScreen mainScreen] bounds].size.width;
    
    FFPagingViewItem *leftItem = (FFPagingViewItem *)[self.scrollview viewWithTag:index + 1];
    FFPagingViewItem *rightItem = (FFPagingViewItem *)[self.scrollview viewWithTag:index + 2];
    
    CGFloat rightPageLeftDelta = offsetX - index * [[UIScreen mainScreen] bounds].size.width;
    CGFloat progress = rightPageLeftDelta / [[UIScreen mainScreen] bounds].size.width;
    
    if ([leftItem isKindOfClass:[FFPagingViewItem class]]) {
        leftItem.textColor = self.selectTextColor;
        leftItem.fillColor = self.textColor;
        leftItem.progress = progress;
        
        if (self.scale) {
            leftItem.transform = CGAffineTransformMakeScale(1 + (1 - progress) * 0.3, 1 + (1 - progress) * 0.3);
        }
    }
    
    if ([rightItem isKindOfClass:[FFPagingViewItem class]]) {
        rightItem.textColor = self.textColor;
        rightItem.fillColor = self.selectTextColor;
        rightItem.progress = progress;
        if (self.scale) {
            rightItem.transform = CGAffineTransformMakeScale(1 + progress * 0.3, 1 + progress * 0.3);
        }
    }
    
    for (FFPagingViewItem *item in self.scrollview.subviews) {
        if ([item isKindOfClass:[FFPagingViewItem class]]) {
            if (item.tag != index +1 && item.tag != index + 2) {
                item.textColor = self.textColor;
                item.fillColor = self.selectTextColor;
                item.progress = 0.0;
            }
        }
    }
    
    CGRect frame = self.lineview.frame;
    frame.origin.x = contentOffset.x/_titles.count;
    self.lineview.frame = frame;
    
    self.currentIndex = index;
}

#pragma mark - getter
- (UIScrollView *)scrollview
{
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc] init];
        _scrollview.delegate = self;
        _scrollview.showsVerticalScrollIndicator = false;
        _scrollview.showsHorizontalScrollIndicator = false;
        [self addSubview:_scrollview];
    }
    return _scrollview;
}


- (CALayer *)lineLayer
{
    if (!_lineLayer) {
        _lineLayer = [CALayer layer];
        [self.layer addSublayer:_lineLayer];
        _lineLayer.backgroundColor = self.lineColor.CGColor;
    }
    return _lineLayer;
}

- (UIView*)lineview {
    if (!_lineview) {
        _lineview = [[UIView alloc] init];
        _lineview.backgroundColor = _selectTextColor;
    }
    return _lineview;
}
@end
