//
//  IWNewfeatureContrller.m
//  ItcastWeibo
//
//  Created by kun on 15/1/19.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#define IWNewfeatureImageCount 3
#import "IWNewfeatureContrller.h"

#import "IWTabBarViewController.h"

@interface IWNewfeatureContrller () <UIScrollViewDelegate>

@property (nonatomic,weak) UIPageControl *pageControl;
@end

@implementation IWNewfeatureContrller

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加UIScrollView
    [self setupScrollView];
    
    // 添加pageControl
    [self setupPageControl];
    
}

- (void)setupScrollView
{
    // 添加一个背景
    UIImageView *bg = [[UIImageView alloc] init];
    bg.image = [UIImage imageWithName:@"new_feature_background"];
    bg.frame = self.view.bounds;
    [self.view addSubview:bg];
    
    // 1.添加UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    CGFloat scrollW = scrollView.frame.size.width;
    CGFloat scrollH = scrollView.frame.size.height;
    
    scrollView.delegate = self;
    // 添加图片
    for(int index = 0; index < IWNewfeatureImageCount; index++)
    {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        // 设置图片
        NSString *name = [NSString stringWithFormat:@"new_feature_%d", index + 1];
        imageView.image = [UIImage imageWithName:name];
        // 设置尺寸
        CGFloat imageX = index * scrollW;
        imageView.frame = CGRectMake(imageX, 0, scrollW, scrollH);
        [scrollView addSubview:imageView];
        
        // 在最后一个图片上面添加按钮
        if( index == IWNewfeatureImageCount - 1)
        {
            [self setupLastImageView:imageView];
        }
    }
    
    // 设置滚动的内容尺寸
    scrollView.contentSize = CGSizeMake(scrollW * IWNewfeatureImageCount, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    // 弹簧效果
    //    scrollView.bounces = NO;
    
    [self.view addSubview:scrollView];
}

// 添加内容到最后一张图片
- (void)setupLastImageView:(UIImageView *)imageView
{
    // 让imageView能够与用户交互
    imageView.userInteractionEnabled = YES;
    // 1.添加开始按钮
    UIButton *startButton = [[UIButton alloc] init];
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    // 2.设置frame
    CGFloat centerX = imageView.frame.size.width * 0.5;
    CGFloat centerY = imageView.frame.size.height * 0.6;
    startButton.center = CGPointMake(centerX, centerY);
    startButton.bounds = (CGRect){CGPointZero, startButton.currentBackgroundImage.size};
    // 设置文字
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
    
    // 添加checkBox
    UIButton *checkbox = [[UIButton alloc] init];
    checkbox.selected = YES;
    [checkbox setTitle:@"分享给大家" forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageWithName:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageWithName:@"new_feature_share_true"] forState:UIControlStateSelected];
    checkbox.bounds = startButton.bounds;
    CGFloat checkboxCenterX = centerX;
    CGFloat checkboxCenterY = imageView.frame.size.height * 0.5;
    checkbox.center = CGPointMake(checkboxCenterX, checkboxCenterY);
    [checkbox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkbox.titleLabel.font = [UIFont systemFontOfSize:15];
    [checkbox addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
    
//    checkbox.contentEdgeInsets;
    checkbox.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0);
//    checkbox.imageEdgeInsets;
    
    [imageView addSubview:checkbox];
}

// 开始微博
- (void)start
{
    // Show statusBar
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    IWTabBarViewController *tabbar = [[IWTabBarViewController alloc] init];
    
    // 切换窗口跟控制器 -- 新特性控制器销毁
    self.view.window.rootViewController = tabbar;
}

- (void)checkboxClick:(UIButton *)checkbox
{
    checkbox.selected = !checkbox.selected;
}

- (void)setupPageControl
{
    // 添加
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = IWNewfeatureImageCount;
    CGFloat centerX = self.view.frame.size.width * 0.5;
    CGFloat centerY = self.view.frame.size.height - 30;
    pageControl.center = CGPointMake(centerX, centerY);
    pageControl.bounds = CGRectMake(0, 0, 100, 30);
    pageControl.userInteractionEnabled = NO;
    
    // 设置圆点的颜色
//    pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"new_feature_pagecontrol_checked_point"]];
//    pageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"new_feature_pagecontrol_point"]];
    pageControl.currentPageIndicatorTintColor = IWColor(253, 98, 42);
    
    pageControl.pageIndicatorTintColor = IWColor(189, 189, 189);
    
    [self.view addSubview:pageControl];
    
    self.pageControl = pageControl;
}

// 只要ScrollView滚动就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 求出页码，四舍五入
    double pageDouble = offsetX / scrollView.frame.size.width;
    int pageInt = (int)(pageDouble + 0.5) * 100 / 100.0;
    
//    NSLog(@"%f---%d", pageDouble, pageInt);
    
    self.pageControl.currentPage = pageInt;
}

@end
