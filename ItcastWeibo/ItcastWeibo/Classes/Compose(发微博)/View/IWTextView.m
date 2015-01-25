//
//  IWTextView.m
//  ItcastWeibo
//
//  Created by kun on 15/1/25.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "IWTextView.h"
@interface IWTextView ()

@property (nonatomic, weak) UILabel *placeholderLabel;
@end

@implementation IWTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        UILabel *placeholderLabel = [[UILabel alloc] init];
//        placeholderLabel.font = [UIFont systemFontOfSize:15];
        placeholderLabel.textColor = [UIColor lightGrayColor];
        placeholderLabel.hidden = YES;
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.backgroundColor = [UIColor clearColor];
        [self insertSubview:placeholderLabel atIndex:0];
        self.placeholderLabel = placeholderLabel;
        
        // 监听文字改变通知
        [IWNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)textDidChange
{
    self.placeholderLabel.hidden = (self.text.length != 0);
}

- (void)dealloc
{
    [IWNotificationCenter removeObserver:self];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    self.placeholderLabel.text = placeholder;
    if(placeholder.length)
    {
        self.placeholderLabel.hidden = NO;
        
        // 计算frame
        CGFloat placeholderX = 5;
        CGFloat placeholderY = 7;
        CGFloat maxH = self.frame.size.height - 2 * placeholderY;
        CGFloat maxW = self.frame.size.width - 2 * placeholderX;
        NSMutableDictionary *placeholderAttrs = [NSMutableDictionary dictionary];
        placeholderAttrs[NSFontAttributeName] = self.placeholderLabel.font;
        CGSize placeholderSize = [placeholder boundingRectWithSize:CGSizeMake(maxW, maxH) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine  attributes:placeholderAttrs context:nil].size;        self.placeholderLabel.frame = CGRectMake(placeholderX, placeholderY, placeholderSize.width, placeholderSize.height);
    }
    else
    {
        self.placeholderLabel.hidden = YES;
    }
//    self.placeholderLabel.hidden = (placeholder.length == 0);
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    
    self.placeholder = self.placeholder;
}



@end
