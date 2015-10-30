//
//  UARefreshView.h
//  UARefreshView
//
//  Created by ccguo on 15-2-22.
//  Copyright (c) 2015年 ccguo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    UARefreshViewStateWillRefresh,
    UARefreshViewStateRefreshing,
    UARefreshViewStateNormal
} UARefreshViewState;

#define UARefreshViewMethodIOS7 ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
#define UARefreshViewObservingkeyPath @"contentOffset"
#define UAKNavigationBarHeight 64

// ---------------------------配置----------------------------------

// 进入刷新状态时的提示文字
#define UARefreshViewRefreshingStateText @"下拉刷新"
// 进入即将刷新状态时的提示文字
#define UARefreshViewWillRefreshStateText @"松开刷新"

// ---------------------------配置----------------------------------

@interface UARefreshView : UIView

@property (nonatomic, copy) void(^beginRefreshingOperation)();
@property (nonatomic, weak) id      beginRefreshingTarget;
@property (nonatomic, assign) SEL   beginRefreshingAction;
@property (nonatomic, assign) BOOL  isEffectedByNavigationController;

+ (instancetype)refreshView;

- (void)addToScrollView:(UIScrollView *)scrollView;
- (void)addToScrollView:(UIScrollView *)scrollView isEffectedByNavigationController:(BOOL)effectedByNavigationController;

- (void)addTarget:(id)target refreshAction:(SEL)action;
- (void)endRefreshing;


@property (nonatomic, weak) UIScrollView             *scrollView;
@property (nonatomic, assign) UARefreshViewState      refreshState;
@property (nonatomic, copy) NSString                 *textForNormalState;

// 子类自定义位置使用
@property (nonatomic, assign) UIEdgeInsets            scrollViewEdgeInsets;

@property (nonatomic, assign) CGFloat                 stateIndicatorViewNormalTransformAngle;
@property (nonatomic, assign) CGFloat                 stateIndicatorViewWillRefreshStateTransformAngle;

// 记录原始contentEdgeInsets
@property (nonatomic, assign) UIEdgeInsets            originalEdgeInsets;
// 加载指示器
@property (nonatomic, weak) UIActivityIndicatorView  *activityIndicatorView;
@property (nonatomic, assign) BOOL                    isManuallyRefreshing;

- (UIEdgeInsets)syntheticalEdgeInsetsWithEdgeInsets:(UIEdgeInsets)edgeInsets;

@end
