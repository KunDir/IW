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

@implementation IWStatusFrame

// 获得微博模型数据之后，根据微博数据计算所有子控件的frame
- (void)setStatus:(IWStatus *)status
{
    _status = status;
    
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - 2 * IWStatusTableBorder;
    
    // 1.topView
    CGFloat topViewW = cellW;
    CGFloat topViewH = 0;
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
    CGFloat contentLabelY = MAX(CGRectGetMaxY(_timeLabelF), CGRectGetMaxY(_iconViewF)) + IWStatusCellBorder;
    NSMutableDictionary *contentAttrs = [NSMutableDictionary dictionary];
    contentAttrs[NSFontAttributeName] = IWStatusContentFont;
    CGFloat contentLabelMaxW = topViewW - IWStatusCellBorder * 2;
    CGSize contentLabelSize = [status.text boundingRectWithSize:CGSizeMake(contentLabelMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine  attributes:contentAttrs context:nil].size;
    _contentLabelF = (CGRect){{contentLabelX, contentLabelY}, contentLabelSize};
    
    // 8.配图
    if(status.thumbnail_pic)
    {
        CGFloat photoViewWH = 70;
        CGFloat photoViewX = contentLabelX;
        CGFloat photoViewY = CGRectGetMaxY(_contentLabelF) + IWStatusCellBorder;
        _photoViewF = CGRectMake(photoViewX, photoViewY, photoViewWH, photoViewWH);
    }
    
    // 9.被转发微博
    if(status.retweeted_status){
        CGFloat retweetViewW = contentLabelMaxW;
        CGFloat retweetViewX = contentLabelX;
        CGFloat retweetViewY = CGRectGetMaxY(_contentLabelF) + IWStatusCellBorder;
        CGFloat retweetViewH = 0;
        
        // 10.被转发微博的昵称
        CGFloat retweetNameLabelX = IWStatusCellBorder;
        CGFloat retweetNameLabelY = IWStatusCellBorder;
        NSMutableDictionary *retweetNameAttrs = [NSMutableDictionary dictionary];
        retweetNameAttrs[NSFontAttributeName] = IWRetweetStatusNameFont;
        NSString *name = [NSString stringWithFormat:@"@%@", status.retweeted_status.user.name];
        CGSize retweetNameLabelSize = [name sizeWithAttributes:retweetNameAttrs];
        _retweetNameLabelF = (CGRect){{retweetNameLabelX, retweetNameLabelY}, retweetNameLabelSize};
        
        // 11.被转发微博的正文
        CGFloat retweetContentLabelX = retweetNameLabelX;
        CGFloat retweetContentLabelY = CGRectGetMaxY(_retweetNameLabelF) + IWStatusCellBorder;
        NSMutableDictionary *retweetContentAttrs = [NSMutableDictionary dictionary];
        retweetContentAttrs[NSFontAttributeName] = IWRetweetStatusContentFont;
        CGFloat retweetContentLabelMaxW = retweetViewW - 2 * IWStatusCellBorder;
        CGSize retweetContentLabelSize = [status.retweeted_status.text boundingRectWithSize:CGSizeMake(retweetContentLabelMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine attributes:retweetContentAttrs context:nil].size;
        _retweetContentLabelF = (CGRect){{retweetContentLabelX, retweetContentLabelY}, retweetContentLabelSize};
        
        // 12.被转发微博的配图
        if(status.retweeted_status.thumbnail_pic)
        {
            CGFloat retweetPhotoViewWH = 70;
            CGFloat retweetPhotoViewX = retweetContentLabelX;
            CGFloat retweetPhotoViewY = CGRectGetMaxY(_retweetContentLabelF) + IWStatusCellBorder;
            _retweetPhotoViewF = CGRectMake(retweetPhotoViewX, retweetPhotoViewY, retweetPhotoViewWH, retweetPhotoViewWH);
            
            retweetViewH = CGRectGetMaxY(_retweetPhotoViewF);
        }
        else
        {
            retweetViewH = CGRectGetMaxY(_retweetContentLabelF);
        }
        retweetViewH += IWStatusCellBorder;
        _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        
        
        topViewH = CGRectGetMaxY(_retweetViewF);
    }
    else // 没有被转发微博
    {
        if(status.thumbnail_pic) // 有配图
        {
            topViewH = CGRectGetMaxY(_photoViewF);
        }
        else // 没有配图
        {
            topViewH = CGRectGetMaxY(_contentLabelF);
        }
    }
    topViewH += IWStatusCellBorder;
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    // 13.工具条
    CGFloat statusToolbarX = topViewX;
    CGFloat statusToolbarY = CGRectGetMaxY(_topViewF);
    CGFloat statusToolbarW = topViewW;
    CGFloat statusToolbarH = 35;
    _statusToolbarF = CGRectMake(statusToolbarX, statusToolbarY, statusToolbarW, statusToolbarH);
    
    // 14.cell的高度
    _cellHeight = CGRectGetMaxY(_statusToolbarF) + IWStatusTableBorder;
}
@end
