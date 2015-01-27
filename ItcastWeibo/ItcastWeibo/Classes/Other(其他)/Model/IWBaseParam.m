//
//  IWBaseParam.m
//  ItcastWeibo
//
//  Created by kun on 15/1/27.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "IWBaseParam.h"
#import "IWAccount.h"
#import "IWAccountTool.h"

@implementation IWBaseParam

- (instancetype)init
{
    if(self = [super init])
    {
        self.access_token = [IWAccountTool account].access_token;
    }
    return self;
}

+ (instancetype)param
{
    return [[self alloc] init];
}

//
//- (NSString *)access_token
//{
//    if(_access_token == nil)
//    {
//        _access_token = [IWAccountTool account].access_token;
//    }
//    return _access_token;
//}
@end
