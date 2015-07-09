//
//  MainTabbarController.m
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/9.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import "MainTabbarController.h"

@interface MainTabbarController ()

@end

@implementation MainTabbarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self hideExistingTabBar];
}

-(void)hideExistingTabBar
{
    for(UIView *view in self.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            view.hidden = YES;
            break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
