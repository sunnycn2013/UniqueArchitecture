//
//  UANewWebViewController.h
//  UniqueArchitecture
//
//  Created by ccguo on 15/5/14.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import "UAViewController.h"

@interface UANewWebViewController : UAViewController

@property (nonatomic,assign)BOOL isSupportShare;
@property (nonatomic,assign)BOOL isBackToTop;

- (instancetype)initWithUrlString:(NSString *)urlString;

@end
