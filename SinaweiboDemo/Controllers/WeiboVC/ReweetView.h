//
//  ReweetView.h
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/15.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboEntity.h"
#import "GridView.h"

@interface ReweetView : UIView

@property(nonatomic, strong) UILabel *reweetTextLb;

@property(nonatomic, strong) GridView *gridView;

- (instancetype)init;

- (void)layoutWithEntity:(WeiboEntity *)entity;

@end
