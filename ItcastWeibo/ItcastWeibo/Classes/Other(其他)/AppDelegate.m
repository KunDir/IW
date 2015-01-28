//
//  AppDelegate.m
//  ItcastWeibo
//
//  Created by kun on 15/1/16.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "AppDelegate.h"

#import "IWOAuthViewController.h"

#import "IWAccount.h"

#import "IWWeiboTool.h"

#import "IWAccountTool.h"

#import "SDWebImageManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    // 1.先判断有无存储账号信息
    IWAccount *account = [IWAccountTool account];
    
    if(account) // 登录成功
    {
        [IWWeiboTool chooseRootController];
    }
    else // 之前没有登录成功
    {
        self.window.rootViewController = [[IWOAuthViewController alloc] init];
    }
    return YES;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 停止下载图片
    [[SDWebImageManager sharedManager] cancelAll];
    // 清除内存中的图片
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

// app进入后台会调用这个方法
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // 在后台开启任务让程序将持续保持运行状态（能保持运行的时间是不确定）
    [application beginBackgroundTaskWithExpirationHandler:^{
        
    }];
    
    // 定时提醒 （定时弹框）
//    [UILocalNotification]
}

/** 让程序保持后台运行
*   1.尽量申请
*
*/
@end
