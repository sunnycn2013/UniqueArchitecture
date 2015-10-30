//
//  HomeDao.m
//  UniqueArchitecture
//
//  Created by summer on 15/5/14.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import "HomeDao.h"

@implementation HomeDao

- (instancetype)init{
    self = [super init];
    
    if (self) {
        //
        self.tableName = HOME_TABLE_NAME;
        self.modelName = @"News";
//        [self checkTable];
    }
    return self;
}

/*/*SELECT COUNT(*) FROM sqlite_master where type='table' and name='PackDaoTable';*/

//- (void)checkTable{
//    NSString *createTable = [NSString stringWithFormat:@"CREATE TABLE if not exists %@ ('id' INTEGER PRIMARY KEY  NOT NULL ,'name' TEXT,'sid' TEXT)", self.tableName];
//    [self checkTableAvaiableWithSql:createTable];
//}
//
//- (void)insertWithNews:(News *)news{
//    NSString *sql = [NSString stringWithFormat:@"insert into %@(name,sid)vaues(%@,%@)",self.tableName,news.city,news.time];
//    [self insertWithSql:sql];
//}
//
//- (void)updateWithNews:(News *)news andID:(NSString *)Id{
//    NSString *sql = [NSString stringWithFormat:@"update %@ set name=%@,sid=%@ where id=%d",self.tableName,news.city,news.time,[Id intValue]];
//    [self updateWithSql:sql withArgumentsInArray:nil];
//}
//
//- (void)deleteNewsWithId:(NSString *)Id{
//    NSString *sql = [NSString stringWithFormat:@"delete from %@ where id=%d",self.tableName,[Id intValue]];
//    [self deleteWithSql:sql andDictionary:nil];
//}
@end
