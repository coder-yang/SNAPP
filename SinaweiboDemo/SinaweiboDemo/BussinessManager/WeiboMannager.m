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
                     @"retweeted_status": @"WeiboEntity",
                     @"user" : @"User",
                     };
        }];
        
        NSError *error = nil;
        NSMutableArray *resultArr = [WeiboEntity objectArrayWithKeyValuesArray:responseArr error:&error];
        if(error)
        {
            DLog(@"%@",error);
        }
        else
        {
            for(WeiboEntity *entity in resultArr)
            {
                entity.created_at = [self formatDate:entity.created_at];
                entity.source = [self formatSouce:entity.source];
                
                WeiboEntity *reweetedEntity = entity.retweeted_status;
                reweetedEntity.created_at = [self formatDate:reweetedEntity.created_at];
                reweetedEntity.source = [self formatDate:reweetedEntity.source];
            }
        }
        
        success(resultArr);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if(operation.error.code == NSURLErrorCancelled)
        {//如果请求是手动取消的，直接返回，不处理
            return ;
        }
        
        if(operation.error.code == NSURLErrorTimedOut)
        {//请求超时处理
            
        }
        
        fail(kLoadFail);
        
    }];
}

- (NSString *)formatDate:(NSString *)time
{
    NSString *resultStr;
    NSDate *createDate = [time dateValueWithFormatString:@"EEE MMM dd HH:mm:ss Z yyyy"];
    NSString *timeStr = [NSString stringFromDate:createDate format:@"yyyy/MM/dd HH:mm:ss"];
    NSString *curTimeStr = [NSString stringFromDate:[NSDate date] format:@"yyyy/MM/dd HH:mm:ss"];
    resultStr = [NSString getTimeInterval:timeStr currentTime:curTimeStr];
    return resultStr;
}

- (NSString *)formatSouce:(NSString *)source
{
    NSString *resultStr;
    NSArray *tempArr1 = [source componentsSeparatedByString:@">"];
    NSArray *tempArr2;
    if(tempArr1.count > 2)
    {
        tempArr2 = [tempArr1[1] componentsSeparatedByString:@"<"];
        resultStr = tempArr2[0];
    }
    else
    {
        resultStr = @"";
    }
    return resultStr;
}

@end
