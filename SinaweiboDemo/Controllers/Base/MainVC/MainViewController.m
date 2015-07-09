
//
//  MainViewController.m
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/8.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import "MainViewController.h"
#import "LoginViewController.h"
#import "HomeVC.h"
#import "MessageVC.h"
#import "FindVC.h"
#import "MineVC.h"
#import "MainTabbarController.h"
#define kBtnWidth (kScreenWith/5)

@interface MainViewController ()
{
    HomeVC *homeVC;
    MessageVC *messageVC;
    FindVC *findVC;
    MineVC *mineVC;
    UINavigationController *homeNav; //要设置为全局变量，否则arc下会提前释放，导致push操作失败
    UINavigationController *messageNav;
    UINavigationController *findNav;
    UINavigationController *mineNav;
    UIImageView *tabBarBg;
}
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MainTabbarController *mainTabbarContrller = [[MainTabbarController alloc]init];
    mainTabbarContrller.view.frame = CGRectMake(0, 0, kScreenWith, self.view.frame.size.height-kTabbarHeight);
    [self.view insertSubview:mainTabbarContrller.view atIndex:0];
    
    tabBarBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-kTabbarHeight, kScreenWith, kTabbarHeight)];
    tabBarBg.backgroundColor = [UIColor colorWithHex:0xf6f6f6];
    tabBarBg.userInteractionEnabled = YES;
    [self.view addSubview:tabBarBg];
    
    homeVC = [[HomeVC alloc]init];
    messageVC = [[MessageVC alloc]init];
    findVC = [[FindVC alloc]init];
    mineVC = [[MineVC alloc]init];
    
    homeVC.hidesBottomBarWhenPushed = true;
    messageVC.hidesBottomBarWhenPushed = true;
    findVC.hidesBottomBarWhenPushed = true;
    mineVC.hidesBottomBarWhenPushed = true;
    
    homeNav = [[UINavigationController alloc]initWithRootViewController:homeVC];
    messageNav = [[UINavigationController alloc]initWithRootViewController:messageVC];
    findNav = [[UINavigationController alloc]initWithRootViewController:findVC];
    mineNav = [[UINavigationController alloc]initWithRootViewController:mineVC];
    
    mainTabbarContrller.viewControllers = [NSArray arrayWithObjects:homeNav,messageNav,findNav,mineNav, nil];;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
