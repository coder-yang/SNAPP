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
#import "JSONKit.h"
#import "LoginViewController.h"

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

- (void)showPrompt:(NSString *)msg
{
    UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertview show];
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
    manager.requestSerializer.timeoutInterval = 60;
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    AFHTTPRequestOperation *currentOperation = [manager GET:urlStr
     parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

         NSData *responseData = responseObject;
         NSError *error = nil;
         NSDictionary *jsonDic = nil;

         NSString *jsonStr = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];

//         if([NSJSONSerialization isValidJSONObject:responseData])
//         {
             jsonDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
         
             DLog(@"responseData = %@",jsonStr);
             success(operation, jsonDic);
//         }
//         else
//         {
//             [self showPrompt:kDataError];
//         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         DLog(@"请求头-------+++++++++++++%@",manager.requestSerializer.HTTPRequestHeaders);
         DLog(@"Error: %@", error.userInfo);
         //            DLog(@"请求服务器头：%@",operation.requestString);
         DLog(@"error: 服务器返回头：%@",operation.responseSerializer.acceptableContentTypes);
         DLog(@"error: 服务器返内容：%@",operation.responseString);
         DLog(@"code= %ld",(long)operation.error.code);
         
         NSData *jsonData = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
         NSError *jsonError;
         if(jsonData)
         {
             NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
             /*
              * redirect_uri_mismatch        21322                   重定向地址不匹配
              * invalid_request              21323                   请求不合法
              * invalid_client               21324                   client_id或client_secret参数无效
              * invalid_grant                21325                   提供的Access Grant是无效的、过期的或已撤销的
              * unauthorized_client          21326                   客户端没有权限
              * expired_token                21327                   token过期
              * unsupported_grant_type       21328                   不支持的 GrantType
              * unsupported_response_type 	 21329                   不支持的 ResponseType
              * access_denied                21330                   用户或授权服务器拒绝授予数据访问权限
              * temporarily_unavailable      21331                   服务暂时无法访问
              * invalid_access_token         21332                   提供的accesstoken是无效的、过期的或已撤销的
              * appkey permission denied 	 21337                   应用权限不足
              */
             long errorCode = [[responseDic objectForKey:@"error_code"] longValue];
             switch (errorCode)
             {
                 case 21322:
                 {
                     [self showPrompt:@"重定向地址不匹配"];
                 }
                     break;
                     
                 case 21323:
                 {
                     [self showPrompt:@"请求不合法"];
                 }
                     break;
                     
                 case 21324:
                 {
                     [self showPrompt:@"client_id或client_secret参数无效"];
                 }
                     break;
                     
                 case 21325:
                 {
                     [self showPrompt:@"提供的Access Grant是无效的、过期的或已撤销的"];
                 }
                     break;
                     
                 case 21326:
                 {
                     [self showPrompt:@"客户端没有权限"];
                 }
                     break;
                
                 case 21327:
                 case 21332:
                 {
                      UIWindow *window = [UIApplication sharedApplication].keyWindow;
         
                      LoginViewController *loginVC = [[LoginViewController alloc]init];
                      window.rootViewController = loginVC;
                     
                     [self showPrompt:@"你的账号验证失败，请重新登录。"];
                 }
                     break;

                 case 21328:
                 {
                     [self showPrompt:@"不支持的 GrantType"];
                 }
                     break;
                     
                 case 21329:
                 {
                     [self showPrompt:@"不支持的 ResponseType"];
                 }
                     break;
                     
                 case 21330:
                 {
                     [self showPrompt:@"用户或授权服务器拒绝授予数据访问权限"];
                 }
                     break;
                     
                 case 21331:
                 {
                     [self showPrompt:@"服务暂时无法访问"];
                 }
                     break;
                     
                 case 21337:
                 {
                     [self showPrompt:@"应用权限不足"];
                 }
                     break;
                     
                 default:
                     break;
             }
         }
         
         if(operation.error.code == NSURLErrorCancelled)
         {//如果请求是手动取消的，直接返回，不处理
             return ;
         }
         
         if(operation.error.code == NSURLErrorTimedOut)
         {//请求超时处理
             
         }
         
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
            [self showPrompt:kDataError];
        }
        
        DLog(@"current isMainThread = %@",[NSThread isMainThread]?@"YES":@"NO");

        success(operation, jsonDic);
        
        
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
