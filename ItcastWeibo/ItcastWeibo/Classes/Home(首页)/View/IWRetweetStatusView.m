//
//  IWRetweetStatusView.m
//  ItcastWeibo
//
//  Created by kun on 15/1/23.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "IWRetweetStatusView.h"
#import "IWStatusFrame.h"
#import "IWStatus.h"
#import "IWUser.h"
#import "UIImageView+WebCache.h"

@interface IWRetweetStatusView ()
// 被转发微博作者的昵称
@property (nonatomic, weak) UILabel *retweetNameLabel;
// 被转发微博的正文\内容
@property (nonatomic, weak) UILabel *retweetContentLabel;
// 被转发微博的配图
@property (nonatomic, weak) UIImageView *retweetPhotoView;
@end

@implementation IWRetweetStatusView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        
        self.image = [UIImage resizedImageWithName:@"oldtimeline_retweet_background" left:0.9 top:0.5];
        
        // 2.被转发微博作者的昵称
        UILabel *retweetNameLabel = [[UILabel alloc] init];
        retweetNameLabel.font = IWRetweetStatusNameFont;
        retweetNameLabel.backgroundColor = [UIColor clearColor];
        retweetNameLabel.textColor = IWColor(21, 88, 180);
        [self addSubview:retweetNameLabel];
        self.retweetNameLabel = retweetNameLabel;
        
        // 3.被转发微博的正文\内容
        UILabel *retweetContentLabel = [[UILabel alloc] init];
        retweetContentLabel.font = IWRetweetStatusContentFont;
        retweetContentLabel.numberOfLines = 0;
        retweetContentLabel.backgroundColor = [UIColor clearColor];
        retweetContentLabel.textColor = IWColor(90, 90, 90);
        [self addSubview:retweetContentLabel];
        self.retweetContentLabel = retweetContentLabel;
        
        // 4.被转发微博的配图
        UIImageView *retweetPhotoView = [[UIImageView alloc] init];
        [self addSubview:retweetPhotoView];
        self.retweetPhotoView = retweetPhotoView;
    }
    return self;
}

- (void)setStatusFrame:(IWStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    IWStatus *retweetStatus = statusFrame.status.retweeted_status;
    IWUser *retweetUser = retweetStatus.user;
    
    // 1.昵称
    self.retweetNameLabel.text = [NSString stringWithFormat:@"@%@",retweetUser.name];
    self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelF;
    
    // 2.正文
    self.retweetContentLabel.text = retweetStatus.text;
    self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelF;
    
    // 3.配图
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

@end
