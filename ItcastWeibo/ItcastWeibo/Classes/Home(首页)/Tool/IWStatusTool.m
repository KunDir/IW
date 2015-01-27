//
//  IWStatusTool.m
//  ItcastWeibo
//
//  Created by kun on 15/1/27.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "IWStatusTool.h"
#import "IWHttpToll.h"
#import "IWHomeStatusesParam.h"
#import "MJExtension.h"

@implementation IWStatusTool

+ (void)homeStatusesWithParam:(IWHomeStatusesParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    // 1.发送请求
    [IWHttpToll getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:param.keyValues success:^(id json) {
        if(success)
        {
            success(json);
        }
        
    } failure:^(NSError *error) {
        if(failure)
        {
            failure(error);
        }
    }];
}

@end
