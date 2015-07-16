//
//  ReweetView.h
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/15.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboEntity.h"

@interface ReweetView : UIView
@property(nonatomic, strong) UILabel *reweetTextLb;

- (instancetype)init;

- (void)layoutWithEntity:(WeiboEntity *)entity;

@end
