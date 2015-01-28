//
//  IWWeiboTool.m
//  ItcastWeibo
//
//  Created by kun on 15/1/20.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "IWWeiboTool.h"
#import "IWTabBarViewController.h"
#import "IWNewfeatureContrller.h"

@implementation IWWeiboTool

+ (void)chooseRootController
{
    NSString *key = @"CFBundleVersion";
    
    // 取出沙盒中存储的上次使用软件的本版号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];
    
    // 获取当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    // 判断版本号是否相等
    if(![currentVersion isEqualToString:lastVersion]){
        // 有新版本
        [UIApplication sharedApplication].keyWindow.rootViewController = [[IWNewfeatureContrller alloc] init];
        
        // 存储新版本
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }
    else
    {
        // Show statusBar
        [UIApplication sharedApplication].statusBarHidden = NO;
        
        [UIApplication sharedApplication].keyWindow.rootViewController = [[IWTabBarViewController alloc] init];
    }
}
@end
