//
//  IWStatusTool.h
//  ItcastWeibo
//
//  Created by kun on 15/1/27.
//  Copyright (c) 2015年 kun. All rights reserved.
//  微博业务工具类

#import <Foundation/Foundation.h>
#import "IWHomeStatusesParam.h"
#import "IWHomeStatusesResult.h"

#import "IWSendStatusParam.h"
#import "IWSendStatusResult.h"

@interface IWStatusTool : NSObject
+ (void)homeStatusesWithParam:(IWHomeStatusesParam *)param success:(void (^)(IWHomeStatusesResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)sendStatusWithParam:(IWSendStatusParam *)param success:(void (^)(IWSendStatusResult *result))success failure:(void (^)(NSError *error))failure;
@end
