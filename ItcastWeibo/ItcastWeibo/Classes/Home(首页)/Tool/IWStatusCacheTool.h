//
//  IWStatusCacheTool.h
//  ItcastWeibo
//
//  Created by kun on 15/1/29.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWHomeStatusesParam.h"

@interface IWStatusCacheTool : NSObject

/**
 *  缓存一条微博
 *
 *  @param dict 需要缓存的微博数据
 */
+ (void)addStatus:(NSDictionary *)dict;

/**
 *  缓存多条微博
 *
 *  @param dictArray 需要缓存的微博数据
 */
+ (void)addStatuses:(NSArray *)dictArray;

/**
 *  根据请求参数获得微博数据
 *
 *  @param param 请求参数
 *  
 *  @return 字典数组
 */
+ (NSArray *)statusWithParam:(IWHomeStatusesParam *)param;
@end
