//
//  IWHomeViewController.m
//  ItcastWeibo
//
//  Created by kun on 15/1/16.
//  Copyright (c) 2015年 kun. All rights reserved.
//

#import "IWHomeViewController.h"

#import "UIBarButtonItem+IW.h"

#import "IWTitleButton.h"

#import "AFNetworking.h"
#import "IWAccount.h"
#import "IWAccountTool.h"
#import "UIImageView+WebCache.h"
#import "IWStatus.h"
#import "IWUser.h"
#import "MJExtension.h"
#import "IWStatusFrame.h"
#import "IWStatusCell.h"

#define NavigationbarArrowDown 0
#define NavigationBarArrowUp 1

@interface IWHomeViewController ()

@property (nonatomic, strong) NSArray *statusesFrames;

@end

@implementation IWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.设置导航栏的内容
    [self setupNavBar];
    
    // 2.加载微博数据
    [self setupStatusData];
}

// 加载微博数据
- (void)setupStatusData
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [IWAccountTool account].access_token;
    params[@"count"] = @20;
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 取出所有的微博数据（每一条微博都是一个字典）
        
        // 将字典数据转为模型数据(里面放的就是IWStatus模型）
        NSArray *statusArray = [IWStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        // 创建Frame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for(IWStatus *status in statusArray)
        {
            IWStatusFrame *statusFrame = [[IWStatusFrame alloc] init];
            // 传递微博模型数据
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        
        // 赋值
        self.statusesFrames = statusFrameArray;
        
        // 刷新表格
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


// 设置导航栏的内容
- (void)setupNavBar
{
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch" highIcon:@"navigationbar_friendsearch_highlighted" target:self action:@selector(findFriend)];
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop" highIcon:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    // 中间按钮
    IWTitleButton *titleButton = [IWTitleButton titleButton];
    
    // 图标
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    // 文字
    [titleButton setTitle:@"哈哈哈" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    CGSize titleSize = [titleButton.titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleButton.titleLabel.font, NSFontAttributeName, nil]];
    
    
    titleButton.frame = CGRectMake(0, 0, titleSize.width + 24, 40);
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
}

// 控制剪头方向
- (void)titleClick:(IWTitleButton *)titleButton
{
    if(titleButton.tag == NavigationbarArrowDown)
    {
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        titleButton.tag = NavigationBarArrowUp;
    }
    else
    {
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        titleButton.tag = NavigationbarArrowDown;
    }
}

- (void)pop
{
    IWLog(@"pop");
}

- (void)findFriend
{
    IWLog(@"findFriend");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.statusesFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 创建cell
    IWStatusCell *cell = [IWStatusCell cellWithTableView:tableView];
    
    // 传递frame模型
    cell.statusFrame = self.statusesFrames[indexPath.row];
    
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IWStatusFrame *statuesFrame = self.statusesFrames[indexPath.row];
    return statuesFrame.cellHeight;
}

@end
