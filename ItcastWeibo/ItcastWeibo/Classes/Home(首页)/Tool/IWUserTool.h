//
//  IWUserTool.h
//  ItcastWeibo
//
//  Created by kun on 15/1/27.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWUserInfoParam.h"
#import "IWUserInfoResult.h"
#import "IWUserUnreadCountParam.h"
#import "IWUserUnreadCountResult.h"

@interface IWUserTool : NSObject
/**
 *  加载用户的个人信息
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)userInfoWithParam:(IWUserInfoParam *)param success:(void (^)(IWUserInfoResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)userUnreadCountWithParam:(IWUserUnreadCountParam *)param success:(void (^)(IWUserUnreadCountResult *result))success failure:(void (^)(NSError *error))failure;
@end
