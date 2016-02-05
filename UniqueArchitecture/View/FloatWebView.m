//
//  FloatWebView.m
//  UniqueArchitecture
//
//  Created by guochaoyang on 15/12/8.
//  Copyright © 2015年 summer. All rights reserved.
//

#import "FloatWebView.h"

@interface FloatWebView ()<UIWebViewDelegate>
{
    UIWebView *_webView;
}

@end
@implementation FloatWebView

- (instancetype)initWithUrl:(NSString *)url
{
    self = [super init];
    if (self) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _webView.delegate = self;
        _webView.backgroundColor = [UIColor clearColor];
        [self addSubview:_webView];
        
        _webView.backgroundColor = [UIColor clearColor];
        _webView.opaque = NO;
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [_webView loadRequest:request];
        
//        _webView.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
//        _webView.scrollView.scrollEnabled = NO;
        
//        for (UIView *subView in [_webView subviews]) {
//            if ([subView isKindOfClass:[UIScrollView class]]) {
//                for (UIView *shadowView in [subView subviews]) {
//                    if ([shadowView isKindOfClass:[UIImageView class]]) {
//                        shadowView.hidden = YES;
//                    }
//                } 
//            }
//        }
    }
    return self;
}

@end
