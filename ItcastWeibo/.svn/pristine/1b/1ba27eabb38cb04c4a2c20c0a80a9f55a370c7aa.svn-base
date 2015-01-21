//
//  IWAccount.h
//  ItcastWeibo
//
//  Created by kun on 15/1/20.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWAccount : NSObject <NSCoding>

@property (nonatomic, strong) NSDate *expiresTime; // 账号过期时间
// 如果服务器返回的数字很大，建议用long long（比如主键，ID）
@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, assign) long long expires_in;
@property (nonatomic, assign) long long remind_in;
@property (nonatomic, assign) long long uid;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)accountWithDict:(NSDictionary *)dict;
@end
