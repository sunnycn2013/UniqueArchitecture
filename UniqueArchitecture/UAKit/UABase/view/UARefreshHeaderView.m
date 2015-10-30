//
//  UARefreshHeaderView.m
//  UARefreshView
//
//  Created by ccguo on 15-2-22.
//  Copyright (c) 2015年 ccguo. All rights reserved.
//

#import "UARefreshHeaderView.h"
#import "UIView+UAExtension.h"

@implementation UARefreshHeaderView
{
    BOOL _hasLayoutedForManuallyRefreshing;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textForNormalState = @"下拉可以加载最新数据";
        self.stateIndicatorViewNormalTransformAngle = 0;
        self.stateIndicatorViewWillRefreshStateTransformAngle = M_PI;
        [self setRefreshState:UARefreshViewStateNormal];
    }
    return self;
}

- (CGFloat)yOfCenterPoint
{
    //    if (self.isManuallyRefreshing && self.isEffectedByNavigationController && UARefreshViewMethodIOS7) {
    //        return - (self.sd_height * 0.5 + self.originalEdgeInsets.top - UAKNavigationBarHeight);
    //    }
    return - (self.sd_height * 0.5);
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    self.scrollViewEdgeInsets = UIEdgeInsetsMake(self.frame.size.height, 0, 0, 0);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.center = CGPointMake(self.scrollView.sd_width * 0.5, [self yOfCenterPoint]);
    
    // 手动刷新
    if (self.isManuallyRefreshing && !_hasLayoutedForManuallyRefreshing && self.scrollView.contentInset.top > 0) {
        self.activityIndicatorView.hidden = NO;
        
        // 模拟下拉操作
        CGPoint temp = self.scrollView.contentOffset;
        temp.y -= self.sd_height * 2;
        self.scrollView.contentOffset = temp; // 触发准备刷新
        temp.y += self.sd_height;
        self.scrollView.contentOffset = temp; // 触发刷新
        
        _hasLayoutedForManuallyRefreshing = YES;
    } else {
        self.activityIndicatorView.hidden = !self.isManuallyRefreshing;
    }
}

- (void)beginRefreshing
{
    self.isManuallyRefreshing = YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (![keyPath isEqualToString:UARefreshViewObservingkeyPath]) return;
    
    CGFloat y = [change[@"new"] CGPointValue].y;
    CGFloat criticalY = -self.sd_height - self.scrollView.contentInset.top;
    
    // 只有在 y<=0 以及 scrollview的高度不为0 时才判断
    if ((y > 0) || (self.scrollView.bounds.size.height == 0)) return;
    
    // 触发UARefreshViewStateRefreshing状态
    if (y >= criticalY && (self.refreshState == UARefreshViewStateWillRefresh)) {
        [self setRefreshState:UARefreshViewStateRefreshing];
    }
    
    // 触发UARefreshViewStateWillRefresh状态
    if (y < criticalY && (UARefreshViewStateNormal == self.refreshState)) {
        [self setRefreshState:UARefreshViewStateWillRefresh];
    }
}

@end
