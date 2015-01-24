//
//  IWPhotoView.m
//  ItcastWeibo
//
//  Created by kun on 15/1/24.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "IWPhotoView.h"

#import "IWPhoto.h"
#import "UIImageView+WebCache.h"

@interface IWPhotoView ()
@property (nonatomic, strong) UIImageView *gifView;

@end

@implementation IWPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        // 田间一个GIF小图片
        UIImage *image = [UIImage imageWithName:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return self;
}

- (void)setPhoto:(IWPhoto *)photo
{
    _photo = photo;
    
    // 控制gifView的可见性
    self.gifView.hidden = ![photo.thumbnail_pic hasSuffix:@"gif"];
    
    // 下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.layer.anchorPoint = CGPointMake(1, 1);
    self.gifView.layer.position = CGPointMake(self.frame.size.width, self.frame.size.height);
}
@end
