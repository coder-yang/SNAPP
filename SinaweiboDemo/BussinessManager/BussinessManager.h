//
//  BussinessManager.h
//  DemoProject
//
//  Created by 杨方明 on 15/1/7.
//  Copyright (c) 2015年 urun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSMutableDictionary+Extend.h"
#import "LoginManager.h"
#import "RegisterManager.h"
#import "MainManager.h"
#import "SearchManager.h"
#import "CommentManager.h"
#import "CollectManager.h"

@interface BussinessManager : NSObject

@property (nonatomic, strong) LoginManager *loginManager;

@property (nonatomic, strong) RegisterManager *registerManager;

@property (nonatomic, strong) MainManager *mainManager;
@property (nonatomic, strong) SearchManager *searchManager;
@property (nonatomic, strong) CommentManager *commentManager;
@property (nonatomic, strong) CollectManager *collectManager;

+ (instancetype)sharedBussinessManager;

@end
