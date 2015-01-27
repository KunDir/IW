//
//  IWSendStatusParam.h
//  ItcastWeibo
//
//  Created by kun on 15/1/27.
//  Copyright (c) 2015年 kun. All rights reserved.
//  封装发微博的参数

#import <Foundation/Foundation.h>
#import "IWBaseParam.h"

@interface IWSendStatusParam : IWBaseParam

@property (nonatomic, copy) NSString *status;
@end
