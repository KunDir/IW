//
//  IWStatusCacheTool.h
//  ItcastWeibo
//
//  Created by kun on 15/1/29.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWHomeStatusesParam.h"
@class IWStatus;

@interface IWStatusCacheTool : NSObject

/**
 *  缓存一条微博
 *
 *  @param status 需要缓存的微博数据
 */
+ (void)addStatus:(IWStatus *)status;

/**
 *  缓存多条微博
 *
 *  @param statusArray 需要缓存的微博数据
 */
+ (void)addStatuses:(NSArray *)statusArray;

/**
 *  根据请求参数获得微博数据
 *
 *  @param param 请求参数
 *  
 *  @return 字典数组
 */
+ (NSArray *)statusWithParam:(IWHomeStatusesParam *)param;
@end
