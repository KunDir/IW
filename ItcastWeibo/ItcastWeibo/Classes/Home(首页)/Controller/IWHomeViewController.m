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

#import "IWHttpToll.h"
#import "IWAccount.h"
#import "IWAccountTool.h"
#import "UIImageView+WebCache.h"
#import "IWStatus.h"
#import "IWUser.h"
#import "MJExtension.h"
#import "IWStatusFrame.h"
#import "IWStatusCell.h"
#import "IWUser.h"
#import "MJRefresh.h"
#import "IWStatusTool.h"
#import "IWUserTool.h"

#define NavigationbarArrowDown 0
#define NavigationBarArrowUp 1

@interface IWHomeViewController () <MJRefreshBaseViewDelegate>

@property (nonatomic, weak) IWTitleButton *titleButton;

@property (nonatomic, strong) NSMutableArray *statusesFrames;

@property (nonatomic, weak) MJRefreshFooterView *footer;

@property (nonatomic, weak) MJRefreshHeaderView *header;

@end

@implementation IWHomeViewController

- (NSMutableArray *)statusesFrames
{
    if(_statusesFrames == nil)
    {
        _statusesFrames = [NSMutableArray array];
    }
    return _statusesFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 0.集成刷新控件
    [self setupRefreshView];
    
    // 1.设置导航栏的内容
    [self setupNavBar];
    
    // 2.加载微博数据
//    [self setupStatusData];
    
    // 获取用户信息
    [self setupUserData];
}

// 获取用户信息
- (void)setupUserData
{
    // 1.封装请求参数
    IWUserInfoParam *param = [[IWUserInfoParam alloc] init];
    param.uid = @([IWAccountTool account].uid);
    
    // 2.发送请求
    [IWUserTool userInfoWithParam:param success:^(IWUserInfoResult *result) {
        // 设置标题文字
        [self.titleButton setTitle:result.name forState:UIControlStateNormal];
        
        // 保持昵称
        IWAccount *account = [IWAccountTool account];
        account.name = result.name;
        [IWAccountTool saveAccount:account];
    } failure:^(NSError *error) {
        
    }];
}

/**
 *  集成刷新控件
 */
- (void)setupRefreshView
{
    // 下拉刷新
    MJRefreshHeaderView *heaer = [MJRefreshHeaderView header];
    heaer.scrollView = self.tableView;
    heaer.delegate = self;
    // 自动进入刷新状态
    [heaer beginRefreshing];
    self.header = heaer;
    
    // 上拉刷新
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.delegate = self;
    self.footer = footer;
}

- (void)refresh
{
    if([self.tabBarItem.badgeValue intValue] > 0)
    {
        [self.header beginRefreshing];
    }
}

- (void)dealloc
{
    [self.header free];
    [self.footer free];
}

/**
 *  刷新控件进入开始刷新状态的时候调研
 *
 *  @param refreshView
 */
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if([refreshView isKindOfClass:[MJRefreshFooterView class]])
    {
        [self loadMoreData];
    }
    else
    {
        [self loadNewData];
    }
    
}

- (void)loadMoreData
{
    // 1.封装请求参数
    IWHomeStatusesParam *param = [[IWHomeStatusesParam alloc] init];
//    param.count = @5;
    if(self.statusesFrames.count){
        IWStatusFrame *statusFrame = [self.statusesFrames lastObject];
        param.max_id = @([statusFrame.status.idstr longLongValue] - 1);
    }
    
    // 2.发送请求
    [IWStatusTool homeStatusesWithParam:param success:^(IWHomeStatusesResult *result) {
        // 创建Frame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for(IWStatus *status in result.statuses)
        {
            IWStatusFrame *statusFrame = [[IWStatusFrame alloc] init];
            // 传递微博模型数据
            statusFrame.status = status;

            [statusFrameArray addObject:statusFrame];
        }
        // 添加新数据到旧数据的后面
        [self.statusesFrames addObjectsFromArray:statusFrameArray];
        
        // 刷新表格
        [self.tableView reloadData];
        
        [self.footer endRefreshing];
    } failure:^(NSError *error) {
        // 停止刷新控制器刷新状态
        [self.footer endRefreshing];
    }];
}

