//
//  IWTabBarViewController.m
//  ItcastWeibo
//
//  Created by kun on 15/1/16.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "IWTabBarViewController.h"

#import "IWHomeViewController.h"
#import "IWMessageViewController.h"
#import "IWMeViewController.h"
#import "IWDiscoverViewController.h"

#import "IWTabBar.h"

#import "IWNavigationController.h"

#import "IWComposeViewController.h"
#import "IWAccountTool.h"
#import "IWAccount.h"
#import "IWUserTool.h"

@interface IWTabBarViewController () <IWTabBarDelegate>

@property (nonatomic, weak) IWTabBar *custemTabBar;

@property (nonatomic, strong) IWHomeViewController *home;

@property (nonatomic, strong) IWMessageViewController *message;

@property (nonatomic, strong) IWDiscoverViewController *discover;

@property (nonatomic, strong) IWMeViewController *me;

@end

@implementation IWTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupTabBar];
    
    // 初始化所有的子控制器
    [self setupAllChildViewControllers];
    
    // 定时检查未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(checkUnreadCount) userInfo:nil repeats:YES];
    // 把计时器放在子线程
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

/**
 *  定时检查未读数
 */
- (void)checkUnreadCount
{
    // 1.请求参数
    IWUserUnreadCountParam *param = [[IWUserUnreadCountParam alloc] init];
    param.uid = @([IWAccountTool account].uid);
    
    // 2.发送请求
    [IWUserTool userUnreadCountWithParam:param success:^(IWUserUnreadCountResult *result) {
        // 3.设置badgeValue
        self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        
        self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.messageCount];
        
        self.me.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.follower];
        
        // 设置图标右上角的数字(之前必须得获得用户的同意才能修改图标右上角的数字）
//        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
//        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.count;
    } failure:^(NSError *error) {
        
    }];
}

// 初始化tabbar
- (void)setupTabBar
{
    IWTabBar *custemTabBar = [[IWTabBar alloc] init];
    custemTabBar.frame = self.tabBar.bounds;
    custemTabBar.delegate = self;
    [self.tabBar addSubview:custemTabBar];
    
    self.custemTabBar = custemTabBar;
}


/** 监听tabbar按钮的状态
 *  @param from     原来选中的位置
 *  @param to       新选中的位置
 */
- (void)tabBar:(IWTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to
{
    self.selectedIndex = to;
    
    if( to == 0 )
    {
        [self.home refresh];
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    // 删除系统自带的UITabBarButton
    for(UIView *child in self.tabBar.subviews)
    {
        if([child isKindOfClass:[UIControl class]])
        {
            [child removeFromSuperview];
        }
    }
    
}

- (void)setupAllChildViewControllers
{
    // 1.home
    IWHomeViewController *home = [[IWHomeViewController alloc] init];
//    home.tabBarItem.badgeValue = @"1";
    [self setupChildViewController:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    self.home = home;
    
    // 2.message
    IWMessageViewController *message = [[IWMessageViewController alloc] init];
//    message.tabBarItem.badgeValue = @"20";
    [self setupChildViewController:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    self.message = message;
    
    // 3.discover
    IWDiscoverViewController *discover = [[IWDiscoverViewController alloc] init];
//    discover.tabBarItem.badgeValue = @"333";
    [self setupChildViewController:discover title:@"广场" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    self.discover = discover;
    
    // 4.me
    IWMeViewController *me = [[IWMeViewController alloc] init];
//    me.tabBarItem.badgeValue = @"9999";
    [self setupChildViewController:me title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    self.me = me;
}

/**
 *  初始化子控制器
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 设置控制器的属性
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    
    UIImage *selectedImage = [UIImage imageWithName:selectedImageName];
    
    if(iOS7){
        childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    else
    {
        childVc.tabBarItem.selectedImage = selectedImage;
    }
    
    // 包装一个导航控制器
    IWNavigationController *nav = [[IWNavigationController alloc] initWithRootViewController:childVc];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    // 添加自定义tabbar内部的按钮
    [self.custemTabBar addTabBarButtonWithItem:childVc.tabBarItem];
}

- (void)tabBarDidClickedPlusButton:(IWTabBar *)tabBar
{
    IWComposeViewController *compose = [[IWComposeViewController alloc] init];
    IWNavigationController *nav = [[IWNavigationController alloc] initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
}


@end
