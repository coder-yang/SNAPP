//
//  BussinessManager.h
//  DemoProject
//
//  Created by 杨方明 on 15/1/7.
//  Copyright (c) 2015年 urun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboMannager.h"
#import "CommentManager.h"

@interface BussinessManager : NSObject

@property (nonatomic, strong) WeiboMannager *weiboManager;
@property (nonatomic, strong) CommentManager *commentManager;

+ (instancetype)sharedBussinessManager;

@end
