//
//  IWAccountTool.m
//  ItcastWeibo
//
//  Created by kun on 15/1/20.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "IWAccountTool.h"
#import "IWAccount.h"
#import "IWHttpToll.h"
#import "MJExtension.h"

#define IWAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation IWAccountTool

+ (void)saveAccount:(IWAccount *)account
{
    // 计算账号的过期时间
    NSDate *now = [NSDate date];
    
    account.expiresTime = [now dateByAddingTimeInterval:account.expires_in];
    
    [NSKeyedArchiver archiveRootObject:account toFile:IWAccountFile];
}

+ (IWAccount *)account
{
    // 取出账号
    IWAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:IWAccountFile];
    
    // 判断账号是否过期
    NSDate *now = [NSDate date];
    // NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending
    if([now compare:account.expiresTime] == NSOrderedAscending) // 还没有过期
    {
        return account;
    }
    else
    {
        return nil;
    }

}

+ (void)accessTokenWithParam:(IWAccessTokenParam *)param success:(void (^)(IWAccessTokenResult *))success failure:(void (^)(NSError *))failure
{
    // 1.发送请求
    [IWHttpToll postWithURL:@"https://api.weibo.com/oauth2/access_token" params:param.keyValues success:^(id json) {
        if(success)
        {
            IWAccessTokenResult *result = [IWAccessTokenResult objectWithKeyValues:json];
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
