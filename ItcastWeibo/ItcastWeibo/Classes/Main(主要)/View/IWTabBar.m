//
//  IWTabBar.m
//  ItcastWeibo
//
//  Created by kun on 15/1/17.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "IWTabBar.h"
#import "IWTabBarButton.h"

@interface IWTabBar()

@property (nonatomic, weak) IWTabBarButton *selectedButton;

@property (nonatomic, weak) UIButton *plusButton;

@property (nonatomic, strong) NSMutableArray *tabBarButtonArray;

@end

@implementation IWTabBar

- (NSMutableArray *)tabBarButtonArray
{
    if(_tabBarButtonArray == nil)
    {
        _tabBarButtonArray = [NSMutableArray array];
    }
    return _tabBarButtonArray;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        if(!iOS7){
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_background"]];
        }
        
        // 添加中间的加号
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusButton.bounds = CGRectMake(0, 0, plusButton.currentBackgroundImage.size.width, plusButton.currentBackgroundImage.size.height);
        [self addSubview:plusButton];
        self.plusButton = plusButton;
    }
    
    return self;
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    // 1.创建按钮
    IWTabBarButton *button = [[IWTabBarButton alloc] init];
    
    // 2.设置数据
    button.item = item;
    
    
    // 添加按钮到数组
    [self.tabBarButtonArray addObject:button];
    
    // 3.监听按钮点击
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:button];
    
    // 4.默认选中第0个按钮
    if(self.tabBarButtonArray.count == 1)
    {
        [self buttonClick:button];
    }
}

// 监听按钮点击
- (void)buttonClick:(IWTabBarButton *)button
{
    // 1.通知代理
    if([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)])
    {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedButton.tag to:button.tag];
    }
    
    // 2.设置按钮的状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat W = self.frame.size.width;
    CGFloat H = self.frame.size.height;
    self.plusButton.center = CGPointMake(W * 0.5, H * 0.5);
    
    CGFloat buttonY = 0.0f;
    CGFloat buttonW = W / self.subviews.count;
    CGFloat buttonH = H;
    
    for(int index = 0; index <self.tabBarButtonArray.count; index++)
    {
        // 1.取出按钮
        IWTabBarButton *button = self.tabBarButtonArray[index];
        
        // 2.设置按钮的frame
        CGFloat buttonX = index * buttonW;
        
        if(index > 1)
        {
            buttonX += buttonW;
        }
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 3.绑定tag
        button.tag = index;
        
    }
}

@end
