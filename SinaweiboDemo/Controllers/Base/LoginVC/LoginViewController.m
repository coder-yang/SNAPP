//
//  LoginViewController.m
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/8.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import "JSONKit.h"
#import "NSString+Expand.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    myWebView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    myWebView.scrollView.scrollEnabled = NO;
    myWebView.delegate = self;
    [self.view addSubview:myWebView];
    
    NSMutableString *accessTokenUrlString = [[NSMutableString alloc]initWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@&response_type=code&display=mobile",kSinaKey,@"https://api.weibo.com/oauth2/default.html"];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:accessTokenUrlString]];
    [myWebView loadRequest:request];
}

#pragma mark -
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *url = webView.request.URL.absoluteString; //转为strng
    DLog(@"%@",url);
    if([url hasPrefix:@"https://api.weibo.com/oauth2/default.html"])
    {
        NSArray *codeArray = [url componentsSeparatedByString:@"="];
        NSString * code = [codeArray objectAtIndex:1];
        [self getAccessToken:code];
    }
}

-(void)getAccessToken:(NSString *)code
{
    NSLog(@"%@",code);
    NSMutableString *accessTokenUrlString = [[NSMutableString alloc]initWithFormat:@"https://api.weibo.com/oauth2/access_token?client_id=%@&client_secret=%@&grant_type=authorization_code&redirect_uri=%@&code=%@",kSinaKey,kSinaSecret,@"https://api.weibo.com/oauth2/default.html",code];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:accessTokenUrlString]];
    [request setHTTPMethod:@"POST"];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    DLog(@"dic:%@",dic);
    accessToken = [dic objectForKey:@"access_token"];
    NSString *expires_in = [dic objectForKey:@"expires_in"];
    NSDate *expiresDate = [NSDate dateWithTimeInterval:[expires_in longLongValue] sinceDate:[NSDate date]];
    NSString *uid = [dic objectForKey:@"uid"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accessToken forKey:kAccessToken];
    [defaults setObject:expiresDate forKey:kExpireTime];
    [defaults setObject:uid forKey:kUid];
    [defaults synchronize];
    
    MainViewController *main = [[MainViewController alloc]init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = main;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
