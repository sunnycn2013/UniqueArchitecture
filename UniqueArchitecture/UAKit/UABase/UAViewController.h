//
//  UAViewController.h
//  UniqueArchitecture
//
//  Created by summer on 15/5/8.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UAReloadView.h"

@interface UAViewController : UIViewController{
    UAReloadView *_reloadView;
}

//活动指示器
- (void)showNetWorkIndicatorView;
- (void)dismissNetWorkIndicatorView;
- (void)showNetWorkError;

//重新加载view
- (void)showReloadView;
- (void)hidenReloadView;

//show message
- (void)showSuccesMessageWith:(NSString *)msg;
- (void)showErrorMessageWith:(NSString *)msg;

@end
