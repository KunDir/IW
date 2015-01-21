//
//  IWStatusCell.m
//  ItcastWeibo
//
//  Created by kun on 15/1/21.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "IWStatusCell.h"

@interface IWStatusCell ()

// 顶部的view
@property (nonatomic, weak) UIImageView *topView;
// 头像
@property (nonatomic, weak) UIImageView *iconView;
// 会员图标
@property (nonatomic, weak) UIImageView *vipView;
// 配图
@property (nonatomic, weak) UIImageView *photoView;
// 昵称
@property (nonatomic, weak) UILabel *nameLabel;
// 时间
@property (nonatomic, weak) UILabel *timeLabel;
// 来源
@property (nonatomic, weak) UILabel *sourceLabel;
// 正文\内容
@property (nonatomic, weak) UILabel *contentLabel;

// 被转发微博的View（父控件）
@property (nonatomic, weak) UIImageView *retweetView;
// 被转发微博作者的昵称
@property (nonatomic, weak) UILabel *retweetNameLabel;
// 被转发微博的正文\内容
@property (nonatomic, weak) UILabel *retweetContentLabel;
// 被转发微博的配图
@property (nonatomic, weak) UIImageView *retweetPhotoView;

// 微博的工具条
@property (nonatomic, weak) UIImageView *statusToolbar;
@end

@implementation IWStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        // 1.添加原创微博内部的子控件
        [self setupOriginalSubviews];
        
        // 2.添加被转发微博内部的子控件
        [self setupRetweetSubviews];
        
        // 3.添加微博的工具条
        [self setupStatusToolBar];
        
    }
    return self;
}

// 添加原创微博内部的子控件
- (void)setupOriginalSubviews
{
    // 1.顶部的view
    UIImageView *topView = [[UIImageView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
    
    // 2.头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.topView addSubview:iconView];
    self.iconView = iconView;
    
    // 3.会员图标
    UIImageView *vipView = [[UIImageView alloc] init];
    [self.topView addSubview:vipView];
    self.vipView = vipView;
    
    // 4.配图
    UIImageView *photoView = [[UIImageView alloc] init];
    [self.topView addSubview:photoView];
    self.photoView = photoView;
    
    // 5.昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    [self.topView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    // 6.时间
    UILabel *timeLabel = [[UILabel alloc] init];
    [self.topView addSubview:timeLabel];
    self.timeLabel = timeLabel;

    // 7.来源
    UILabel *sourceLabel = [[UILabel alloc] init];
    [self.topView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;

    // 8.正文\内容
    UILabel *contentLabel = [[UILabel alloc] init];
    [self.topView addSubview:contentLabel];
    self.contentLabel = contentLabel;

    
}

// 添加被转发微博内部的子控件
- (void)setupRetweetSubviews
{
    // 1.被转发微博的View（父控件）
    UIImageView *retweetView = [[UIImageView alloc] init];
    [self.topView addSubview:retweetView];
    self.retweetView = retweetView;

    // 2.被转发微博作者的昵称
    UILabel *retweetNameLabel = [[UILabel alloc] init];
    [self.retweetView addSubview:retweetNameLabel];
    self.retweetNameLabel = retweetNameLabel;

    // 3.被转发微博的正文\内容
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    [self.retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;

    // 4.被转发微博的配图
    UIImageView *retweetPhotoView = [[UIImageView alloc] init];
    [self.retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;

}

// 添加微博的工具条
- (void)setupStatusToolBar
{
    // 1.微博的工具条
    UIImageView *statusToolbar = [[UIImageView alloc] init];
    [self.contentView addSubview:statusToolbar];
    self.statusToolbar = statusToolbar;
}

// 用代码创建时会调用
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        
    }
    return self;
}

@end