- (void)loadNewData
{
    // 清除提醒数字
    self.tabBarItem.badgeValue = nil;
    
    // 1.封装请求参数
    IWHomeStatusesParam *param = [[IWHomeStatusesParam alloc] init];
//    param.count = @5;
    if(self.statusesFrames.count){
        IWStatusFrame *statusFrame = self.statusesFrames[0];
        // 加载ID比since_id大的微博
        param.since_id = @([statusFrame.status.idstr longLongValue]);
    }
    // 2.发送请求
    [IWStatusTool homeStatusesWithParam:param success:^(IWHomeStatusesResult *result) {
        // 创建Frame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for(IWStatus *status in result.statuses)
        {
            IWStatusFrame *statusFrame = [[IWStatusFrame alloc] init];
            // 传递微博模型数据
            statusFrame.status = status;
            
            [statusFrameArray addObject:statusFrame];
        }
        
        // 将最新的数据追加到旧数据的最前面
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObjectsFromArray:statusFrameArray];
        [tempArray addObjectsFromArray:self.statusesFrames];
        self.statusesFrames = tempArray;
        // 刷新表格
        [self.tableView reloadData];
        
        // 停止刷新控制器刷新状态
        [self.header endRefreshing];
        
        // 显示最新微博的数量（给用户一些友善的提示）
        [self showNewStatusCount:statusFrameArray.count];
    } failure:^(NSError *error) {
        // 停止刷新控制器刷新状态
        [self.header endRefreshing];
    }];
}

/**
 *  显示最新微博的数量
 *
 *  @param count 最新微博的数量
 */
- (void)showNewStatusCount:(int)count
{
    // 1.创建一个按钮
    UIButton *btn = [[UIButton alloc] init];
    // below：下面 btn会显示在
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    // 2.设置图片和文字
    btn.userInteractionEnabled = NO;
    [btn setBackgroundImage:[UIImage resizedImageWithName:@"timeline_new_status_background"] forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    if(count)
    {
        NSString *title = [NSString stringWithFormat:@"共有%d条新微博", count];
        [btn setTitle:title forState:UIControlStateNormal];
    }
    else
    {
        [btn setTitle:@"没有新的微博数据" forState:UIControlStateNormal];
    }
    
    // 3.设置按钮的初始frame
    CGFloat btnH = 30;
    CGFloat btnY = 64 - btnH;
    CGFloat btnX = 0;
    CGFloat btnW = self.view.frame.size.width;
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    // 4.通过动画移动按钮（按钮向下移动 btnH + 1）
    [UIView animateWithDuration:0.7 animations:^{
        btn.transform = CGAffineTransformMakeTranslation(0, btnH + 1);
    } completion:^(BOOL finished) { // 向下移动的动画执行完毕后
        
        // 这段代码 ios6也能运行
        [UIView animateWithDuration:0.7 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            // 执行向上移动的动画（清空transform）
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            // 将btn从内存中移除
            [btn removeFromSuperview];
        }];
    }];
}

// 加载微博数据
- (void)setupStatusData
{
    // 1.封装请求参数
    IWHomeStatusesParam *param = [[IWHomeStatusesParam alloc] init];
    param.access_token = [IWAccountTool account].access_token;
    param.count = @10;
    
    // 2.发送请求
    [IWStatusTool homeStatusesWithParam:param success:^(IWHomeStatusesResult *result) {
        // 创建Frame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for(IWStatus *status in result.statuses)
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
    } failure:^(NSError *error) {
        
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
    // 位置和尺寸
    titleButton.frame = CGRectMake(0, 0, 0, 40);
    // 文字 setTitle方法被重写了
    if([IWAccountTool account].name)
    {
        [titleButton setTitle:[IWAccountTool account].name forState:UIControlStateNormal];
    }
    else
    {
        [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    }
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
//    CGSize titleSize = [titleButton.titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleButton.titleLabel.font, NSFontAttributeName, nil]];    
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
    
    self.titleButton = titleButton;
    
    self.tableView.backgroundColor = IWColor(226, 226, 226);
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, IWStatusTableBorder, 0);
    // 不显示cell的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
