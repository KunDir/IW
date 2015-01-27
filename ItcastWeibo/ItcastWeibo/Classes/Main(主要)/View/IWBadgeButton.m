//
//  IWBadgeButton.m
//  ItcastWeibo
//
//  Created by kun on 15/1/17.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "IWBadgeButton.h"

@implementation IWBadgeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        [self setBackgroundImage:[UIImage resizedImageWithName:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    
    // 设置提醒数字
    if(badgeValue && [badgeValue intValue] > 0)
    {
        self.hidden = NO;
        
        // 设置文字
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        // 设置frame 自己设置尺寸
        CGRect frame= self.frame;
        
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        if(badgeValue.length > 1){
            CGSize badgeSize = [badgeValue sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.titleLabel.font, NSFontAttributeName, nil]];
            badgeW = badgeSize.width + 10;
        }
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
        
    }
    else
    {
        self.hidden = YES;
    }
    
    
}

@end
