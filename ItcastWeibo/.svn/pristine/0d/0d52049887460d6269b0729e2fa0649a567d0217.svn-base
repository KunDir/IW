//
//  UIBarButtonItem+IW.m
//  ItcastWeibo
//
//  Created by kun on 15/1/18.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "UIBarButtonItem+IW.h"

@implementation UIBarButtonItem (IW)
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    //    leftBtn.bounds = CGRectMake(0, 0, leftBtn.currentBackgroundImage.size.width, leftBtn.currentBackgroundImage.size.height);
    button.bounds = (CGRect){CGPointZero, button.currentBackgroundImage.size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
