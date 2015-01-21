//
//  IWStatusFrame.m
//  ItcastWeibo
//
//  Created by kun on 15/1/21.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "IWStatusFrame.h"

#import "IWStatus.h"
#import "IWUser.h"

// cell的边框宽度
#define IWStatusCellBorder 5




@implementation IWStatusFrame

// 获得微博模型数据之后，根据微博数据计算所有子控件的frame
- (void)setStatus:(IWStatus *)status
{
    _status = status;
    
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    // 1.topView
    CGFloat topViewW = cellW;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    
    // 2.头像
    CGFloat iconViewWH = 35;
    CGFloat iconViewX = IWStatusCellBorder;
    CGFloat iconViewY = IWStatusCellBorder;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    // 3.昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + IWStatusCellBorder;
    CGFloat nameLabelY = iconViewY;
    NSMutableDictionary *nameAttrs = [NSMutableDictionary dictionary];
    nameAttrs[NSFontAttributeName] = IWStatusNameFont;
    CGSize nameLabelSize = [status.user.name sizeWithAttributes:nameAttrs];
    _nameLabelF = (CGRect){{nameLabelX, nameLabelY}, nameLabelSize};
    
    // 4.会员图标
    if(status.user.vip)
    {
        CGFloat vipViewW = 14;
        CGFloat vipViewH = nameLabelSize.height;
        CGFloat vipViewX = CGRectGetMaxX(_nameLabelF) + IWStatusCellBorder;
        CGFloat vipViewY = nameLabelY;
        _vipViewF = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    }
    
    // 5.时间
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_nameLabelF) + IWStatusCellBorder;
    NSMutableDictionary *timeAttrs = [NSMutableDictionary dictionary];
    timeAttrs[NSFontAttributeName] = IWStatusTimeFont;
    CGSize timeLabelSize = [status.created_at sizeWithAttributes:timeAttrs];
    _timeLabelF = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
    // 6.来源
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLabelF) + IWStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    NSMutableDictionary *sourceAttrs = [NSMutableDictionary dictionary];
    sourceAttrs[NSFontAttributeName] = IWStatusSourceFont;
    CGSize sourceLabelSize = [status.source sizeWithAttributes:sourceAttrs];
    _sourceLabelF = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};
    
    // 7.微博正文内容
    CGFloat contentLabelX = iconViewX;
    CGFloat contentLabelY = MAX(CGRectGetMaxY(_iconViewF), CGRectGetMaxY(_timeLabelF)) + IWStatusCellBorder;
    NSMutableDictionary *contentAttrs = [NSMutableDictionary dictionary];
    contentAttrs[NSFontAttributeName] = IWStatusContentFont;
    CGFloat contentLabelMaxW = topViewW - IWStatusCellBorder * 2;
//    CGSize contentLabelSize = [status.text sizeWithAttributes:contentAttrs constrainedToSize:CGSizeMake(contentLabelMaxW, MAXFLOAT)];
    CGSize contentLabelSize = [status.text boundingRectWithSize:CGSizeMake(contentLabelMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:contentAttrs context:nil].size;
    _contentLabelF = (CGRect){{contentLabelX, contentLabelY}, contentLabelSize};
    
    // 计算topView的高度
    CGFloat topViewH = CGRectGetMaxY(_contentLabelF) + IWStatusCellBorder;
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    // 计算cell的高度
    _cellHeight = topViewH;
    
    
    
    
    
    
}
@end
