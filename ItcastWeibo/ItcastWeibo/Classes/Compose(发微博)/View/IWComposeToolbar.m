//
//  IWComposeToolbar.m
//  ItcastWeibo
//
//  Created by kun on 15/1/25.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "IWComposeToolbar.h"

@implementation IWComposeToolbar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        // 1.设置背景
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"compose_toolbar_background"]];
        
        // 2.添加按钮
        [self addButtonWithIcon:@"compose_camerabutton_background" highIcon:@"compose_camerabutton_background_highlighted" tag:IWComposeToolbarButtonTypeCamera];
        [self addButtonWithIcon:@"compose_toolbar_picture" highIcon:@"compose_toolbar_picture_highlighted" tag:IWComposeToolbarButtonTypePicture];
        [self addButtonWithIcon:@"compose_mentionbutton_background" highIcon:@"compose_mentionbutton_background_highlighted" tag:IWComposeToolbarButtonTypeMention];
        [self addButtonWithIcon:@"compose_trendbutton_background" highIcon:@"compose_trendbutton_background_highlighted" tag:IWComposeToolbarButtonTypeTrend];
        [self addButtonWithIcon:@"compose_emoticonbutton_background" highIcon:@"compose_emoticonbutton_background_highlighted" tag:IWComposeToolbarButtonTypeEmotion];
        
    }
    return self;
}

- (void)addButtonWithIcon:(NSString *)icon highIcon:(NSString *)highIcon tag:(int)tag
{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    [self addSubview:button];
}
/**
 *  监听按钮的点击
 *
 *  @param button
 */
- (void)buttonClick:(UIButton *)button
{
    if([self.delegate respondsToSelector:@selector(composeToolbar:didClickButton:)])
    {
        [self.delegate composeToolbar:self didClickButton:button.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonH = self.frame.size.height;
    for(int index = 0; index < self.subviews.count; index++)
    {
        UIButton *button = self.subviews[index];
        CGFloat buttonX = buttonW * index;
        button.frame = CGRectMake(buttonX, 0, buttonW, buttonH);
    }
}

@end
