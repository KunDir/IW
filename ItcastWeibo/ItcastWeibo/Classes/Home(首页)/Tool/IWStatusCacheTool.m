//
//  IWStatusCacheTool.m
//  ItcastWeibo
//
//  Created by kun on 15/1/29.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "IWStatusCacheTool.h"
#import "IWAccount.h"
#import "IWAccountTool.h"
#import "FMDB.h"

@implementation IWStatusCacheTool

static FMDatabaseQueue *_queue;

/**
 *  这个类方法只会被调用一次，仅在第一次用到这个类的方法时被调用
 *
 */
+ (void)initialize
{
    // 0.获得沙盒中的数据库文件名
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"statuses.sqlite"];
//    NSLog(@"%@", path);
    // 1.创建队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    // 2.创建表
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_status (id integer primary key autoincrement, access_token text, idstr text, dict blob);"];
    }];
}

+ (void)addStatus:(NSDictionary *)dict
{
    [_queue inDatabase:^(FMDatabase *db) {
        NSString *accessToken = [IWAccountTool account].access_token;
        NSString *idstr = dict[@"idstr"];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
        [db executeUpdate:@"insert into t_status (access_token, idstr, dict) values(?, ?, ?);", accessToken, idstr, data];
    }];
}

+ (void)addStatuses:(NSArray *)dictArray
{
    for(NSDictionary *dict in dictArray)
    {
        [self addStatus:dict];
    }
}

+ (NSArray *)statusWithParam:(IWHomeStatusesParam *)param
{
    __block NSMutableArray *dictArray = nil;
    
    [_queue inDatabase:^(FMDatabase *db) {
        dictArray = [NSMutableArray array];
        
        NSString *accessToken = [IWAccountTool account].access_token;
        FMResultSet *rs = nil;
        if(param.since_id)
        {
            rs = [db executeQuery:@"select * from t_status where access_token = ? and idstr > ? order by idstr desc limit 0, ?;", accessToken, param.since_id, param.count];
        }
        else if(param.max_id)
        {
            rs = [db executeQuery:@"select * from t_status where access_token = ? and idstr <= ? order by idstr desc limit 0, ?;", accessToken, param.max_id, param.count];
        }
        else
        {
            rs = [db executeQuery:@"select * from t_status where access_token = ? order by idstr desc limit 0, ?;", accessToken, param.count];
        }
        
        
        while (rs.next) {
            NSData *data = [rs dataForColumn:@"dict"];
            NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            
            [dictArray addObject:dict];
        }
    }];
    return dictArray;
    
}

@end
