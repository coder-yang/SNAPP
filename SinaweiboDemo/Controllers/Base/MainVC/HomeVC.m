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
    
    m_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWith, self.mainContentViewFrame.size.height)];
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    [mainView addSubview:m_tableView];
    
    return mainView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navTitle = @"微博";
    
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    
    WeiboEntity *entity = m_dataArr[indexPath.row];
    cell.textLabel.text = entity.text;
    
    return cell;
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
        
    } fail:^(NSString *errorStr){
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
