//
//  IWStatusToolbar.m
//  ItcastWeibo
//
//  Created by kun on 15/1/23.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "IWStatusToolbar.h"

@implementation IWStatusToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        // 1.设置图片
        self.image = [UIImage resizedImageWithName:@"timeline_card_bottom_background"];
        self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_bottom_background_highlighted"];
    }
    return self;
}
@end
