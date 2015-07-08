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

@implementation WeiboMannager

- (void)requestFriendTimeLine:(NSMutableDictionary *)params
                      success:(void (^)(NSMutableArray *))success
                         fail:(void (^)(NSString *))fail
{
    NSString *url = [NSString stringWithFormat:@"%@%@",kServiceRoot,kRequestFriendTimeLine];
    
    [[BaseService sharedBaseService] getRequestDataFromServiceWithUrl:url params:params operationId:kRequestFriendTimeLineTag success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *resultArr = [NSMutableArray array];
        NSMutableArray *responseArr = [responseObject objectForKey:@"statuses"];
        
        for(NSDictionary *dic in responseArr)
        {
            WeiboEntity *entity = [[WeiboEntity alloc]init];
            entity.created_at = CoverNull([dic objectForKey:@"created_at"]); //"created_at" = "Sun Dec 21 05:37:48 +0800 2014";
            NSDate *createDate = [entity.created_at dateValueWithFormatString:@"EEE MMM dd HH:mm:ss Z yyyy"];
            NSString *timeStr = [NSString stringFromDate:createDate format:@"yyyy/MM/dd HH:mm:ss"];
            NSString *curTimeStr = [NSString stringFromDate:[NSDate date] format:@"yyyy/MM/dd HH:mm:ss"];
            
            entity.created_at = [NSString getTimeInterval:timeStr currentTime:curTimeStr];
            
            entity.weiboid = CoverNull([dic objectForKey:@"weiboid"]);
            entity.mid = CoverNull([dic objectForKey:@"mid"]);
            entity.idstr = CoverNull([dic objectForKey:@"idstr"]);
            entity.text = CoverNull([dic objectForKey:@"text"]);
            entity.source = CoverNull([dic objectForKey:@"source"]);
            NSArray *tempArr1 = [entity.source componentsSeparatedByString:@">"];
            NSArray *tempArr2;
            if(tempArr1.count > 2)
            {
                tempArr2 = [tempArr1[1] componentsSeparatedByString:@"<"];
                entity.source = tempArr2[0];
            }
            else
            {
                entity.source = @"";
            }
            
            
            entity.favorited = CoverNull([dic objectForKey:@"favorited"]);
            entity.truncated = CoverNull([dic objectForKey:@"truncated"]);
            entity.thumbnail_pic = CoverNull([dic objectForKey:@"thumbnail_pic"]);
            entity.bmiddle_pic = CoverNull([dic objectForKey:@"bmiddle_pic"]);
            entity.user = CoverNull([dic objectForKey:@"user"]);
            entity.reposts_count = CoverNull([dic objectForKey:@"reposts_count"]);
            entity.comments_count = CoverNull([dic objectForKey:@"comments_count"]);
            entity.attitudes_count = CoverNull([dic objectForKey:@"attitudes_count"]);
            entity.visible = CoverNull([dic objectForKey:@"visible"]);
            entity.pic_urls = CoverNull([dic objectForKey:@"pic_urls"]);
            entity.ad = CoverNull([dic objectForKey:@"ad"]);
            
            [resultArr addObject:entity];
        }
        
        success(resultArr);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        fail(kLoadFail);
        
    }];
}

@end
