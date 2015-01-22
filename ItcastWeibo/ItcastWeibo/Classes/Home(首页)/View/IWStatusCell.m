//
//  IWStatusCell.m
//  ItcastWeibo
//
//  Created by kun on 15/1/21.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "IWStatusCell.h"

#import "IWStatusFrame.h"
#import "IWStatus.h"
#import "IWUser.h"
#import "UIImageView+WebCache.h"

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
    // 0.设置cell选中时的背景
//    self.selectedBackgroundView = [[UIView alloc] init];
    
    // 1.顶部的view
    UIImageView *topView = [[UIImageView alloc] init];
    topView.image = [UIImage resizedImageWithName:@"timeline_card_top_background"];
    topView.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_top_background_highlighted"];
    [self.contentView addSubview:topView];
    self.topView = topView;
    
    // 2.头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.topView addSubview:iconView];
    self.iconView = iconView;
    
    // 3.会员图标
    UIImageView *vipView = [[UIImageView alloc] init];
    vipView.contentMode = UIViewContentModeCenter;
    [self.topView addSubview:vipView];
    self.vipView = vipView;
    
    // 4.配图
    UIImageView *photoView = [[UIImageView alloc] init];
    [self.topView addSubview:photoView];
    self.photoView = photoView;
    
    // 5.昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = IWStatusNameFont;
    nameLabel.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    // 6.时间
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = IWStatusTimeFont;
    timeLabel.textColor = IWColor(235, 105, 26);
    timeLabel.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:timeLabel];
    self.timeLabel = timeLabel;

    // 7.来源
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = IWStatusSourceFont;
    sourceLabel.textColor = IWColor(135, 135, 135);
    sourceLabel.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;

    // 8.正文\内容
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.font = IWStatusContentFont;
    contentLabel.textColor = IWColor(39, 39, 39);
    contentLabel.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:contentLabel];
    self.contentLabel = contentLabel;

    
}

// 添加被转发微博内部的子控件
- (void)setupRetweetSubviews
{
    // 1.被转发微博的View（父控件）
    UIImageView *retweetView = [[UIImageView alloc] init];
    retweetView.image = [UIImage resizedImageWithName:@"oldtimeline_retweet_background" left:0.9 top:0.5];
    [self.topView addSubview:retweetView];
    self.retweetView = retweetView;

    // 2.被转发微博作者的昵称
    UILabel *retweetNameLabel = [[UILabel alloc] init];
    retweetNameLabel.font = IWRetweetStatusNameFont;
    retweetNameLabel.backgroundColor = [UIColor clearColor];
    retweetNameLabel.textColor = IWColor(21, 88, 180);
    [self.retweetView addSubview:retweetNameLabel];
    self.retweetNameLabel = retweetNameLabel;

    // 3.被转发微博的正文\内容
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    retweetContentLabel.font = IWRetweetStatusContentFont;
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.backgroundColor = [UIColor clearColor];
    retweetContentLabel.textColor = IWColor(90, 90, 90);
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
    statusToolbar.image = [UIImage resizedImageWithName:@"timeline_card_bottom_background"];
    statusToolbar.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_bottom_background_highlighted"];
    [self.contentView addSubview:statusToolbar];
    self.statusToolbar = statusToolbar;
}

// 拦截frame设置
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = IWStatusTableBorder;
    frame.origin.y += IWStatusTableBorder;
    frame.size.width -= 2 * IWStatusTableBorder;
    frame.size.height -= IWStatusTableBorder;
    [super setFrame:frame];
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

// 设置传递过来的模型数据
- (void)setStatusFrame:(IWStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 1.原创微博
    [self setupOriginalData];
    
    // 2.被转发微博
    [self setupRetweetData];
    
    // 3.微博工具条
    [self setupStatusToolbar];
}

// 微博工具条
- (void)setupStatusToolbar
{
    self.statusToolbar.frame = self.statusFrame.statusToolbarF;
}

// 原创微博
- (void)setupOriginalData
{
    IWStatus *status = self.statusFrame.status;
    IWUser *user = status.user;
    
    // 1.topView;
    self.topView.frame = self.statusFrame.topViewF;
    
    // 2.头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    self.iconView.frame = self.statusFrame.iconViewF;
    
    // 3.昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.statusFrame.nameLabelF;
    
    // 4.vip
    if(user.mbtype)
    {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageWithName:[NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank]];
        self.vipView.frame = self.statusFrame.vipViewF;
        
        self.nameLabel.textColor = [UIColor orangeColor];
    }
    else
    {
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    // 5.时间
    self.timeLabel.text = status.created_at;
    CGFloat timeLabelX = self.statusFrame.nameLabelF.origin.x;
    CGFloat timeLabelY = CGRectGetMaxY(self.statusFrame.nameLabelF) + IWStatusCellBorder * 0.5;
    NSMutableDictionary *timeAttrs = [NSMutableDictionary dictionary];
    timeAttrs[NSFontAttributeName] = IWStatusTimeFont;
    CGSize timeLabelSize = [status.created_at sizeWithAttributes:timeAttrs];
    self.timeLabel.frame = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
    // 6.来源
    self.sourceLabel.text = status.source;
    CGFloat sourceLabelX = CGRectGetMaxX(self.timeLabel.frame) + IWStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    NSMutableDictionary *sourceAttrs = [NSMutableDictionary dictionary];
    sourceAttrs[NSFontAttributeName] = IWStatusSourceFont;
    CGSize sourceLabelSize = [status.source sizeWithAttributes:sourceAttrs];
    self.sourceLabel.frame = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};
    
    // 7.正文
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.statusFrame.contentLabelF;
    
    // 8.配图
    if(status.thumbnail_pic)
    {
        self.photoView.hidden = NO;
        self.photoView.frame = self.statusFrame.photoViewF;
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:status.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
    }
    else
    {
        self.photoView.hidden = YES;
    }
}

// 被转发微博
- (void)setupRetweetData
{
    IWStatus *retweetStatus = self.statusFrame.status.retweeted_status;
    IWUser *retweetUser = retweetStatus.user;
    
    if(retweetStatus){
        self.retweetView.hidden = NO;
        
        // 1.父控件
        self.retweetView.frame = self.statusFrame.retweetViewF;
        
        // 2.昵称
        self.retweetNameLabel.text = [NSString stringWithFormat:@"@%@",retweetUser.name];
        self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelF;
        
        // 3.正文
        self.retweetContentLabel.text = retweetStatus.text;
        self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelF;
        
        // 4.配图
        if(retweetStatus.thumbnail_pic)
        {
            self.retweetPhotoView.hidden = NO;
            self.retweetPhotoView.frame = self.statusFrame.retweetPhotoViewF;
            [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:retweetStatus.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
        }
        else
        {
            self.retweetPhotoView.hidden = YES;
        }
    }
    else
    {
        self.retweetView.hidden = YES;
    }

}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    IWStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil)
    {
        cell = [[IWStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

@end
