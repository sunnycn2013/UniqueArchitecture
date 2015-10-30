//
//  MJTabBar.m
//  00-ItcastLottery
//
//  Created by apple on 14-4-14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UATabBar.h"
#import "UATabBarButton.h"

@interface UATabBar()
/**
 *  记录当前选中的按钮
 */
@property (nonatomic, weak) UATabBarButton *selectedButton;
@end

@implementation UATabBar

- (instancetype)init{
    self = [super init];
    if (self) {
        //
    }
    return self;
}

- (void)addTabButtonWithName:(NSString *)name selName:(NSString *)selName
{
    // 创建按钮
    UATabBarButton *button = [UATabBarButton buttonWithType:UIButtonTypeCustom];
    // 设置图片
    [button setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selName] forState:UIControlStateSelected];
    [button setUserInteractionEnabled:YES];
    // 添加
    [self addSubview:button];
    
//#warning UIControlEventTouchDown : 手指一按下去就会触发这个事件
    // 监听
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    // 默认选中第0个按钮
    if (self.subviews.count == 1) {
        [self buttonClick:button];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    NSUInteger count = self.subviews.count;
    for (int i = 0; i<count; i++) {
        UATabBarButton *button = self.subviews[i];
        button.tag = i;
        
        // 设置frame
//        CGFloat buttonY = 0;
//        CGFloat buttonW = self.frame.size.width / count;
//        CGFloat buttonH = self.frame.size.height;
//        CGFloat buttonX = i * buttonW;
//        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        //29
        CGFloat zonewidth = self.frame.size.width / count;
        CGFloat buttonY = 3;
        CGFloat buttonW = 29;
        CGFloat buttonH = 29;
        CGFloat buttonX = (zonewidth-43.5)/2 + i * zonewidth +6;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(UATabBarButton *)button
{
    // 0.通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectButtonFrom:(int)self.selectedButton.tag to:(int)button.tag];
    }
    
    // 1.让当前选中的按钮取消选中
    self.selectedButton.selected = NO;
    
    // 2.让新点击的按钮选中
    button.selected = YES;
    
    // 3.新点击的按钮就成为了"当前选中的按钮"
    self.selectedButton = button;
}
@end