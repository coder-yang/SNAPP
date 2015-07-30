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
#import "UIImageView+Extend.h"

@implementation WeiboMannager

- (void)requestFriendTimeLine:(NSMutableDictionary *)params
                      success:(void (^)(NSMutableArray *, NSInteger))success
                         fail:(void (^)(NSString *))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",kServiceRoot,kRequestFriendTimeLine];
    
    if(![SystemSetting hasNetWork])
    {
        fail(NONetworkPrompt);
        return;
    }
    
    [[BaseService sharedBaseService] getRequestDataFromServiceWithUrl:url params:params operationId:kRequestFriendTimeLineTag success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *responseArr = [responseObject objectForKey:@"statuses"];
        NSInteger totalNumber = [[responseObject objectForKey:@"total_number"]integerValue];
        NSInteger totalPage = ceil((float)totalNumber/kPageCount);
        
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
                
                if(entity.pic_urls.count == 1)
                {
                    [UIImageView requestSizeFor:[NSURL URLWithString:[entity.pic_urls[0] objectForKey:@"thumbnail_pic"]] completion:^(NSURL *imgURL, CGSize size) {
                        
                        if(size.height <= 140)
                        {
                            entity.thumbnail_pic_w = (size.width > kScreenWith/2)?kScreenWith/2:size.width;
                            entity.thumbnail_pic_h = [SystemSetting getNewHeightFromSize:size newWidth:entity.thumbnail_pic_w];
                        }
                        else
                        {
                            entity.thumbnail_pic_w = (size.width > kScreenWith/2)?kScreenWith/2:size.width;
                            entity.thumbnail_pic_h = 140;
                        }
                        
                    }];
                    
                    [UIImageView requestSizeFor:[NSURL URLWithString:entity.bmiddle_pic] completion:^(NSURL *imgURL, CGSize size) {
                        
                        entity.bmiddle_pic_w = (size.width > kScreenWith-20)?kScreenWith-20:size.width;
                        entity.bmiddle_pic_h = [SystemSetting getNewHeightFromSize:size newWidth:kScreenWith-20];
                            
                    }];
                    
                    [UIImageView requestSizeFor:[NSURL URLWithString:entity.original_pic] completion:^(NSURL *imgURL, CGSize size) {
                        
                        entity.original_pic_w = (size.width > kScreenWith)?kScreenWith:size.width;
                        entity.original_pic_h = [SystemSetting getNewHeightFromSize:size newWidth:kScreenWith];
                            
                    }];
                }
                
                if(entity.retweeted_status.pic_urls.count == 1)
                {
                    [UIImageView requestSizeFor:[NSURL URLWithString:[entity.retweeted_status.pic_urls[0] objectForKey:@"thumbnail_pic"]]  completion:^(NSURL *imgURL, CGSize size) {
                        
                        if(size.height <= 140)
                        {
                            entity.retweeted_status.thumbnail_pic_w = (size.width > kScreenWith/2)?kScreenWith/2:size.width;
                            entity.retweeted_status.thumbnail_pic_h = [SystemSetting getNewHeightFromSize:size newWidth:entity.retweeted_status.thumbnail_pic_w];
                        }
                        else
                        {//长图高度大于140，设置高度为140
                            entity.retweeted_status.thumbnail_pic_w = [SystemSetting getNewWidthFromSize:size newHeight:140];
                            entity.retweeted_status.thumbnail_pic_h = 140;
                        }
                    }];
                    
                    [UIImageView requestSizeFor:[NSURL URLWithString:entity.retweeted_status.bmiddle_pic] completion:^(NSURL *imgURL, CGSize size) {
                        
                        entity.retweeted_status.bmiddle_pic_w = (size.width > kScreenWith-20)?kScreenWith-20:size.width;
                        entity.retweeted_status.bmiddle_pic_h = [SystemSetting getNewHeightFromSize:size newWidth:kScreenWith-20];
                    }];
                    
                    [UIImageView requestSizeFor:[NSURL URLWithString:entity.retweeted_status.original_pic] completion:^(NSURL *imgURL, CGSize size) {
                        entity.retweeted_status.original_pic_w = (size.width > kScreenWith)?kScreenWith:size.width;
                        entity.retweeted_status.original_pic_h = [SystemSetting getNewHeightFromSize:size newWidth:kScreenWith];
                    }];
                }
            }
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
