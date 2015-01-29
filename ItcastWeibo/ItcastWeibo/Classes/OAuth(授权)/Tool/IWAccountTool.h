//
//  IWAccountTool.h
//  ItcastWeibo
//
//  Created by kun on 15/1/20.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWAccessTokenParam.h"
#import "IWAccessTokenResult.h"
@class IWAccount;

@interface IWAccountTool : NSObject
+ (void)saveAccount:(IWAccount *)account;
+ (IWAccount *)account;

+ (void)accessTokenWithParam:(IWAccessTokenParam *)param success:(void(^)(IWAccessTokenResult *result))success failure:(void(^)(NSError *error))failure;
@end
