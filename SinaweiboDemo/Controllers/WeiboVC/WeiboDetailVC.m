//
//  WeiboDetailVC.m
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/9.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import "WeiboDetailVC.h"

@interface WeiboDetailVC ()

@end

@implementation WeiboDetailVC

- (UIView *)mainContentView
{
    UIView *mainView = [[UIView alloc]initWithFrame:self.mainContentViewFrame];
    mainView.backgroundColor = [UIColor grayColor];
    return mainView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
