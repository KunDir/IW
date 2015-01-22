//
//  UIImage+IW.h
//  ItcastWeibo
//
//  Created by kun on 15/1/17.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (IW)

+ (UIImage *)imageWithName:(NSString *)name;
/**
 *  返回一张拉伸的图片
 *
 *  @param name <#name description#>
 *
 *  @return <#return value description#>
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

@end
