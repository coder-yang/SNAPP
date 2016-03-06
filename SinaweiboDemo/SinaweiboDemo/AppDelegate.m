//
//  AppDelegate.m
//  SinaweiboDemo
//
//  Created by Simon on 14-4-3.
//  Copyright (c) 2014年 Simon. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "NSString+Expand.h"
#import "AFNetworkActivityIndicatorManager.h"

#import "GridView.h"


@implementation AppDelegate
@synthesize tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    NSUserDefaults *userDefaults =[NSUserDefaults standardUserDefaults];
    NSString *accessToken = [userDefaults objectForKey:kAccessToken];
    if([NSString isEmptyString:accessToken] || ![SystemSetting isVaildToken])
    {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        self.window.rootViewController = loginVC;
    }
    else
    {
        MainViewController *main = [[MainViewController alloc]init];
        self.window.rootViewController = main;
    }

    [self.window makeKeyAndVisible];
    return YES;
}

@end
