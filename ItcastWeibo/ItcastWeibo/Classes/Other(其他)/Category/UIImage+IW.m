//
//  UIImage+IW.m
//  ItcastWeibo
//
//  Created by kun on 15/1/17.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "UIImage+IW.h"

@implementation UIImage (IW)

+ (UIImage *)imageWithName:(NSString *)name
{
    if(iOS7)
    {
        NSString *newName = [name stringByAppendingString:@"_os7"];
        UIImage *image = [UIImage imageNamed:newName];
        if(image == nil)
        {
            image = [UIImage imageNamed:name];
        }
        return image;
    }
    
    return [self imageNamed:name];
}


+ (UIImage *)resizedImageWithName:(NSString *)name
{
    return [self resizedImageWithName:name left:0.5 top:0.5];
}

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [self imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

@end
