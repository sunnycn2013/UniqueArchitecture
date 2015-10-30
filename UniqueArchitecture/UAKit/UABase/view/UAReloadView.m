//
//  UAReloadView.m
//  UniqueArchitecture
//
//  Created by summer on 15/6/18.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import "UAReloadView.h"

@implementation UAReloadView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        //
        [self setUI];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)setUI{
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"networkerror"]];
    _imageView.center = self.center;
    _imageView.userInteractionEnabled = YES;
    [self addSubview:_imageView];
    
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabAction:)];
    [_imageView addGestureRecognizer:_tap];
    
    _desprictionLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - 40, 60)];
    _desprictionLable.centerY = CGRectGetMaxY(_imageView.frame) + 50;
    _desprictionLable.backgroundColor = [UIColor clearColor];
    _desprictionLable.text = @"当前网络不可用，请检查您的网络设置 点击屏幕刷新";
    _desprictionLable.textAlignment = NSTextAlignmentCenter;
    _desprictionLable.numberOfLines = 0;
    _desprictionLable.lineBreakMode = NSLineBreakByCharWrapping;
    [self addSubview:_desprictionLable];
}

- (void)tabAction:(id)sender{
    if ([self.delegate respondsToSelector:@selector(reConnection)]) {
        [self.delegate reConnection];
    }
}

@end
