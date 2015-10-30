//
//  UADialog.h
//  UniqueArchitecture
//
//  Created by summer on 15/6/17.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UADialog : UIView

+ (void)showSuccessWithStatus:(NSString *)message;
+ (void)showErrorWithStatus:(NSString *)message;

//
+ (void)showNetWorkError;
+ (void)showNetWorkIndicatorView;
+ (void)dismiss;

- (void)showSuccesMessageWith:(NSString *)msg;
- (void)showFailureMessageWith:(NSString *)msg;

@end
