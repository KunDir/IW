//
//  IWStatus.h
//  ItcastWeibo
//
//  Created by kun on 15/1/20.
//  Copyright (c) 2015年 kun. All rights reserved.
//  微博模型（一个IWStatus对象就代表一条微博）

#import <Foundation/Foundation.h>
@class IWUser;

@interface IWStatus : NSObject

// 微博的内容（文字）
@property (nonatomic, copy) NSString *text;

// 微博的来源
@property (nonatomic, copy) NSString *source;

// 微博的时间
@property (nonatomic, copy) NSString *created_at;

// 微博的ID
@property (nonatomic, copy) NSString *idstr;

// 微博的转发数
@property (nonatomic, assign) int reposts_count;

// 微博的评论数
@property (nonatomic, assign) int comments_count;

// 微博的表态数（被赞数）
@property (nonatomic, assign) int attitudes_count;

// 微博的作者
@property (nonatomic, strong) IWUser *user;

// 微博的配图
//@property (nonatomic, copy) NSString *thumbnail_pic;
@property (nonatomic, strong) NSArray *pic_urls;

// 被转发的微博
@property (nonatomic, strong) IWStatus *retweeted_status;
@end
