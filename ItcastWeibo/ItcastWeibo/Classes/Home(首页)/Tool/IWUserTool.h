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

@interface IWUserTool : NSObject

+ (void)userInfoWithParam:(IWUserInfoParam *)param success:(void (^)(IWUserInfoResult *result))success failure:(void (^)(NSError *error))failure;
@end
