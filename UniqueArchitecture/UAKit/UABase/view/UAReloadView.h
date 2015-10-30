//
//  UAReloadView.h
//  UniqueArchitecture
//
//  Created by summer on 15/6/18.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UAReloadViewDelegate <NSObject>

- (void)reConnection;

@end

@interface UAReloadView : UIView{
    UIImageView             *_imageView;
    UILabel                 *_desprictionLable;
    UITapGestureRecognizer  *_tap;
}

@property (nonatomic,assign) id delegate;

@end
