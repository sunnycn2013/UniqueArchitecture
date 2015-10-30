//
//  UAViewController.m
//  UniqueArchitecture
//
//  Created by summer on 15/5/8.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import "UAViewController.h"
#import "UADialog.h"

@implementation UAViewController
#pragma mark - ViewController method..
- (instancetype)init{
    self = [super init];
    
    if (self) {
        //
    }
    return  self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self dismissNetWorkIndicatorView];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - UINavigationBar初始化方法

//- (void)setNavigationBarBackground{
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_bg_ios7_ip4"] forBarMetrics:UIBarMetricsDefault];
//}

#pragma mark - UIViewController 公共方法

//进度条，活动指示器
- (void)showNetWorkIndicatorView{
    [UADialog showNetWorkIndicatorView];
}

- (void)dismissNetWorkIndicatorView{
    [UADialog dismiss];
}

- (void)showNetWorkError{
    [UADialog showNetWorkError];
}

//显示reloadView
- (void)showReloadView{
    if (!_reloadView) {
        _reloadView = [[UAReloadView alloc] initWithFrame:self.view.bounds];
        _reloadView.delegate = self;
        [self.view addSubview:_reloadView];
    }
    _reloadView.hidden = NO;
}

- (void)hidenReloadView{
    _reloadView.hidden = YES;
}

- (void)showSuccesMessageWith:(NSString *)msg{
    [UADialog showSuccessWithStatus:msg];
}

- (void)showErrorMessageWith:(NSString *)msg{
    [UADialog showErrorWithStatus:msg];
}

#pragma mark - CustomDelegate Method
- (void)reConnection{
    
}

@end
