//
//  NSDate+IW.m
//  ItcastWeibo
//
//  Created by kun on 15/1/22.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "NSDate+IW.h"

@implementation NSDate (IW)

- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitMonth;
    
    // 1.获得当前时间年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获取self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return (nowCmps.year == selfCmps.year) && (nowCmps.month == selfCmps.month) && (nowCmps.day == selfCmps.day);
}

- (BOOL)isYesterday
{
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    int unit = NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitMonth;
//    
//    // 1.获得当前时间年月日
//    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
//    
//    // 2.获取self的年月日
//    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
//    
//
    return NO;
}

- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    // 1.获得当前时间年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获取self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year;
}

- (NSDateComponents *)deltaWithNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int uint = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:uint fromDate:self toDate:[NSDate date] options:0];
}
@end
