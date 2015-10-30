//
//  UANewWebViewController.m
//  UniqueArchitecture
//
//  Created by ccguo on 15/5/14.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import "UANewWebViewController.h"
#import "UARefreshHeaderView.h"
#import "WebViewJavascriptBridge.h"

@interface UANewWebViewController ()<UIWebViewDelegate>{
    UIWebView            *_webView;
    UIView               *_titleView;
    UILabel              *_titleLabel;
    UIButton             *_closeButton;
    
    UARefreshHeaderView  *_headerRefreshView;
    BOOL                  isLoading;
}

@property (nonatomic,retain) WebViewJavascriptBridge   *bridge;
@property (nonatomic,retain) NSString  *urlstring;

@end

@implementation UANewWebViewController

- (void)dealloc{
    _webView.delegate = nil;
    [_headerRefreshView removeFromSuperview];
}

- (instancetype)initWithUrlString:(NSString *)urlString{
    self = [super init];
    
    if (self) {
        if ([urlString hasPrefix:@"http://"]) {
            self.urlstring = urlString;
        }
        [self setUI];
        [self setHeaderRefreshView];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"M页面";
    
    isLoading = YES;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlstring]];
    [_webView loadRequest:request];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - init 初始化数据方法
- (void)setUI{
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(50, 0, SCREEN_WIDTH - 150, 44)];
    _titleView.backgroundColor = [UIColor clearColor];
    [self.navigationItem setTitleView:_titleView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_titleView.frame), 44)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor whiteColor];
    [_titleView addSubview:_titleLabel];
    
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _closeButton.frame = CGRectMake(0, 15, 15, 15);
    _closeButton.hidden = YES;
    [_closeButton setBackgroundImage:[UIImage imageNamed:@"close_button.png"] forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [_titleView addSubview:_closeButton];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    
    [self setRightBarbutton];
}

- (void)setHeaderRefreshView
{
    _headerRefreshView = [UARefreshHeaderView refreshView];
    [_headerRefreshView addToScrollView:_webView.scrollView];
    [_headerRefreshView addTarget:self refreshAction:@selector(pullDownRefresh)];
}

- (void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
    _titleLabel.textColor = [UIColor blueColor];
}

- (void)setRightBarbutton{
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"more_share"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    [shareButton setFrame:CGRectMake(0, 0,27, 27)];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)setBridge:(WebViewJavascriptBridge *)bridge
{
    if (bridge) {
        self.bridge = [WebViewJavascriptBridge bridgeForWebView:_webView handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"Received message from javascript: %@", data);
            responseCallback(@"Right back atcha");
        }];
    }
}

#pragma mark - refreash method
- (void)pullDownRefresh{
    if (! isLoading) {
        isLoading = YES;
        [_headerRefreshView beginRefreshing];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlstring]];
        [_webView loadRequest:request];
    }
}

#pragma mark - responder method
- (void)backAction:(UIButton *)backbutton{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)shareAction:(id)sender{
    //只需要在响应分享按钮的方法中添加以下代码即可
    
}

#pragma mark -   UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSURL* url = [request URL];
    NSString *str = [url scheme];
    NSLog(@"%@   %@",str,url);
    
    
    NSString *str2 = @"{\"className\": \"UABasePlugin\",\"callBackID\": \"print1\",\"classMethod\": \"print1\",\"arguments\": \"\"}";
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[str2 dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeNone];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    if ([webView canGoBack]) {
        _closeButton.hidden = NO;
    }
    isLoading = NO;
    [SVProgressHUD dismiss];
    [_headerRefreshView endRefreshing];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    isLoading = NO;
    [SVProgressHUD dismiss];
    [_headerRefreshView endRefreshing];
    
    if (error && error.code == kCFURLErrorNotConnectedToInternet)
    {
        NSDictionary* userInfo = [error userInfo];
        NSString* failingUrl = [userInfo objectForKey:NSURLErrorFailingURLStringErrorKey];
        if (failingUrl && [failingUrl isEqualToString:self.urlstring])
        {
            [_webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML='';"];
            [self showReloadView];
        }
    }
}

#pragma mark - UAReloadViewDelegate
- (void)reConnection{
    [self hidenReloadView];
    [self pullDownRefresh];
}

@end
