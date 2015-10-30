//
//  HomeViewCell.m
//  UniqueArchitecture
//
//  Created by ccguo on 15/5/18.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import "HomeViewCell.h"

@interface HomeViewCell (){
    UILabel *_desprictionLabel;
    UIButton *commontButton;
}

@end

@implementation HomeViewCell
@dynamic dataArray;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    //icon
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScaleNum(10), 10, 80, 80)];
    [iconImageView setClipsToBounds:YES];
    [iconImageView setBackgroundColor:[UIColor clearColor]];
    [iconImageView setImage:[UIImage imageNamed:@"Icon"]];
    [iconImageView.layer setBorderColor:[UIColor blackColor].CGColor];
    [iconImageView.layer setBorderWidth:0.5];
//    [iconImageView.layer setCornerRadius:40];
    [self addSubview:iconImageView];
    
    //titile
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconImageView.frame)+5, 5, SCREEN_WIDTH-CGRectGetWidth(iconImageView.frame)-35, 30)];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextAlignment:NSTextAlignmentLeft];
    [titleLabel setTextColor:[UIColor blackColor]];
    [titleLabel setText:@"Tom"];
    [self addSubview:titleLabel];

    //net
    UILabel *netType = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame), 40, 20, 20)];
    [netType setBackgroundColor:[UIColor lightGrayColor]];
    [netType setTextColor:[UIColor clearColor]];
    [netType setTextAlignment:NSTextAlignmentCenter];
    [netType setFont:[UIFont systemFontOfSize:8]];
    [netType setText:@"2G"];
    [self addSubview:netType];
    
    //des
    _desprictionLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconImageView.frame)+5, CGRectGetMaxY(titleLabel.frame), SCREEN_WIDTH-115, 60)];
    [_desprictionLabel setNumberOfLines:0];
    [_desprictionLabel setBackgroundColor:[UIColor clearColor]];
    [_desprictionLabel setTextColor:[UIColor blackColor]];
    [_desprictionLabel setTextAlignment:NSTextAlignmentJustified];
    [_desprictionLabel setText:@"众里寻她千百度..."];
    [self addSubview:_desprictionLabel];
    
    
    commontButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commontButton.frame = CGRectMake(SCREEN_WIDTH-60, self.frame.size.height-30, 60, 30);
    [commontButton setTitle:@"zan" forState:UIControlStateNormal];
    [commontButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [commontButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:commontButton];
}

- (void)setIndex:(NSString *)index{
//    [commontButton setTitle:self.index forState:UIControlStateNormal];
    _index = index;
    _desprictionLabel.text = index;
}

- (void)clickAction:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(doSomeThing:)]) {
        [self.delegate doSomeThing:self.index];
    }
}

@end
