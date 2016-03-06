//
//  DATManager.m
//  Urundc_IOS
//
//  Created by 杨方明 on 15/1/13.
//  Copyright (c) 2015年 urun. All rights reserved.
//

#import "DATManager.h"

@implementation DATManager


+ (instancetype)sharedDATManager
{
    static DATManager *_shareDATManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _shareDATManager = [[self alloc] init];
    });
    
    return _shareDATManager;
}

- (instancetype)init
{
    if(self = [super init])
    {
        //创建数据库
        [[BaseDAT sharedBaseDAT] createDataBase];
    }
    return self;
}

- (void)initDB
{
    
}


@end
