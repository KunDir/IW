//
//  IWStatusCell.h
//  ItcastWeibo
//
//  Created by kun on 15/1/21.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWStatusFrame;
@interface IWStatusCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) IWStatusFrame *statusFrame;
@end
