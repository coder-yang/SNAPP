//
//  HomeVC.m
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/8.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import "HomeVC.h"
#import "BussinessManager.h"
#import "NSMutableDictionary+Extend.h"
#import "WeiboDetailVC.h"
#import "WeiboListCell.h"
#import "MJRefresh.h"

@interface HomeVC ()
{
    UITableView *m_tableView;
    NSMutableArray *m_dataArr;
    int page;
    BOOL isLoadMore;
}
@end

@implementation HomeVC

- (BOOL)showBackButton
{
    return NO;
}

- (BOOL)isExistTabBar
{
    return YES;
}

- (instancetype)init
{
    if(self = [super init])
    {
        page = 1;
    }
    
    return self;
}

- (UIView *)mainContentView
{
    UIView *mainView = [[UIView alloc]initWithFrame:self.mainContentViewFrame];
    mainView.backgroundColor = [UIColor whiteColor];
    
    m_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWith, self.mainContentViewFrame.size.height)];
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    m_tableView.backgroundColor = [UIColor colorWithHex:0xf2f2f2];
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [mainView addSubview:m_tableView];
    
    __weak HomeVC *weakSelf = self;

    [m_tableView addLegendFooterWithRefreshingBlock:^{
        page = page+1;
        isLoadMore = YES;
        [weakSelf requestFriendTimeLine];
    }];
    
    [m_tableView addLegendHeaderWithRefreshingBlock:^{
        page = 1;
        isLoadMore = NO;
        [weakSelf requestFriendTimeLine];
    }];
    
    m_tableView.header.updatedTimeHidden = YES;
    m_tableView.footer.hidden = YES;
    
    return mainView;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navTitle = @"微博";
    self.customNav.userInteractionEnabled = YES;
    
    [m_tableView.header beginRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return m_dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiboEntity *entity = m_dataArr[indexPath.row];
    
    float textHeight = [entity.weiboText getHeightByWidth:kScreenWith-20 font:WeiboTextFont];
    NSString *retweetStr = [NSString stringWithFormat:@"@%@ %@", entity.retweeted_status.user.name,entity.retweeted_status.weiboText];
    float retweetHeight = [retweetStr getHeightByWidth:kScreenWith-20 font:RetweetWeiboTextFont]+20;

    return 50+textHeight+kBtnHeight+10+(entity.retweeted_status?retweetHeight+20:90);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cellIdentify";
    WeiboListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if(cell == nil)
    {
        cell = [[WeiboListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    
    if(cell.imageView)
    {
        [cell.imgView removeFromSuperview];
        cell.imgView = nil;
    }
    if(cell.retweetView)
    {
        [cell.retweetView removeFromSuperview];
        cell.retweetView = nil;
    }
    
    WeiboEntity *entity = m_dataArr[indexPath.row];
    [cell layoutCellWithEntity:entity];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiboDetailVC *detailVC = [[WeiboDetailVC alloc]init];
    detailVC.backText = self.tabBarItem.title;
    [self.navigationController pushViewController:detailVC animated:YES];
    
    //消除cell选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 网络请求
- (void)requestFriendTimeLine
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObjectExtra:kSinaKey forKey:@"source"];
    [params setObjectExtra:[SystemSetting getAccesstoken] forKey:@"access_token"];
    [params setObjectExtra:[NSNumber numberWithInt:kPageCount] forKey:@"count"];
    [params setObjectExtra:[NSNumber numberWithInt:page] forKey:@"page"];
    
    [[BussinessManager sharedBussinessManager].weiboManager requestFriendTimeLine:params success:^(NSMutableArray *resultArr) {
        
        m_tableView.footer.hidden = NO;
        
        if(isLoadMore)
        {//加载更多
            [m_dataArr addObjectsFromArray:resultArr];
            [m_tableView.footer endRefreshing];
        }
        else
        {//下拉刷新
            [m_dataArr removeAllObjects];
            m_dataArr = resultArr;
            [m_tableView.header endRefreshing];
        }
        
        [m_tableView reloadData];
        
    } fail:^(NSString *errorStr) {
        
        if(isLoadMore)
        {
            page--;
            [m_tableView.footer endRefreshing];
            [m_tableView.footer setTitle:@"加载失败，点击重试" forState:MJRefreshFooterStateIdle];
        }
        else
        {
            [m_tableView.header endRefreshing];
        }

    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
