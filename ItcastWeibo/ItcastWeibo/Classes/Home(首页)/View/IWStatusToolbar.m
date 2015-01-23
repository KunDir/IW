//
//  IWStatusToolbar.m
//  ItcastWeibo
//
//  Created by kun on 15/1/23.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "IWStatusToolbar.h"
#import "IWStatus.h"

@interface IWStatusToolbar ()

@property (nonatomic, strong) NSMutableArray *btns;

@property (nonatomic, strong) NSMutableArray *dividers;

@property (nonatomic, weak) UIButton *retweetBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *attitudeBtn;
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
        self.retweetBtn = [self setupBtnWithTitle:@"转发" image:@"timeline_icon_retweet" bgImage:@"timeline_card_background_highlighted"];
        
        self.commentBtn = [self setupBtnWithTitle:@"评论" image:@"timeline_icon_comment" bgImage:@"timeline_card_background_highlighted"];
        
        self.attitudeBtn = [self setupBtnWithTitle:@"赞" image:@"timeline_icon_unlike" bgImage:@"timeline_card_background_highlighted"];
        
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
- (UIButton *)setupBtnWithTitle:(NSString *)title image:(NSString *)image bgImage:(NSString *)bgImage
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageWithName:image] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    btn.adjustsImageWhenHighlighted = NO;
    [btn setBackgroundImage:[UIImage resizedImageWithName:bgImage] forState:UIControlStateHighlighted];
    [self addSubview:btn];
    
    // 添加按钮到数组
    [self.btns addObject:btn];
    
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置按钮的frame
    int dividerCount = self.dividers.count; // 分割线的个数
    CGFloat dividerW = 2; // 分割线的宽度
    int btnCount = self.btns.count;
    CGFloat btnW = (self.frame.size.width - dividerW * dividerCount) / btnCount;
    CGFloat btnH = self.frame.size.height;
    CGFloat btnY = 0;
    
    for(int index = 0; index < btnCount; index++)
    {
        UIButton *btn = self.btns[index];
        
        // 设置frame
        CGFloat btnX = index * (btnW + dividerW);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    // 2.设置分割线的frame
    CGFloat dividerH = btnH;
    CGFloat dividerY = 0;
    for(int index = 0 ;index < dividerCount; index++)
    {
        UIImageView *divider = self.dividers[index];
        
        // 设置frame
        UIButton *btn = self.btns[index];
        CGFloat dividerX = CGRectGetMaxX(btn.frame);
        divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
    }
}

- (void)setStatus:(IWStatus *)status
{
    _status = status;
    
    // 1.设置转发数
    [self setupBtn:self.retweetBtn originalTitle:@"转发" count:status.reposts_count];
    
    [self setupBtn:self.commentBtn originalTitle:@"评论" count:status.comments_count];
    
    [self setupBtn:self.attitudeBtn originalTitle:@"赞" count:status.attitudes_count];
}

// 设置按钮的显示标题
- (void)setupBtn:(UIButton *)btn originalTitle:(NSString *)originalTitle count:(int)count
{
    if(count)
    {
        NSString *title = nil;
        if(count < 10000){
            title = [NSString stringWithFormat:@"%d", count];
            
        }
        else
        {
            double countDouble = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万", countDouble];
            
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        [btn setTitle:title forState:UIControlStateNormal];
    }
    else
    {
        [btn setTitle:originalTitle forState:UIControlStateNormal];
    }
}
@end
