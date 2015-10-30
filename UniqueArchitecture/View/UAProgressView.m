//
//  UAProgressView.m
//  UniqueArchitecture
//
//  Created by ccguo on 15/7/2.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import "UAProgressView.h"

@interface UAProgressView ()
{
    UIView *_bgView;
    UIView *_progressView;
}

@property (nonatomic,assign) CGFloat progressWidth;

@end

@implementation UAProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)awakeFromNib{
    [self setUI];
}

- (void)setUI
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    self.progressWidth = width;

    self.frame = CGRectMake(x, y, width, 10);
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(x, 0, width, height)];
    _bgView.backgroundColor = [UIColor lightGrayColor];
    _bgView.layer.cornerRadius = height/2;
    _bgView.layer.masksToBounds = YES;
    [self addSubview:_bgView];
    
    _progressView = [[UIView alloc] initWithFrame:CGRectMake(x, 0, 0, height)];
    _progressView.backgroundColor = [UIColor redColor];
    _progressView.layer.cornerRadius = height/2;
    _progressView.layer.masksToBounds = YES;
    [self addSubview:_progressView];
}

- (void)setProgress:(CGFloat)progress
{
    [UIView animateWithDuration:1 animations:^{
        [_progressView setWidth:self.progressWidth * progress];
    }];
}
@end
