//
//  IWUserUnreadCountParam.h
//  ItcastWeibo
//
//  Created by kun on 15/1/27.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "IWBaseParam.h"

@interface IWUserUnreadCountParam : IWBaseParam
/**
 *  需要查询的用户ID
 */
@property (nonatomic, strong) NSNumber *uid;
@end
