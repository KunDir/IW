//
//  IWHomeStatusesParam.h
//  ItcastWeibo
//
//  Created by kun on 15/1/27.
//  Copyright (c) 2015年 kun. All rights reserved.
//  

#import <Foundation/Foundation.h>

@interface IWHomeStatusesParam : NSObject
@property (nonatomic, copy) NSString *access_token;

@property (nonatomic, assign) long long since_id;

@property (nonatomic, assign) long long max_id;

@property (nonatomic, assign) int count;
@end
