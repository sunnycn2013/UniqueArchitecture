//
//  HomeDao.h
//  UniqueArchitecture
//
//  Created by summer on 15/5/14.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import "UABaseDao.h"
#import "News.h"

#define HOME_TABLE_NAME @"newsTable"

@interface HomeDao : UABaseDao

//dao层基本四像素操作 model : insert updata delete

/**
 *  插入news
 *
 *  @param news 实例对象
 *
 *  return void
 */
- (void)insertWithNews:(News *)news;

/**
 *  update news
 *
 *  @param Id id
 *
 *  return void
 */
- (void)updateWithNews:(News *)news andID:(NSString *)Id;

/**
 *  delete news
 *
 *  @param Id id
 *
 *  return void
 */
- (void)deleteNewsWithId:(NSString *)Id;

@end
