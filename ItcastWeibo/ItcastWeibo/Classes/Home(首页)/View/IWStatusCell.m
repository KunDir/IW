//
//  IWStatusCell.m
//  ItcastWeibo
//
//  Created by kun on 15/1/21.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "IWStatusCell.h"

#import "IWStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "IWStatusToolbar.h"
#import "IWStatusTopView.h"

@interface IWStatusCell ()

// 顶部的view
@property (nonatomic, weak) IWStatusTopView *topView;

// 微博的工具条
@property (nonatomic, weak) IWStatusToolbar *statusToolbar;
@end

@implementation IWStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        // 1.添加原创微博内部的子控件
        [self setupOriginalSubviews];
        
        // 2.添加被转发微博内部的子控件
//        [self setupRetweetSubviews];
        
        // 3.添加微博的工具条
        [self setupStatusToolBar];
        
    }
    return self;
}

// 添加原创微博内部的子控件
- (void)setupOriginalSubviews
{
    // 0.设置cell选中时的背景
    self.selectedBackgroundView = [[UIView alloc] init];
    
    // 1.顶部的view
    IWStatusTopView *topView = [[IWStatusTopView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
}

//// 添加被转发微博内部的子控件
//- (void)setupRetweetSubviews
//{
//    // 1.被转发微博的View（父控件）
//    IWRetweetStatusView *retweetView = [[IWRetweetStatusView alloc] init];
//    [self.topView addSubview:retweetView];
//    self.retweetView = retweetView;
//}

// 添加微博的工具条
- (void)setupStatusToolBar
{
    // 1.微博的工具条
    IWStatusToolbar *statusToolbar = [[IWStatusToolbar alloc] init];
    [self.contentView addSubview:statusToolbar];
    self.statusToolbar = statusToolbar;
}

// 拦截frame设置
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = IWStatusTableBorder;
    frame.origin.y += IWStatusTableBorder;
    frame.size.width -= 2 * IWStatusTableBorder;
    frame.size.height -= IWStatusTableBorder;
    [super setFrame:frame];
}

// 设置传递过来的模型数据
- (void)setStatusFrame:(IWStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 1.原创微博
    [self setupOriginalData];
    
    // 2.被转发微博
//    [self setupRetweetData];
    
    // 3.微博工具条
    [self setupStatusToolbar];
}

// 微博工具条
- (void)setupStatusToolbar
{
    self.statusToolbar.frame = self.statusFrame.statusToolbarF;
    self.statusToolbar.status = self.statusFrame.status;
}

// 原创微博
- (void)setupOriginalData
{
    // 1.topView;
    self.topView.frame = self.statusFrame.topViewF;
    
    self.topView.statusFrame = self.statusFrame;
}

//// 被转发微博
//- (void)setupRetweetData
//{
//    IWStatus *retweetStatus = self.statusFrame.status.retweeted_status;
//    
//    if(retweetStatus){
//        self.retweetView.hidden = NO;
//        // 1.父控件
//        self.retweetView.frame = self.statusFrame.retweetViewF;
//        
//        // 2.传递模型数据
//        self.retweetView.statusFrame = self.statusFrame;
//    }
//    else
//    {
//        self.retweetView.hidden = YES;
//    }
//
//}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    IWStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil)
    {
        cell = [[IWStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

@end
