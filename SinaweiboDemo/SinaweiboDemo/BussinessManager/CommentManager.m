//
//  CommentManager.m
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/30.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import "CommentManager.h"
#import "MJExtension.h"
#import "NSString+Expand.h"

@implementation CommentManager

-(void)requestCommentsList:(NSMutableDictionary *)params
                   success:(void (^)(NSMutableArray *, NSInteger))success
                      fail:(void (^)(NSString *))fail
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kServiceRoot,kRequestCommentsList];
    
    if(![SystemSetting hasNetWork])
    {
        fail(NONetworkPrompt);
        return;
    }
    
    [[BaseService sharedBaseService] getRequestDataFromServiceWithUrl:url params:params operationId:kRequestCommentsListTag success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *responseArr = [responseObject objectForKey:@"comments"];
        NSInteger totalNumber = [[responseObject objectForKey:@"total_number"]integerValue];
        NSInteger totalPage = ceil((float)totalNumber/kPageCount);
        
//        //数组转模型数组
        [Comment setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"ID" : @"id",
                     };
        }];
        
        //数组里面的字典转模型
        [Comment setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"status": @"WeiboEntity",
                     @"user" : @"User",
                     };
        }];
        
        NSError *error = nil;
        NSMutableArray *resultArr = [Comment objectArrayWithKeyValuesArray:responseArr error:&error];
        if(error)
        {
            DLog(@"%@",error);
        }
        
        for(Comment *comment in resultArr)
        {
            comment.created_at = [self formatDate:comment.created_at];
        }
        
        success(resultArr,totalPage);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSString *errorMsg = nil;
        
        if(operation.error.code == NSURLErrorCancelled)
        {//如果请求是手动取消的，直接返回，不处理
            return ;
        }
        
        if(operation.error.code == NSURLErrorTimedOut)
        {//请求超时处理
            errorMsg = kTimeOutPrompt;
        }
        else
        {
            errorMsg = kLoadFail;
        }
        
        fail(errorMsg);
    }];
}

- (NSString *)formatDate:(NSString *)time
{
//    NSString *resultStr;
    NSDate *createDate = [time dateValueWithFormatString:@"EEE MMM dd HH:mm:ss Z yyyy"];
    NSString *timeStr = [NSString stringFromDate:createDate format:@"MM-dd HH:mm"];
//    NSString *curTimeStr = [NSString stringFromDate:[NSDate date] format:@"yyyy/MM/dd HH:mm:ss"];
//    resultStr = [NSString getTimeInterval:timeStr currentTime:curTimeStr];
    return timeStr;
}

@end
