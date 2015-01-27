//
//  IWStatusTool.m
//  ItcastWeibo
//
//  Created by kun on 15/1/27.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "IWStatusTool.h"
#import "IWHttpToll.h"
#import "IWHomeStatusesParam.h"
#import "MJExtension.h"
#import "IWHomeStatusesResult.h"

@implementation IWStatusTool

+ (void)homeStatusesWithParam:(IWHomeStatusesParam *)param success:(void (^)(IWHomeStatusesResult *))success failure:(void (^)(NSError *))failure
{
    // 1.发送请求
    [IWHttpToll getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:param.keyValues success:^(id json) {
        if(success)
        {
            IWHomeStatusesResult *result = [IWHomeStatusesResult objectWithKeyValues:json];
            success(result);
        }
        
    } failure:^(NSError *error) {
        if(failure)
        {
            failure(error);
        }
    }];
}

+ (void)sendStatusWithParam:(IWSendStatusParam *)param success:(void (^)(IWSendStatusResult *))success failure:(void (^)(NSError *))failure
{
    // 1.发送请求
    [IWHttpToll postWithURL:@"https://api.weibo.com/2/statuses/update.json" params:param.keyValues success:^(id json) {
        if(success)
        {
            IWSendStatusResult *result = [IWSendStatusResult objectWithKeyValues:json];
            success(result);
        }
        
    } failure:^(NSError *error) {
        if(failure)
        {
            failure(error);
        }
    }];
}

@end
