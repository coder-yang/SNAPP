//
//  WeiboMannager.h
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/8.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboEntity.h"

@interface WeiboMannager : NSObject

- (void)requestFriendTimeLine:(NSMutableDictionary *)params
                      success:(void (^)(NSMutableArray *))success
                         fail:(void(^)(NSString *))fail;

@end
