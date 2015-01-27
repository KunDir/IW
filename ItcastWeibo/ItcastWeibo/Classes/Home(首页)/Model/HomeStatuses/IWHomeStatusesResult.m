//
//  IWHomeStatusesResult.m
//  ItcastWeibo
//
//  Created by kun on 15/1/27.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "IWHomeStatusesResult.h"
#import "MJExtension.h"
#import "IWStatus.h"

@implementation IWHomeStatusesResult

- (NSDictionary *)objectClassInArray
{
    return @{@"statuses" : [IWStatus class]};
}
@end
