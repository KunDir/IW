//
//  NSDate+IW.h
//  ItcastWeibo
//
//  Created by kun on 15/1/22.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (IW)
/**
 *  是否为今天
 */
- (BOOL)isToday;

/**
 *  是否为昨天
 */
- (BOOL)isYesterday;

/**
 *  是否为今年
 */
- (BOOL)isThisYear;

- (NSDateComponents *)deltaWithNow;
@end
