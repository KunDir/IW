//
//  IWStatusTool.h
//  ItcastWeibo
//
//  Created by kun on 15/1/27.
//  Copyright (c) 2015年 kun. All rights reserved.
//  业务工具类

#import <Foundation/Foundation.h>
@class IWHomeStatusesParam;
@interface IWStatusTool : NSObject
+ (void)homeStatusesWithParam:(IWHomeStatusesParam *)param success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
@end
