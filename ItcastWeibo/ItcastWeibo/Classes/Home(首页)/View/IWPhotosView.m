//
//  IWPhotosView.m
//  ItcastWeibo
//
//  Created by kun on 15/1/24.
//  Copyright (c) 2015年 kun. All rights reserved.
//


#import "IWPhotosView.h"

#import "IWPhoto.h"
#import "IWPhotoView.h"

#import "MJPhoto.h"
#import "MJPhotoBrowser.h"


@implementation IWPhotosView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        // 初始化9个子控件
        for(int index = 0; index < 9; index++)
        {
            IWPhotoView *photoView = [[IWPhotoView alloc] init];
            photoView.userInteractionEnabled = YES;
            photoView.tag = index;
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)];
            [photoView addGestureRecognizer:recognizer];
            [self addSubview:photoView];
        }
    }
    return self;
}

- (void)photoTap:(UITapGestureRecognizer *)recognizer
{
    int count = self.photos.count;
    
    // 1.封装图片数据
    NSMutableArray *myphotos = [NSMutableArray arrayWithCapacity:count];
    for(int i = 0; i < count; i++)
    {
        // 一个MJPhoto对应一张显示的图片
        MJPhoto *mjphoto = [[MJPhoto alloc] init];
        
        mjphoto.srcImageView = self.subviews[i]; // 来源于哪个UIImageView
        
        IWPhoto *iwphoto = self.photos[i];
        
        // 替换字符串－－－将缩列图变为清晰图
        NSString *photoUrl = [iwphoto.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        mjphoto.url = [NSURL URLWithString:photoUrl]; // 图片路径
        
        [myphotos addObject:mjphoto];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = recognizer.view.tag; // 弹出相册时显示第一张图片是？
    browser.photos = myphotos; // 设置所有的图片
    [browser show];
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    for(int i = 0; i < self.subviews.count; i++)
    {
        // 取出i位置对应的imageView
        IWPhotoView *photoView = self.subviews[i];
        
        // 判断这个imageView是否需要显示数据
        if(i < photos.count)
        {
            // 显示图片
            photoView.hidden = NO;
            
            // 传递模型数据
            photoView.photo = photos[i];
            
            // 设置子控件的frame
            int maxColumns = (photos.count == 4) ? 2 : 3;
            int col = i % maxColumns;
            int row = i / maxColumns;
            CGFloat photoX = col * (IWPhotoW + IWPhotoMargin);
            CGFloat photoY = row * (IWPhotoH + IWPhotoMargin);
            photoView.frame = CGRectMake(photoX, photoY, IWPhotoW, IWPhotoH);
            
            if(photos.count == 1)
            {
                photoView.contentMode = UIViewContentModeScaleAspectFit;
                photoView.clipsToBounds = NO;
            }
            else
            {
                photoView.contentMode = UIViewContentModeScaleAspectFill;
                photoView.clipsToBounds = YES;
            }
        }
        else
        {
            // 隐藏imageView
            photoView.hidden = YES;
        }
    }
}

+ (CGSize)photosViewSizeWithPhotosCount:(int)count
{
    // 一行最多有3列
    int maxColumns = (count == 4) ? 2 : 3;
    
    // 总行数
    int rows = (count + maxColumns - 1) / maxColumns;
    
    // 高度
    CGFloat photosH = rows * IWPhotoH + (rows - 1) * IWPhotoMargin;
    
    // 总列数
    int cols = (count >= maxColumns) ? maxColumns : count;
    
    CGFloat photosW = cols * IWPhotoW + (cols -1) * IWPhotoMargin;
    
    
    return CGSizeMake(photosW, photosH);
}
@end
