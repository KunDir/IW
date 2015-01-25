//
//  IWTabBar.h
//  ItcastWeibo
//
//  Created by kun on 15/1/17.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IWTabBar;

@protocol IWTabBarDelegate <NSObject>

@optional
- (void)tabBar:(IWTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;

- (void)tabBarDidClickedPlusButton:(IWTabBar *)tabBar;

@end

@interface IWTabBar : UIView

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@property (nonatomic, weak) id<IWTabBarDelegate> delegate;

@end
