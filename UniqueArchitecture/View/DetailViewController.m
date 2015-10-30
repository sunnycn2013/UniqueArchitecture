//
//  DetailViewController.m
//  UniqueArchitecture
//
//  Created by ccguo on 15/5/18.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import "DetailViewController.h"
#import "FriendViewController.h"
#import "News.h"
#import "UAProgressView.h"

@interface DetailViewController (){
    UITextView *_textView;
}

@end

@implementation DetailViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        //
        
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"Detail";
    [self setUI];

    UAProgressView *view = [[UAProgressView alloc] initWithFrame:CGRectMake(10, 300, 150, 5)];
    view.progress = 0.9;
    [self.view addSubview:view];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)setUI{
    //登陆框
//    UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScaleNum(20), kScaleNum(100), kScaleNum(100), kScaleNum(30))];
//    [userNameLabel setText:@"UserName:"];
//    [userNameLabel setTextAlignment:NSTextAlignmentLeft];
//    [userNameLabel setTextColor:[UIColor blackColor]];
//    [self.view addSubview:userNameLabel];
//    
//    UITextField *userNameTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(userNameLabel.frame), CGRectGetMinY(userNameLabel.frame), SCREEN_WIDTH-CGRectGetWidth(userNameLabel.frame)-kScaleNum(20)-10, kScaleNum(30))];
//    [userNameTextFiled setPlaceholder:@"username.."];
//    [userNameTextFiled.layer setBorderColor:[UIColor blackColor].CGColor];
//    [userNameTextFiled.layer setBorderWidth:0.5];
//    [self.view addSubview:userNameTextFiled];
//    
//    
//    UILabel *pwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScaleNum(20), kScaleNum(100)+CGRectGetHeight(userNameLabel.frame), kScaleNum(100), kScaleNum(30))];
//    [pwdLabel setText:@"Pwd:"];
//    [pwdLabel setTextAlignment:NSTextAlignmentLeft];
//    [pwdLabel setTextColor:[UIColor blackColor]];
//    [self.view addSubview:pwdLabel];
//    
//    UITextField *pwdTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(pwdLabel.frame), CGRectGetMinY(pwdLabel.frame), SCREEN_WIDTH-CGRectGetWidth(pwdLabel.frame)-kScaleNum(20)-10, kScaleNum(30))];
//    [pwdTextFiled setPlaceholder:@"pwd.."];
//    [pwdTextFiled.layer setBorderColor:[UIColor blackColor].CGColor];
//    [pwdTextFiled.layer setBorderWidth:0.5];
//    [self.view addSubview:pwdTextFiled];
    

//    _textView = [[UITextView alloc] initWithFrame:CGRectMake(30, 100, 250, 100)];
//    _textView.backgroundColor = [UIColor lightGrayColor];
//    _textView.delegate = self;
//    [self.view addSubview:_textView];
    
    UIImageView *_textView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon"]];
    [self.view addSubview:_textView1];
    NSLog(@"%@",NSStringFromCGRect(_textView1.frame));
    
    
    
    //login
    
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-kScaleNum(150))/2, SCREEN_HEIGHT-104-kScaleNum(35)-10, kScaleNum(150), kScaleNum(35))];
    [loginButton setBackgroundColor:[UIColor redColor]];
    [loginButton setAlpha:0.8];
    [loginButton setTitle:NSLocalizedString(@"demo", @"111loginButton name") forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    
    UIButton *loginButton1 = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-kScaleNum(150))/2, 200, kScaleNum(150), kScaleNum(35))];
    [loginButton1 setBackgroundColor:[UIColor purpleColor]];
    [loginButton1 setAlpha:0.8];
    [loginButton1 setTitle:@"Close" forState:UIControlStateNormal];
    [loginButton1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginButton1 addTarget:self action:@selector(loginAction1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton1];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
    [self.view addGestureRecognizer:tap];
}

- (void)loginAction:(id)sender{
//    NSLog(@"loging...");
//    //[self showNetWorkIndicatorView];
//
//    [self showSuccesMessageWith:@"success.."];
//    NSURLRequest *request = [[NSURLRequest alloc] init];
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
//        
//    }];
    
    
    
    
    __weak typeof(self) weakself = self;
    
    
    //初始化参数列表
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"val1" forKey:@"key1"];
    
    //实例化
    UAHttpRequestModel *model = [UAHttpRequestModel model];
    model.servicesType = HOST_URL_DEFAULT;
    model.servicesName = @"start";
    model.params = dic;
    
    [self showNetWorkIndicatorView];
    
    UAHttpRequestManager *manager = [UAHttpRequestManager manager];
    [manager GET:@"index" parameters:model success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"JSON: %@", [operation.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
        
        if (!responseObject) {
            return ;
        }
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSDictionary *tem = [dic objectForKey:@"weatherinfo"];
        NSError *error = nil;
        [weakself dismissNetWorkIndicatorView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [manager GET:@"index1" parameters:model success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"JSON1: %@", [operation.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
        
        if (!responseObject) {
            return ;
        }
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSDictionary *tem = [dic objectForKey:@"weatherinfo"];
        NSError *error = nil;
        [weakself dismissNetWorkIndicatorView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

- (void)loginAction1:(id)sender{
    NSLog(@"loging...");
    [self showErrorMessageWith:@"faile.."];
}

- (void)closeKeyboard:(id)sender{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)textViewDidChange:(UITextView *)textView{
    NSLog(@"frame : %@",NSStringFromCGRect(textView.frame));
    NSLog(@"size : %@",NSStringFromCGSize(textView.contentSize));

//    [textView scrollRectToVisible:<#(CGRect)#> animated:<#(BOOL)#>]
    
    CGSize size = textView.contentSize;
    
    [textView setContentOffset:CGPointMake(0, size.height - 100) animated:YES];
}

- (void)reConnection{
    NSLog(@"loging...");

    [self hidenReloadView];
}
@end
