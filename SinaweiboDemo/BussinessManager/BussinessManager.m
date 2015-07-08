//
//  BussinessManager.m
//  DemoProject
//
//  Created by 杨方明 on 15/1/7.
//  Copyright (c) 2015年 urun. All rights reserved.
//

#import "BussinessManager.h"

@implementation BussinessManager
@synthesize loginManager;
@synthesize registerManager;
@synthesize mainManager;
@synthesize searchManager;
@synthesize commentManager;
@synthesize collectManager;

+ (instancetype)sharedBussinessManager
{
    static BussinessManager *_shareBussinessManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _shareBussinessManager = [[self alloc] init];
    });
    
    return _shareBussinessManager;
}

-(instancetype)init
{
    if(self = [super init])
    {
        loginManager = [[LoginManager alloc]init];

        registerManager = [[RegisterManager alloc]init];

        mainManager = [[MainManager alloc]init];
        searchManager = [[SearchManager alloc]init];
        commentManager = [[CommentManager alloc]init];
        collectManager = [[CollectManager alloc]init];
    }
    return self;
}

@end
