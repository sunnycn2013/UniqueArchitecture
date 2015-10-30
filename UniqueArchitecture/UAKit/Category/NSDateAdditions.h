//
//  NSDateAdditions.h
//
//  Copyright 2011 360buy. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (JDCategory) 



- (NSUInteger)getDay;
- (NSUInteger)getMonth;
- (NSUInteger)getYear;
- (int )getHour;
- (int )getMinute;

+ (NSDate *)dateWithString:(NSString *)dateStr;
+ (NSDate *)currentZoneDateWithUTCDate:(NSDate *)date;

//返回yyyy-MM-dd格式字符串
+ (NSString *)shortStringWithDate:(NSDate *)date;

//根据yyyy-MM-dd格式字符串返回时间
+ (NSDate *)shortDateWithString:(NSString *)string;

//提取完整时间的yyyy-MM-dd部分
+ (NSDate *)shortDateWithDate:(NSDate *)date;

//返回yyyy年MM月dd日字符串
+ (NSString *)chinenseShortStringWithDate:(NSDate *)date;

@end
