//
//  IWComposePhotosView.m
//  ItcastWeibo
//
//  Created by kun on 15/1/27.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "IWComposePhotosView.h"

@implementation IWComposePhotosView

- (void)addImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    [self addSubview:imageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    int count = self.subviews.count;
    int maxColumns = 4;
    CGFloat imageH = 70;
    CGFloat imageW = imageH;
    CGFloat margin = (self.frame.size.width - maxColumns * imageW) / (maxColumns + 1);
    for(int index = 0; index < count; index++)
    {
        UIImageView *imageView = self.subviews[index];
        CGFloat imageX = margin + (index % maxColumns) * (margin + imageW);
        CGFloat imageY = (index / maxColumns) * (margin + imageH);
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    }
}

- (NSArray *)images
{
    NSMutableArray *images = [NSMutableArray array];
    
    int count = self.subviews.count;
    
    for(int index = 0; index < count; index++)
    {
        UIImageView *imageView = self.subviews[index];
        [images addObject:imageView.image];
    }
    return images;
}
@end
