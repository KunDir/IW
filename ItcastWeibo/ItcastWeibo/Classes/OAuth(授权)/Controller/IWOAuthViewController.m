//
//  IWOAuthViewController.m
//  ItcastWeibo
//
//  Created by kun on 15/1/19.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "IWOAuthViewController.h"

#import "AFNetworking.h"

#import "IWAccount.h"

#import "IWWeiboTool.h"

#import "IWAccountTool.h"

#import "MBProgressHUD+MJ.h"



@interface IWOAuthViewController () <UIWebViewDelegate>

@end

@implementation IWOAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.添加webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    // 2.加载授权页面（新浪提供的登陆页面）
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", IWAppKey, IWRedirectURI];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

#pragma mark - webView代理方法
// webView开始发送请求的时候就会调用
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // 显示提醒框
    [MBProgressHUD showMessage:@"正在帮您加载中。。。"];
}

// webView请求完毕的时候就会调用
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 隐藏提醒框
    [MBProgressHUD hideHUD];
}

// webView请求失败的时候就会调用
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // 隐藏提醒框
    [MBProgressHUD hideHUD];
}

// dangwebView发送一个请求之前都会先调用这个方法，询问代理可不可以加载这个页面（请求）
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 1.请求的URL路径
    NSString *urlStr = request.URL.absoluteString;
    
    // 2.查找code＝在urlStr中的范围
    NSRange range = [urlStr rangeOfString:@"code="];
    if(range.length)
    {
        // 找到
        // 4.截取code＝后面的请求标记（经过用户授权成功的）
        int loc = range.location + range.length;
        NSString *code = [urlStr substringFromIndex:loc];
        
        // 5.发送请求Post请求给新浪，通过code换取一个accessToke
        [self accessTokewnWithCode:code];
        
        return NO;
        
    }
    
    return YES;
}

// 通过code换取一个accessToken
- (void)accessTokewnWithCode:(NSString *)code
{
    // AFNetWorking\AFN
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = IWAppKey;
    params[@"client_secret"] = IWAppSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = IWRedirectURI;
    
    // 3.发送请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 4.先将字典转为模型
        IWAccount *account = [IWAccount accountWithDict:responseObject];
        
        
        // 5.存储accessToken信息
        [IWAccountTool saveAccount:account];
        
        // 6.新特性\去首页
        [IWWeiboTool chooseRootController];
        
        // 7.隐藏提醒框
        [MBProgressHUD hideHUD];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 隐藏提醒框
        [MBProgressHUD hideHUD];
    }];
}
@end
