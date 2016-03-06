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
#import <AVFoundation/AVFoundation.h>
#import "UIViewController+Expand.h"

@interface HomeVC ()
{
    UITableView *m_tableView;
    NSMutableArray *m_dataArr;
    NSInteger page;
    NSInteger totalPage;
    BOOL isLoadMore;
    AVAudioPlayer *palyer;
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
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"msgcome" ofType:@"wav"];
        palyer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:filePath] error:nil];
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
        page += 1;
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
    float retweetHeight = [retweetStr getHeightByWidth:kScreenWith-20 font:RetweetWeiboTextFont]+10;

    return 50+textHeight+kBtnHeight+10+(entity.retweeted_status?retweetHeight+20+([GridView getGridViewHeight:entity.retweeted_status]):[GridView getGridViewHeight:entity]+10);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cellIdentify";
    WeiboListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if(cell == nil)
    {
        cell = [[WeiboListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }

    if(cell.retweetView)
    {
        [cell.retweetView removeFromSuperview];
        cell.retweetView = nil;
    }
    if(cell.gridView)
    {
        [cell.gridView removeFromSuperview];
        cell.gridView = nil;
    }
    
    WeiboEntity *entity = m_dataArr[indexPath.row];
    [cell layoutCellWithEntity:entity];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiboDetailVC *detailVC = [[WeiboDetailVC alloc]initWithEntity:m_dataArr[indexPath.row]];
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
    [params setObjectExtra:[NSNumber numberWithInteger:kPageCount] forKey:@"count"];
    [params setObjectExtra:[NSNumber numberWithInteger:page] forKey:@"page"];
    
    [[BussinessManager sharedBussinessManager].weiboManager requestFriendTimeLine:params success:^(NSMutableArray *resultArr, NSInteger aTotalPage) {
        
        totalPage = aTotalPage;
        
        if(isLoadMore)
        {//加载更多
            if(page < totalPage)
            {
                [m_dataArr addObjectsFromArray:resultArr];
            }
            else
            {
                page = totalPage;
                [m_tableView.footer setTitle:@"全部加载完，没有更多了" forState:MJRefreshFooterStateIdle];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5), dispatch_get_main_queue(), ^{
                    m_tableView.footer.userInteractionEnabled = NO;
                });
            }
            
            [m_tableView.footer endRefreshing];
        }
        else
        {//下拉刷新
            [palyer prepareToPlay];
            [palyer play];
            
            m_tableView.footer.userInteractionEnabled = YES;
            m_tableView.footer.hidden = NO;

            [m_dataArr removeAllObjects];
            m_dataArr = resultArr;
            [m_tableView.header endRefreshing];
        }
        
        [m_tableView reloadData];
        
    } fail:^(NSString *errorStr) {
        
        if(isLoadMore)
        {
            page--; //网络请求失败，执行减操作，上拉的时候加了1，需要减1，保持当前失败的页码
            [m_tableView.footer setTitle:@"加载失败，点击重试" forState:MJRefreshFooterStateIdle];
        }
        else
        {
            [self hudShowTextOnly:errorStr delay:1.5 view:self.navigationController.view];
        }
        
        [m_tableView.footer endRefreshing];
        [m_tableView.header endRefreshing];
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
