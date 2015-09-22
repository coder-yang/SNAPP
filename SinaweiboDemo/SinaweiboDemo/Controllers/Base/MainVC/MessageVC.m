//
//  MessageVC.m
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/8.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import "MessageVC.h"

@interface MessageVC ()

@end

@implementation MessageVC

- (BOOL)showBackButton
{
    return NO;
}

- (BOOL)isExistTabBar
{
    return YES;
}

- (UIView *)mainContentView
{
    UIView *mainView = [[UIView alloc]initWithFrame:self.mainContentViewFrame];
    mainView.backgroundColor = [UIColor whiteColor];
    return mainView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navTitle = @"消息";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
