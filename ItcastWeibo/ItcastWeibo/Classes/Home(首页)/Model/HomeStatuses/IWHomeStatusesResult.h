//
//  IWHomeStatusesResult.h
//  ItcastWeibo
//
//  Created by kun on 15/1/27.
//  Copyright (c) 2015年 kun. All rights reserved.
//  封装加载首页模型数据

#import <Foundation/Foundation.h>

@interface IWHomeStatusesResult : NSObject
@property (nonatomic, strong) NSArray *statuses;

@property (nonatomic, assign) long long previous_cursor;

@property (nonatomic, assign) long long next_cursor;

@property (nonatomic, assign) long long total_number;
@end
