//
//  IWUser.h
//  ItcastWeibo
//
//  Created by kun on 15/1/20.
//  Copyright (c) 2015年 kun. All rights reserved.
//  微博作者

#import <Foundation/Foundation.h>

@interface IWUser : NSObject

// 微博的ID
@property (nonatomic, copy) NSString *idstr;

// 微博用户名
@property (nonatomic, copy) NSString *name;

// 头像
@property (nonatomic, copy) NSString *profile_image_url;

// 是否为vip
@property (nonatomic, assign, getter = isVip) BOOL vip;


@end
