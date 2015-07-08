//
//  BaseService.m
//  DemoProject
//
//  Created by 杨方明 on 15/1/7.
//  Copyright (c) 2015年 urun. All rights reserved.
//

#import "BaseService.h"
#import "URRequest.h"
#import "NSDictionary+Extend.h"
#import "AppDelegate.h"

@implementation BaseService
@synthesize manager;

+ (instancetype)sharedBaseService {
    static BaseService *_shareBaseService = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _shareBaseService = [[self alloc] init];
    });
    
    return _shareBaseService;
}

-(void)getRequestDataFromServiceWithUrl:(NSString *)url
                              params:(NSDictionary *)params
                         operationId:(OperationTag)operationId
                             success:(void (^)(AFHTTPRequestOperation *, id))success
                             failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    //转成utf8编码
    NSString *paramsStr = [params urlEncodedString];
    NSString *urlStr = [NSString stringWithFormat:@"%@?%@",url,paramsStr];
    
    DLog(@"urlPath = %@", urlStr);

    manager = [URRequest sharedURRequest];
    manager.requestSerializer.timeoutInterval = 10;
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
//    [manager.requestSerializer setValue:@"text/html; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
    [NSURLCache setSharedURLCache:sharedCache];
    
    AFHTTPRequestOperation *currentOperation = [manager GET:urlStr
     parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
         NSDictionary *jsonDic = (NSDictionary *)responseObject;
         
         NSError *error;
         NSData *jsonData = nil;
         if([NSJSONSerialization isValidJSONObject:responseObject])
         {
             jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:&error];
             NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
             
             DLog(@"responseData = %@",jsonStr);
         }
         else
         {
             DLog(@"无效的json数据");
         }
         
         success(operation, jsonDic);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         DLog(@"请求头-------+++++++++++++%@",manager.requestSerializer.HTTPRequestHeaders);
         DLog(@"Error: %@", error);
         //            DLog(@"请求服务器头：%@",operation.requestString);
         DLog(@"error: 服务器返回头：%@",operation.responseSerializer.acceptableContentTypes);
         DLog(@"error: 服务器返内容：%@",operation.responseString);
         DLog(@"code= %ld",(long)operation.error.code);
         
         if(operation.error.code == NSURLErrorCancelled)
         {//如果请求是手动取消的，直接返回，不处理
             return ;
         }
         
//         if(operation.error.code == NSURLErrorTimedOut)
//         {//请求超时处理
//             
//         }
         
         failure(operation, error);
         
     }];
    [currentOperation setUserInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:operationId] forKey:@"operationId"]];
}

-(void)postRequestDataFromServiceWithUrl:(NSString *)url
                                  params:(NSDictionary *)params
                             operationId:(OperationTag)operationId
                                 success:(void (^)(AFHTTPRequestOperation *, id))success
                                 failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    manager = [URRequest sharedURRequest];
    
    AFHTTPRequestOperation *currentOperation = [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *jsonDic = (NSDictionary *)responseObject;
        
        NSError *error = nil;
        NSData *jsonData = nil;
        DLog(@"*********************** 华丽的分割线 ***********************");
        DLog(@"urlPath = %@", url);

        if([NSJSONSerialization isValidJSONObject:responseObject])
        {
            jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:&error];
            NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            DLog(@"responseData = %@",jsonStr);
        }
        else
        {
            DLog(@"无效的json数据");
        }
        
        success(operation, jsonDic);
        
        DLog(@"current isMainThread = %@",[NSThread isMainThread]?@"YES":@"NO");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"-------+++++++++++++%@",manager.requestSerializer.HTTPRequestHeaders);
        DLog(@"Error: %@", error);
        //            DLog(@"请求服务器头：%@",operation.requestString);
        DLog(@"error: 服务器返回头：%@",operation.responseSerializer.acceptableContentTypes);
        DLog(@"error: 服务器返内容：%@",operation.responseString);
        
        failure(operation, error);
        
    }];
    [currentOperation setUserInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:operationId] forKey:@"operationId"]];
}

- (void)getImageDataByImageUrl:(NSString *)url block:(void(^)(NSData *))resultBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:url]];
        
        dispatch_async(dispatch_get_main_queue(), ^{

            if(data)
            {
                resultBlock(data);
            }
            
        });
    });
}

@end
