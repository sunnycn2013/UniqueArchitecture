//
//  NSDateAdditions.m
//
//  Copyright 2011 360buy. All rights reserved.
//

#import "NSDateAdditions.h"


@implementation NSDate(JDCategory)

- (NSUInteger)getDay{
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:self];
	return [dayComponents day];
}

- (NSUInteger)getMonth
{
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit) fromDate:self];
	return [dayComponents month];
}
- (NSUInteger)getYear
{
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:self];
	return [dayComponents year];
}
- (int )getHour {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSUInteger unitFlags =NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit |NSMinuteCalendarUnit;
	NSDateComponents *components = [calendar components:unitFlags fromDate:self];
	NSInteger hour = [components hour];
	return (int)hour;
}

- (int)getMinute {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSUInteger unitFlags =NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit |NSMinuteCalendarUnit;
	NSDateComponents *components = [calendar components:unitFlags fromDate:self];
	NSInteger minute = [components minute];
	return (int)minute;
}


+ (NSDate *) dateWithString:(NSString *)dateStr {
	
	NSTimeZone *tzGMT = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];    
	[NSTimeZone setDefaultTimeZone:tzGMT];
	NSDateFormatter *formate = [[NSDateFormatter alloc] init];
	[formate setTimeZone:tzGMT];
	[formate setDateFormat:(@"yyyy-MM-dd HH:mm:ss")];
	NSDate *dateSet = [formate dateFromString:[NSString stringWithFormat:@"%@ 20:00:00",dateStr]];
	
	return dateSet;
}

+ (NSDate *)currentZoneDateWithUTCDate:(NSDate *)date{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return localeDate;
}


+ (NSString *)shortStringWithDate:(NSDate *)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *string = [dateFormat stringFromDate:date];
    return string;
}
+ (NSDate *)shortDateWithString:(NSString *)string
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormat dateFromString:string];
    return date;
}
+ (NSDate *)shortDateWithDate:(NSDate *)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormat stringFromDate:date];
    NSDate *newDate = [dateFormat dateFromString:dateString];
    return newDate;
}

+ (NSString *)chinenseShortStringWithDate:(NSDate *)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy年MM月dd日"];
    NSString *string = [dateFormat stringFromDate:date];
    return string;
}

@end
