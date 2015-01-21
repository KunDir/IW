//
//  IWSearchBar.m
//  ItcastWeibo
//
//  Created by kun on 15/1/18.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "IWSearchBar.h"

@interface IWSearchBar()

@property (nonatomic, weak) UIImageView *iconView;
@end

@implementation IWSearchBar

+ (instancetype)searchBar
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        // 背景
        self.background = [UIImage resizedImageWithName:@"searchbar_textfield_background"];
        // 左边的放大镜图标
        UIImageView *iconView =[[UIImageView alloc] initWithImage:[UIImage imageWithName:@"searchbar_textfield_search_icon"]];
        iconView.frame = CGRectMake(0, 0, 30, 30);
        iconView.contentMode = UIViewContentModeCenter;
        self.leftView = iconView;
        self.leftViewMode = UITextFieldViewModeAlways;
//        self.iconView = iconView;
        // 字体
        self.font = [UIFont systemFontOfSize:13];
        // 右边的清除按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
        // 设置提醒文字
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索" attributes:attrs];
        
        // 设置键盘右下角返回按钮的样式
        
        self.returnKeyType = UIReturnKeySearch;
        
        self.enablesReturnKeyAutomatically = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.leftView.frame = CGRectMake(0, 0, 30, self.frame.size.height);
}
@end
