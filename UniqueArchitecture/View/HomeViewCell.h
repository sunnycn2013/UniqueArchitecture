//
//  HomeViewCell.h
//  UniqueArchitecture
//
//  Created by ccguo on 15/5/18.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeViewCellDelegate <NSObject>

- (void)doSomeThing:(NSString *)str;

@end


@interface HomeViewCell : UITableViewCell
{
    @public
    NSString *_name;
}

@property (nonatomic,retain)NSMutableArray  *dataArray;
@property (nonatomic,retain)NSString        *index;

@property (nonatomic,assign)id delegate;

@end
