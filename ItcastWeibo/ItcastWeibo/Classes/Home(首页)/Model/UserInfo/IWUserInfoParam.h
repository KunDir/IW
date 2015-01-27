//
//  IWUserInfoParam.h
//  ItcastWeibo
//
//  Created by kun on 15/1/27.
//  Copyright (c) 2015年 kun. All rights reserved.
//  封装加载用户信息的参数

#import <Foundation/Foundation.h>
#import "IWBaseParam.h"

@interface IWUserInfoParam : IWBaseParam

@property (nonatomic, strong) NSNumber *uid;

@property (nonatomic, copy) NSString *screen_name;
@end
