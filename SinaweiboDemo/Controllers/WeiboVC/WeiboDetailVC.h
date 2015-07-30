//
//  WeiboDetailVC.h
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/9.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboEntity.h"
#import "BussinessManager.h"

@interface WeiboDetailVC : BaseViewController <UITableViewDataSource, UITableViewDelegate>

- (instancetype)initWithEntity:(WeiboEntity *)entity;

@end
