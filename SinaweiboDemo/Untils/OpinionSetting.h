//
//  OpinionSetting.h
//  OPinion
//
//  Created by li sha on 12-7-24.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface OpinionSetting : NSObject
//设置view圆角
+ (void)setViewLayer:(UIView *)view radius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color;

//检测网络
+ (BOOL)hasNetWork;

@end
