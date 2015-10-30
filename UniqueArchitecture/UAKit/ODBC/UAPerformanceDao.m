//
//  UAPerformanceDao.m
//  UniqueArchitecture
//
//  Created by guochaoyang on 15/10/28.
//  Copyright © 2015年 summer. All rights reserved.
//

#import "UAPerformanceDao.h"

@implementation UAPerformanceDao

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tableName = @"performance";
        NSString *tableCreateSQL = [NSString stringWithFormat:@"CREATE TABLE %@ ('id' INTEGER PRIMARY KEY  NOT NULL ,'content' TEXT,'type' TEXT)", self.tableName];
        [self checkTableAvaiableWithSql:tableCreateSQL];
    }
    return self;
}


@end
