//
//  URRequest.h
//  Urundc_IOS
//
//  Created by 杨方明 on 15/1/7.
//  Copyright (c) 2015年 urun. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface URRequest : AFHTTPRequestOperationManager

+ (instancetype)sharedURRequest;

/**
 *  从请求队列中获取指定的请求
 *
 *  @param aTag 用来标记当前请求对象
 *
 *  @return 指定请求对象
 */
- (AFHTTPRequestOperation *)getCurrentOperationWithTag:(int)aTag;

/**
 *   取消指定请求
 *
 *  @param operationId 当前请求对象的id
 */
- (void)cancelRequestWithOperationId:(int)operationId;

@end
