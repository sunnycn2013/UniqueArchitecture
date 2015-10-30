//
//  UABaseDao.h
//  UniqueArchitecture
//
//  Created by summer on 15/5/12.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UABaseDao : NSObject{
    
}

@property (nonatomic,retain) NSString         *tableName;
@property (nonatomic,retain) NSString         *modelName;
@property (nonatomic,retain) FMDatabaseQueue  *databasebQueue;

/**
 *  插入操作
 *
 *  @param params 参数
 *
 *  @return void
 */
- (void)insertWithSql:(NSString *)sql;

/**
 *  删除数据
 *
 *  @param sql    sql语句
 *  @param params 参数
 *
 *  @return void
 */
- (void)deleteWithSql:(NSString *)sql withArgumentsInArray:(NSArray *)array;
/**
 *  更新
 *
 *  @param sql    sql语句
 *  @param params 参数
 *
 *  @return void
 */
- (void)updateWithSql:(NSString *)sql withArgumentsInArray:(NSArray *)array;

/**
 *  查询
 *
 *  @param sql sql语句
 *
 *  @return void
 */
- (FMResultSet *)queryWithSql:(NSString *)sql;

- (void)checkTableAvaiableWithSql:(NSString *)sql;

@end
