//
//  LoginViewController.h
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/8.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : UIViewController <UIWebViewDelegate>
{
    UIWebView *myWebView;
    NSString *accessToken;
}
@end
