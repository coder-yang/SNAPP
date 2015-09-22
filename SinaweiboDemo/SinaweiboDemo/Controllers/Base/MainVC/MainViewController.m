
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
#import "SNNavigationController.h"

@interface MainViewController ()
{
    UITabBarController *mainTabbarContrller;
    HomeVC *homeVC;
    MessageVC *messageVC;
    FindVC *findVC;
    MineVC *mineVC;
    SNNavigationController *homeNav;
    SNNavigationController *messageNav;
    SNNavigationController *findNav;
    SNNavigationController *mineNav;
}
@end

@implementation MainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    homeVC = [[HomeVC alloc]init];
    messageVC = [[MessageVC alloc]init];
    findVC = [[FindVC alloc]init];
    mineVC = [[MineVC alloc]init];
    
    
    homeVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页"
                                                     image:[UIImage imageNamed:@"tabbar_home"]
                                                       tag:0];
    /*
     UITabbarItem的图片都是被固定渲染为蓝色，若要改为自己的图片，需要设置图片渲染模式
     UIImageRenderingModeAutomatic  // 根据图片的使用环境和所处的绘图上下文自动调整渲染模式。
     UIImageRenderingModeAlwaysOriginal   // 始终绘制图片原始状态，不使用Tint Color。
     UIImageRenderingModeAlwaysTemplate   // 始终根据Tint Color绘制图片，忽略图片的颜色信息。
    */
    homeVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    messageVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"消息"
                                                        image:[UIImage imageNamed:@"tabbar_message"]
                                                          tag:1];
    messageVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_message_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    findVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"发现"
                                                     image:[UIImage imageNamed:@"tabbar_find"]
                                                       tag:2];
    findVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_find_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    
    mineVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我"
                                                    image:[UIImage imageNamed:@"tabbar_mine"]
                                                       tag:3];
    mineVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_mine_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    
    //设置选中时字体的颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHex:0xd29022],UITextAttributeTextColor, nil] forState:UIControlStateSelected];
    
    homeNav = [[SNNavigationController alloc]initWithRootViewController:homeVC];
    messageNav = [[SNNavigationController alloc]initWithRootViewController:messageVC];
    findNav = [[SNNavigationController alloc]initWithRootViewController:findVC];
    mineNav = [[SNNavigationController alloc]initWithRootViewController:mineVC];
    
    mainTabbarContrller = [[UITabBarController alloc]init];
    mainTabbarContrller.delegate = self;
    [self.view addSubview:mainTabbarContrller.view];
    mainTabbarContrller.viewControllers = [NSArray arrayWithObjects:homeNav,messageNav,findNav,mineNav, nil];
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"%@",viewController.title);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
