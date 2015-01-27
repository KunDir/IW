//
//  IWUserUnreadCountResult.m
//  ItcastWeibo
//
//  Created by kun on 15/1/27.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "IWUserUnreadCountResult.h"

@implementation IWUserUnreadCountResult

- (int)messageCount
{
    return self.cmt + self.mention_cmt + self.mention_status + self.dm;
}
@end
