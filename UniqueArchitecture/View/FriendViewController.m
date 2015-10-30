//
//  FriendViewController.m
//  UniqueArchitecture
//
//  Created by summer on 15/6/4.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import "FriendViewController.h"
#import "UActivityView.h"

#import "News.h"

@interface FriendViewController (){
    UActivityView *view1;
    BOOL isScrolling;
}

@end

@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Friend";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-kScaleNum(150))/2, SCREEN_HEIGHT-104-kScaleNum(35)-10, kScaleNum(150), kScaleNum(35))];
    [loginButton setBackgroundColor:[UIColor redColor]];
    [loginButton setAlpha:0.8];
    [loginButton setTitle:@"login" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    // Do any additional setup after loading the view.
    
    view1 = [[UActivityView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    [self.view addSubview:view1];
    
//    [view1 startAnimation];
    isScrolling = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)loginAction:(id)sender{
//    if (isScrolling) {
//        [view1 stopAnimation];
//        isScrolling = NO;
//    }else{
//        isScrolling = YES;
//        [view1 startAnimation];
//    }
    
    [view1 player];
    
    NSLog(@"loging...");
//    FriendViewController *VC = [[FriendViewController alloc] init];
    //[self.navigationController pushViewController:VC animated:YES];
    __weak typeof(self) weakself = self;

    
    //初始化参数列表
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"val1" forKey:@"key1"];
    
    //实例化
    UAHttpRequestModel *model = [UAHttpRequestModel model];
    model.servicesType = HOST_URL_DEFAULT;
    model.servicesName = @"start";
    model.params = dic;
    
    //开启活动指示器
    [self showNetWorkIndicatorView];
    UAHttpRequest *manager = [UAHttpRequest manager];
    
    [manager GET:@"index" parameters:model success:^(UAHttpRequest *request, id responseObject){
        NSLog(@"JSON: %@", [request.requestOpetation.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
        
        if (!responseObject) {
            return ;
        }
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSDictionary *tem = [dic objectForKey:@"weatherinfo"];
        NSError *error = nil;
        [weakself dismissNetWorkIndicatorView];
        
    } failure:^(UAHttpRequest *request, NSError *error){
        NSLog(@"Error: %@", error);

    }];
    
}

@end
