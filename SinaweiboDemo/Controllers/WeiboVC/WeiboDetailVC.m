//
//  WeiboDetailVC.m
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/9.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import "WeiboDetailVC.h"
@interface WeiboDetailVC ()
{
    UITableView *m_tableView;
}
@end

@implementation WeiboDetailVC

- (UIView *)mainContentView
{
    UIView *mainView = [[UIView alloc]initWithFrame:self.mainContentViewFrame];
    mainView.backgroundColor = [UIColor whiteColor];
    return mainView;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navTitle = @"微博正文";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
