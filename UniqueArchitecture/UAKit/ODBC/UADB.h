//
//  UADBManager.h
//  UniqueArchitecture
//
//  Created by ccguo on 15/5/12.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UADB : NSObject

/*!
 *  创建数据库
 *
 *  @return 实例对象
 */
+ (instancetype)shareInstance;


/*!
 *  打开数据库
 *
 *  @since 1.0
 */
- (void)open;


/*!
 *  关闭数据库
 *
 *  @since 1.0
 */
- (void) close;

/*!
 *  获取FMDatabase
 *
 *  @return FMDatabase
 *
 *  @since 1.0
 */
- (FMDatabaseQueue *) getDBQueue;

@end
