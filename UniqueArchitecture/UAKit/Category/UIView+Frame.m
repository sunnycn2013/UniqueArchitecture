//
//  UIView+Frame.m
//  UniqueArchitecture
//
//  Created by summer on 15/6/18.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
@dynamic width;
@dynamic height;
@dynamic centerX;
@dynamic centerY;

- (void)resizeViewFrame:(CGRect)rect{
    self.frame = rect;
}

- (void)setWidth:(CGFloat)width{
    CGRect rect = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
    [self resizeViewFrame:rect];
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    CGRect rect = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
    [self resizeViewFrame:rect];
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint point = CGPointMake(centerX, self.center.y);
    self.center = point;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint point = CGPointMake(self.center.x, centerY);
    self.center = point;
}

- (CGFloat)centerY{
    return self.center.y;
}

@end
