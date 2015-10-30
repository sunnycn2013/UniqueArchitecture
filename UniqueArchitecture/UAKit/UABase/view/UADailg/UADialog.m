//
//  UADialog.m
//  UniqueArchitecture
//
//  Created by summer on 15/6/17.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import "UADialog.h"

@implementation UADialog

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (void)showSuccessWithStatus:(NSString *)message {
    [SVProgressHUD showSuccessWithStatus:message maskType:SVProgressHUDMaskTypeNone];
}

+ (void)showErrorWithStatus:(NSString *)message {
    [SVProgressHUD showErrorWithStatus:message maskType:SVProgressHUDMaskTypeNone];
}

+ (void)showNetWorkError{
    [self showErrorWithStatus:@"UANetWorkError"];
}

+ (void)showNetWorkIndicatorView{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeNone];
}

+ (void)dismiss{
    [SVProgressHUD dismiss];
}

//提示message
- (void)showSuccesMessageWith:(NSString *)msg{
    [SVProgressHUD showSuccessWithStatus:msg maskType:SVProgressHUDMaskTypeNone];
}

- (void)showFailureMessageWith:(NSString *)msg{
    [SVProgressHUD showErrorWithStatus:msg maskType:SVProgressHUDMaskTypeNone];
}

@end
