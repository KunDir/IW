//
//  IWComposeToolbar.h
//  ItcastWeibo
//
//  Created by kun on 15/1/25.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWComposeToolbar;

typedef enum {
    IWComposeToolbarButtonTypeCamera,
    IWComposeToolbarButtonTypePicture,
    IWComposeToolbarButtonTypeMention,
    IWComposeToolbarButtonTypeTrend,
    IWComposeToolbarButtonTypeEmotion
}IWComposeToolbarButtonType;

@protocol IWComposeDelegate <NSObject>

- (void)composeToolbar:(IWComposeToolbar *)toolbar didClickButton:(IWComposeToolbarButtonType)buttonType;

@end
@interface IWComposeToolbar : UIView
@property (nonatomic, weak) id<IWComposeDelegate> delegate;
@end
