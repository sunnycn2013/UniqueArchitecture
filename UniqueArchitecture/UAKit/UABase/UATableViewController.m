//
//  UATableViewController.m
//  UniqueArchitecture
//
//  Created by summer on 15/5/8.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import "UATableViewController.h"

@implementation UATableViewController

- (void)dealloc{
    [_headRefreshView removeFromSuperview];
    [_footRefreshView removeFromSuperview];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark - 初始化UI
- (void)setUI{
  _tableView = [[UITableView alloc]
      initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,
                               SCREEN_HEIGHT - TAB_BAR_HEIGHT - UA_TOP_OFFSET)
              style:UITableViewStylePlain];
  _tableView.delegate = self;
  _tableView.dataSource = self;
  [self.view addSubview:_tableView];

  _headRefreshView = [UARefreshHeaderView refreshView];
  [_headRefreshView addTarget:self refreshAction:@selector(pullDownRefresh)];
  [_headRefreshView addToScrollView:_tableView];

  _footRefreshView = [UARefreshFooterView refreshView];
  [_footRefreshView addTarget:self refreshAction:@selector(pullUpRefresh)];
  [_footRefreshView addToScrollView:_tableView];
}

#pragma mark- UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"UABaseCellIdentifier";
    UITableViewCell *cell = nil;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

#pragma mark- Custom delegate

#pragma mark - refreash method


- (void)pullDownRefresh
{
    
}

- (void)pullUpRefresh
{
    
}

#pragma mark - responder 方法

#pragma mark - Private 方法

#pragma mark - set get 方法
- (void)setHidenHeadRefreshView:(BOOL)hidenHeadRefreshView
{
    _hidenHeadRefreshView = hidenHeadRefreshView;
    _headRefreshView.hidden = hidenHeadRefreshView;
}

- (void)setHidenFooterRefreshView:(BOOL)hidenFooterRefreshView
{
    _hidenFooterRefreshView = hidenFooterRefreshView;
    _footRefreshView.hidden = hidenFooterRefreshView;
}

#pragma mark - 其他方法

@end
