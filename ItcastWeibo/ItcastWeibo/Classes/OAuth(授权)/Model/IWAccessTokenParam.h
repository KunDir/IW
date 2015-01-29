//
//  IWAccessTokenParam.h
//  ItcastWeibo
//
//  Created by kun on 15/1/29.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWAccessTokenParam : NSObject

@property (nonatomic, copy) NSString *client_id;
@property (nonatomic, copy) NSString *client_secret;
@property (nonatomic, copy) NSString *grant_type;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *redirect_uri;

@end
