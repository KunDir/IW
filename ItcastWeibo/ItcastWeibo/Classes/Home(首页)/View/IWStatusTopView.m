//
//  IWStatusTopView.m
//  ItcastWeibo
//
//  Created by kun on 15/1/23.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "IWStatusTopView.h"
#import "IWStatusFrame.h"
#import "IWUser.h"
#import "IWStatus.h"
#import "UIImageView+WebCache.h"
#import "IWRetweetStatusView.h"
#import "IWPhoto.h"
#import "IWPhotosView.h"

@interface IWStatusTopView ()
// 头像
@property (nonatomic, weak) UIImageView *iconView;
// 会员图标
@property (nonatomic, weak) UIImageView *vipView;
// 配图
@property (nonatomic, weak) IWPhotosView *photosView;
// 昵称
@property (nonatomic, weak) UILabel *nameLabel;
// 时间
@property (nonatomic, weak) UILabel *timeLabel;
// 来源
@property (nonatomic, weak) UILabel *sourceLabel;
// 正文\内容
@property (nonatomic, weak) UILabel *contentLabel;

// 被转发微博的View（父控件）
@property (nonatomic, weak) IWRetweetStatusView *retweetView;
@end

@implementation IWStatusTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.userInteractionEnabled = YES;
        
        self.image = [UIImage resizedImageWithName:@"timeline_card_top_background"];
        self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_top_background_highlighted"];
        
        // 2.头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        // 3.会员图标
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView = vipView;
        
        // 4.配图
        IWPhotosView *photosView = [[IWPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
        
        // 5.昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = IWStatusNameFont;
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 6.时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = IWStatusTimeFont;
        timeLabel.textColor = IWColor(235, 105, 26);
        timeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        // 7.来源
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.font = IWStatusSourceFont;
        sourceLabel.textColor = IWColor(135, 135, 135);
        sourceLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        // 8.正文\内容
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.numberOfLines = 0;
        contentLabel.font = IWStatusContentFont;
        contentLabel.textColor = IWColor(39, 39, 39);
        contentLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        // 9.被转发的微博
        IWRetweetStatusView *retweetView = [[IWRetweetStatusView alloc] init];
        [self addSubview:retweetView];
        self.retweetView = retweetView;
    }
    return self;
}

- (void)setStatusFrame:(IWStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    IWStatus *status = statusFrame.status;
    IWUser *user = statusFrame.status.user;
    
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
    if(status.pic_urls.count)
    {
        self.photosView.hidden = NO;
        self.photosView.frame = self.statusFrame.photoViewF;
        self.photosView.photos = status.pic_urls;
    }
    else
    {
        self.photosView.hidden = YES;
    }
    
    // 9.被转发微博
    IWStatus *retweetStatus = status.retweeted_status;

    if(retweetStatus){
        self.retweetView.hidden = NO;
        // 1.父控件
        self.retweetView.frame = self.statusFrame.retweetViewF;

        // 2.传递模型数据
        self.retweetView.statusFrame = self.statusFrame;
    }
    else
    {
        self.retweetView.hidden = YES;
    }
}
@end
