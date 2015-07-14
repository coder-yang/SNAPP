//
//  WeiboMannager.m
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/8.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import "WeiboMannager.h"
#import "BaseService.h"
#import "NSString+Expand.h"
#import "MJExtension.h"

@implementation WeiboMannager

- (void)requestFriendTimeLine:(NSMutableDictionary *)params
                      success:(void (^)(NSMutableArray *))success
                         fail:(void (^)(NSString *))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",kServiceRoot,kRequestFriendTimeLine];
    
    [[BaseService sharedBaseService] getRequestDataFromServiceWithUrl:url params:params operationId:kRequestFriendTimeLineTag success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *responseArr = [responseObject objectForKey:@"statuses"];
        
        //数组转模型数组
        [WeiboEntity setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"ID" : @"id",
                     @"weiboText" : @"text",
                     };
        }];
        
        //数组里面的字典转模型
        [WeiboEntity setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"user" : @"User",
                     };
        }];
        
        NSError *error = nil;
        NSMutableArray *resultArr = [WeiboEntity objectArrayWithKeyValuesArray:responseArr error:&error];
        if(error)
        {
            DLog(@"%@",error);
        }
        
        WeiboEntity *weiboEntity = resultArr[0];
        User *user = weiboEntity.user;
        NSLog(@"%@",user.name);
        
        success(resultArr);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        fail(kLoadFail);
        
    }];
}

@end
