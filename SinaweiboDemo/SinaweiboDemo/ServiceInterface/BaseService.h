//
//  BaseService.h
//  DemoProject
//
//  Created by 杨方明 on 15/1/7.
//  Copyright (c) 2015年 urun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "NSMutableDictionary+Extend.h"

@interface BaseService : NSObject

@property (nonatomic, strong, readonly) AFHTTPRequestOperationManager *manager;

+ (instancetype)sharedBaseService;

/**
 *  基类网络请求接口(GET)
 *
 *  @param url    接口的服务器地址
 *  @param params 接口参数
 */
- (void)getRequestDataFromServiceWithUrl:(NSString *)url
                              params:(NSDictionary *)params
                         operationId:(OperationTag)operationId
                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  基类网络请求接口(POST)
 *
 *  @param url         接口的服务器地址
 *  @param params      接口参数
 *  @param operationId 请求标记
 *  @param success     请求成功块
 *  @param failure     请求失败块
 */
- (void)postRequestDataFromServiceWithUrl:(NSString *)url
                                  params:(NSDictionary *)params
                             operationId:(OperationTag)operationId
                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)getImageDataByImageUrl:(NSString *)url block:(void(^)(NSData *))resultBlock;

@end
