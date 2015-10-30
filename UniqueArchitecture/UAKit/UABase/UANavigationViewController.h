//
//  UANavigationViewController.h
//  UniqueArchitecture
//
//  Created by summer on 15/6/4.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UANavigationViewController : UINavigationController<UIGestureRecognizerDelegate>

@property (nonatomic,assign) BOOL canDragBack;
@property (nonatomic,assign) BOOL canPopScale;


@end
