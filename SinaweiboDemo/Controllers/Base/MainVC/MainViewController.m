
//
//  MainViewController.m
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/8.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import "MainViewController.h"
#import "LoginViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *expireTime = [userDefaults objectForKey:kExpireTime];
    
    
    UITabBarController *mainTabbarContrller = [[UITabBarController alloc]init];
    for(UIView *view in mainTabbarContrller.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            view.hidden = YES;
            break;
        }
    }
    [self.view addSubview:mainTabbarContrller.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
