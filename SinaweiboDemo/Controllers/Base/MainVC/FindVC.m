//
//  FindVC.m
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/8.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import "FindVC.h"

@interface FindVC ()

@end

@implementation FindVC

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
    return mainView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navTitle = @"发现";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
