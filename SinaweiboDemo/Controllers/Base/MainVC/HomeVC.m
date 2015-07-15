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

@interface HomeVC ()
{
    UITableView *m_tableView;
    NSMutableArray *m_dataArr;
    int page;
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
    [mainView addSubview:m_tableView];
    
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
    
    [self requestFriendTimeLine];
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
    
    return 10+30+textHeight+10+40+10+90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cellIdentify";
    WeiboListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if(cell == nil)
    {
        cell = [[WeiboListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    
    [cell layoutCellWithEntity:m_dataArr[indexPath.row]];
    
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
        
        m_dataArr = resultArr;
        [m_tableView reloadData];
        
    } fail:^(NSString *errorStr) {
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
