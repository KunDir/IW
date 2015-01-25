//
//  IWTitleButton.m
//  ItcastWeibo
//
//  Created by kun on 15/1/19.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#define IWTitleButtonImageW 20

#import "IWTitleButton.h"

@implementation IWTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        // 高亮时不要自动调整图标
        self.adjustsImageWhenHighlighted = NO;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        
        // 背景
        [self setBackgroundImage:[UIImage resizedImageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
        
        self.imageView.contentMode = UIViewContentModeCenter;
        
        self.titleLabel.textAlignment = NSTextAlignmentRight;
    }
    return self;
}

+ (instancetype)titleButton
{
    return [[self alloc] init];
}

#pragma mark - 重写方法
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageW = IWTitleButtonImageW;
    CGFloat imageX = contentRect.size.width - imageW;
    CGFloat imageH = contentRect.size.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
};

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = 0;
    CGFloat titleW = contentRect.size.width - IWTitleButtonImageW;
    CGFloat titleX = 0;
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
};

/**
 *  重写setTitle方法
 *
 *  @param title
 *  @param state
 */
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    // 根据title计算自己的宽度
    NSMutableDictionary *attriDict = [NSMutableDictionary dictionary];
    attriDict[NSFontAttributeName] = self.titleLabel.font;
    CGFloat titleW = [title sizeWithAttributes:attriDict].width;
    CGRect frame = self.frame;
    frame.size.width = titleW + IWTitleButtonImageW + 3;
    self.frame = frame;
    
    [super setTitle:title forState:state];
}
@end
