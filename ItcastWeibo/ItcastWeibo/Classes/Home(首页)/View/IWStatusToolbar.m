//
//  IWStatusToolbar.m
//  ItcastWeibo
//
//  Created by kun on 15/1/23.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "IWStatusToolbar.h"

@interface IWStatusToolbar ()

@property (nonatomic, strong) NSMutableArray *btns;

@property (nonatomic, strong) NSMutableArray *dividers;
@end

@implementation IWStatusToolbar

- (NSMutableArray *)btns
{
    if(_btns == nil)
    {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)dividers
{
    if(_dividers == nil)
    {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.userInteractionEnabled = YES;
        
        // 1.设置图片
        self.image = [UIImage resizedImageWithName:@"timeline_card_bottom_background"];
        self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_bottom_background_highlighted"];
        
        // 2.添加按钮
        [self setupBtnWithTitle:@"转发" image:@"timeline_icon_retweet" bgImage:@"timeline_card_background_highlighted"];
        
        [self setupBtnWithTitle:@"评论" image:@"timeline_icon_comment" bgImage:@"timeline_card_background_highlighted"];
        
        [self setupBtnWithTitle:@"赞" image:@"timeline_icon_unlike" bgImage:@"timeline_card_background_highlighted"];
        
        // 3.添加分割线
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}

// 初始化分割线
- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageWithName:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    
    // 添加分割线到数组
    [self.dividers addObject:divider];
}

// 初始化按钮
- (void)setupBtnWithTitle:(NSString *)title image:(NSString *)image bgImage:(NSString *)bgImage
{
    UIButton *retweetBtn = [[UIButton alloc] init];
    [retweetBtn setImage:[UIImage imageWithName:image] forState:UIControlStateNormal];
    [retweetBtn setTitle:title forState:UIControlStateNormal];
    [retweetBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    retweetBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    retweetBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    retweetBtn.adjustsImageWhenHighlighted = NO;
    [retweetBtn setBackgroundImage:[UIImage resizedImageWithName:bgImage] forState:UIControlStateHighlighted];
    [self addSubview:retweetBtn];
    
    // 添加按钮到数组
    [self.btns addObject:retweetBtn];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置按钮的frame
    int btnCount = self.btns.count;
    CGFloat btnW = self.frame.size.width / btnCount;
    CGFloat btnH = self.frame.size.height;
    CGFloat btnY = 0;
    
    for(int index = 0; index < btnCount; index++)
    {
        UIButton *btn = self.btns[index];
        
        // 设置frame
        CGFloat btnX = index * btnW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    // 2.设置分割线的frame
    int dividerCount = self.dividers.count;
    CGFloat dividerH = btnH;
    CGFloat dividerW = 2;
    CGFloat dividerY = 0;
    for(int index = 0 ;index < dividerCount; index++)
    {
        UIImageView *divider = self.dividers[index];
        
        // 设置frame
        CGFloat dividerX = (index + 1) * btnW;
        divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
    }
}
@end
