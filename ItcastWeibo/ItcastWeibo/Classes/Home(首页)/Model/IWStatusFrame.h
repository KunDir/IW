//
//  IWStatusFrame.h
//  ItcastWeibo
//
//  Created by kun on 15/1/21.
//  Copyright (c) 2015年 kun. All rights reserved.
//  一个Cell对应一个IWStatusFrame对象

#import <Foundation/Foundation.h>


@class IWStatus;

@interface IWStatusFrame : NSObject
@property (nonatomic, strong) IWStatus *status;

// 顶部的view
@property (nonatomic, assign, readonly) CGRect topViewF;
// 头像
@property (nonatomic, assign, readonly) CGRect iconViewF;
// 会员图标
@property (nonatomic, assign, readonly) CGRect vipViewF;
// 配图
@property (nonatomic, assign, readonly) CGRect photoViewF;
// 昵称
@property (nonatomic, assign, readonly) CGRect nameLabelF;
// 时间
@property (nonatomic, assign, readonly) CGRect timeLabelF;
// 来源
@property (nonatomic, assign, readonly) CGRect sourceLabelF;
// 正文\内容
@property (nonatomic, assign, readonly) CGRect contentLabelF;

// 被转发微博的View（父控件）
@property (nonatomic, assign, readonly) CGRect retweetViewF;
// 被转发微博作者的昵称
@property (nonatomic, assign, readonly) CGRect retweetNameLabelF;
// 被转发微博的正文\内容
@property (nonatomic, assign, readonly) CGRect retweetContentLabelF;
// 被转发微博的配图
@property (nonatomic, assign, readonly) CGRect retweetPhotosViewF;

// 微博的工具条
@property (nonatomic, assign, readonly) CGRect statusToolbarF;

// 微博Cell的高度
@property (nonatomic, assign, readonly) CGFloat cellHeight;
@end
