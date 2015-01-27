//
//  IWHomeStatusesParam.h
//  ItcastWeibo
//
//  Created by kun on 15/1/27.
//  Copyright (c) 2015年 kun. All rights reserved.
//  

#import <Foundation/Foundation.h>
#import "IWBaseParam.h"
@interface IWHomeStatusesParam : IWBaseParam

@property (nonatomic, strong) NSNumber *since_id;

@property (nonatomic, strong) NSNumber *max_id;

@property (nonatomic, strong) NSNumber *count;
@end
