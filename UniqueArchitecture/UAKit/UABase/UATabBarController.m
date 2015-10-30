//
//  UATabBarController.m
//  UniqueArchitecture
//
//  Created by summer on 15/5/10.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import "UATabBarController.h"
#import "HomePageViewController.h"
#import "FriendViewController.h"
#import "DetailViewController.h"
#import "UANavigationViewController.h"

@implementation UATabBarController

- (instancetype)init{
    self = [super init];
    if (self) {
        //
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
//    HomePageViewController *homeVC = [[HomePageViewController alloc] init];
//    UANavigationViewController *navi = [[UANavigationViewController alloc] initWithRootViewController:homeVC];
//    navi.title = @"消息中心";
    DetailViewController *homeVC = [[DetailViewController alloc] init];
    UANavigationViewController *navi = [[UANavigationViewController alloc] initWithRootViewController:homeVC];
    navi.title = @"消息";
    
    FriendViewController *homeVC1 = [[FriendViewController alloc] init];
    UANavigationViewController *navi1 = [[UANavigationViewController alloc] initWithRootViewController:homeVC1];
    navi1.title = @"消息";

    DetailViewController *homeVC2 = [[DetailViewController alloc] init];
    UANavigationViewController *navi2 = [[UANavigationViewController alloc] initWithRootViewController:homeVC2];
    navi2.title = @"消息";

    HomePageViewController *homeVC3 = [[HomePageViewController alloc] init];
    UANavigationViewController *navi3 = [[UANavigationViewController alloc] initWithRootViewController:homeVC3];
    navi3.title = @"消息";
    
    HomePageViewController *homeVC4 = [[HomePageViewController alloc] init];
    UANavigationViewController *navi4 = [[UANavigationViewController alloc] initWithRootViewController:homeVC4];
    navi4.title = @"消息";

    self.viewControllers = @[navi,navi1,navi2,navi3,navi4];
    
    UATabBar *myTabBar = [[UATabBar alloc] init];
    myTabBar.delegate = self;
    myTabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:myTabBar];

    
    // 2.添加对应个数的按钮
    for (int i = 0; i < self.viewControllers.count; i++) {
//        NSString *name = [NSString stringWithFormat:@"TabBar%d", i+1];
//        NSString *selName = [NSString stringWithFormat:@"TabBar%dSel", i+1];
        NSString *name = [NSString stringWithFormat:@"tab_msg_nor1"];
        NSString *selName = [NSString stringWithFormat:@"tab_msg_press1"];

        [myTabBar addTabButtonWithName:name selName:selName];
    }
    
//    NSArray *tabbarItemds = self.tabBar.items;
//    UITabBarItem *item1 = [tabbarItemds objectAtIndex:0];
//    [item1 setImage:[UIImage imageNamed:@"TabBar0"]];
//    [item1 setSelectedImage:[UIImage imageNamed:@"TabBar0Sel"]];
}

#pragma mark - MJTabBar的代理方法
- (void)tabBar:(UATabBar *)tabBar didSelectButtonFrom:(int)from to:(int)to
{
    // 选中最新的控制器
    self.selectedIndex = to;
}
@end
