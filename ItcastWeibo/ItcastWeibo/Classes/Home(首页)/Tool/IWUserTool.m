//
//  IWUserTool.m
//  ItcastWeibo
//
//  Created by kun on 15/1/27.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "IWUserTool.h"
#import "IWHttpToll.h"
#import "MJExtension.h"

@implementation IWUserTool

+ (void)userInfoWithParam:(IWUserInfoParam *)param success:(void (^)(IWUserInfoResult *))success failure:(void (^)(NSError *))failure
{
    // 1.发送请求
    [IWHttpToll getWithURL:@"https://api.weibo.com/2/users/show.json" params:param.keyValues success:^(id json) {
        if(success)
        {
            IWUserInfoResult *result = [IWUserInfoResult objectWithKeyValues:json];
            success(result);
        }
        
    } failure:^(NSError *error) {
        if(failure)
        {
            failure(error);
        }
    }];
}

+ (void)userUnreadCountWithParam:(IWUserUnreadCountParam *)param success:(void (^)(IWUserUnreadCountResult *result))success failure:(void (^)(NSError *error))failure
{
    // 1.发送请求
    [IWHttpToll getWithURL:@"https://rm.api.weibo.com/2/remind/unread_count.json" params:param.keyValues success:^(id json) {
        if(success)
        {
            IWUserUnreadCountResult *result = [IWUserUnreadCountResult objectWithKeyValues:json];
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
