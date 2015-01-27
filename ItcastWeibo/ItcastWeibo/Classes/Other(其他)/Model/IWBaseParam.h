//
//  IWBaseParam.h
//  ItcastWeibo
//
//  Created by kun on 15/1/27.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWBaseParam : NSObject

@property (nonatomic, copy) NSString *access_token;

+ (instancetype)param;

@end
