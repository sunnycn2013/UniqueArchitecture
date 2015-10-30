//
//  HomePageViewController.m
//  UniqueArchitecture
//
//  Created by summer on 15/5/10.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import "HomePageViewController.h"
#import "News.h"
#import "HomeDao.h"
#import "HomeViewCell.h"
#import "DetailViewController.h"
#import "UANewWebViewController.h"
#import "UAUtil.h"
#import "UActivityView.h"
#import "UAInternationalControl.h"

#define URL_DB @"http://www.weather.com.cn/adat/sk/101010100.html"

@interface HomePageViewController (){
    UAHttpRequest *_request;
    UActivityView *refreshView;
}

@end

@implementation HomePageViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        //
        self.hidenFooterRefreshView = YES;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"消息";
    count = 0;
    
//    self.hidenHeadRefreshView = NO;
//    self.hidenFooterRefreshView = YES;

    HomeViewCell *cell = nil;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

#pragma mark -  method

- (void)pullDownRefresh//:(UARefreshView *)refreshView
{
    __weak typeof(self) weakself = self;
    
    [self.headRefreshView beginRefreshing];
//    [refreshView startAnimation];
    

    //初始化参数列表
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"val1" forKey:@"key1"];
    
    //实例化
    UAHttpRequestCacheModel *model = [UAHttpRequestCacheModel model];
    model.servicesType = HOST_URL_DEFAULT;
    model.servicesName = @"start";
    model.params = dic;
    //缓存有效时间
    model.leaveTimeout = 500;
    
    [self showNetWorkIndicatorView];
    
    UAHttpRequestCacheManager *manager = [UAHttpRequestCacheManager shareInstance];
    [manager GET:@"index" parameters:model success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"JSON: %@", [operation.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
        
        if (!responseObject) {
            return ;
        }
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSDictionary *tem = [dic objectForKey:@"weatherinfo"];
        NSError *error = nil;
        [weakself dismissNetWorkIndicatorView];
        [weakself.headRefreshView endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)pullUpRefresh//:(UARefreshView *)refreshView
{
    
}

#pragma mark - UITableViewDelegate method-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellidentifier";
    count++;
    HomeViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[HomeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.delegate = self;
    cell.index = [NSString stringWithFormat:@"Index : %ld",(long)count];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"index:%ld",section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *viewController = nil;
    if (indexPath.row%3 == 0) {
         viewController = [[DetailViewController alloc] init];
    }else if(indexPath.row%3 == 1){
        //http://h5beta.m.jd.com/active/blow/index.html
        // http://www.baidu.com
         viewController = [[UANewWebViewController alloc] initWithUrlString:@"http://www.baidu.com/"];

    }else{
        viewController = [[HomePageViewController alloc] init];
        
    }
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    view.backgroundColor = [UIColor yellowColor];
    return view;
}

- (void)shareAction:(id)sender{
    //只需要在响应分享按钮的方法中添加以下代码即可
    
}
@end
