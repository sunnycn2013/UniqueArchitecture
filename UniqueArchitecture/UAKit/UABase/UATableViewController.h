//
//  UATableViewController.h
//  UniqueArchitecture
//
//  Created by summer on 15/5/8.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UAViewController.h"
#import <ODRefreshControl/ODRefreshControl.h>
#import "UARefreshHeaderView.h"
#import "UARefreshFooterView.h"

@interface UATableViewController : UAViewController<UITableViewDataSource,UITableViewDelegate>{
    
}

@property (nonatomic,strong) NSArray              *dataArray;
@property (nonatomic,strong) UITableView          *tableView;
@property (nonatomic,strong) UARefreshHeaderView  *headRefreshView;
@property (nonatomic,strong) UARefreshFooterView  *footRefreshView;

@property (nonatomic,assign) BOOL  hidenHeadRefreshView;
@property (nonatomic,assign) BOOL  hidenFooterRefreshView;

@end
