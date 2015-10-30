//
//  UActivityView.m
//  UniqueArchitecture
//
//  Created by ccguo on 15/6/4.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import "UActivityView.h"

@interface UActivityView (){
    UIImageView *_imageView;
    BOOL isPause;
}

@end

@implementation UActivityView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //
        [self setUI];
    }
    return self;
}

- (void)setUI{
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _imageView.image = [UIImage imageNamed:@"ua_refresh"];
    [self addSubview:_imageView];
//    [self startAnimation];
}

- (void)startAnimation{
    CABasicAnimation* rotationAnimation = nil;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 3;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = INTMAX_MAX;
    
    [_imageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)stopAnimation{
    [_imageView.layer removeAllAnimations];
}


//暂停layer上面的动画
- (void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

//继续layer上面的动画
- (void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

- (void)pauseSoccer
{
    isPause = YES;
    [self pauseLayer:_imageView.layer];
}

- (void)resumeSoccer
{
    isPause = NO;
    [self resumeLayer:_imageView.layer];
}

- (void)player{
    if (isPause) {
        [self resumeSoccer];
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self pauseSoccer];
        });
    }
}
@end
