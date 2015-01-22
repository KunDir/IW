//
//  IWStatus.m
//  ItcastWeibo
//
//  Created by kun on 15/1/20.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "IWStatus.h"
#import "IWUser.h"
#import "NSDate+IW.h"
@implementation IWStatus

- (NSString *)created_at
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 1.获得微博的发送时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyy";
    NSDate * createdDate = [fmt dateFromString:_created_at];
    NSDateComponents *createdDateCmps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:createdDate];
    
    // 2.获取当前时间
    NSDate *now = [NSDate date];
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:now];
    
    // 3.判断微博发送时间 和 现在时间 的差距
    if([createdDate isToday]) // 今天
    {
        if(createdDate.deltaWithNow.hour > 1)
        {
            return [NSString stringWithFormat:@"%d小时前",createdDate.deltaWithNow.hour];
        }
        else if(createdDate.deltaWithNow.minute >= 1)
        {
            return [NSString stringWithFormat:@"%d分钟前",createdDate.deltaWithNow.minute];
        }
        else
        {
            return @"刚刚";
        }
    }
    else if(createdDate.isYesterday) // 昨天
    {
        fmt.dateFormat = @"昨天 HH:mm";
        return [fmt stringFromDate:createdDate];
    }
    else if (createdDate.isThisYear) // 今年（至少是前天）
    {
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }
    else // 非今年
    {
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }
    
}
@end
