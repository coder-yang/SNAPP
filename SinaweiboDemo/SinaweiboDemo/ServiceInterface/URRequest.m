//
//  URRequest.m
//  Urundc_IOS
//
//  Created by 杨方明 on 15/1/7.
//  Copyright (c) 2015年 urun. All rights reserved.
//

#import "URRequest.h"

@implementation URRequest

+ (instancetype)sharedURRequest {
    static URRequest *_shareURRequest = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _shareURRequest = [[self alloc] init];
    });
    
    return _shareURRequest;
}

//根据线程的tag获取当前线程
- (AFHTTPRequestOperation *)getCurrentOperationWithTag:(int)aTag
{
    AFHTTPRequestOperation *currentOperation = nil;
    for(AFHTTPRequestOperation *operation in [self.operationQueue operations])
    {
        NSInteger tag = [[operation.userInfo objectForKey:@"operationId"]integerValue];
        
        if(tag == aTag)
        {
            currentOperation = operation;
        }
    }
    
    return currentOperation;
}

//通过线程tag取消指定的线程操作
- (void)cancelRequestWithOperationId:(int)operationId
{
    AFHTTPRequestOperation *currentOperation = [self getCurrentOperationWithTag:operationId];
    if(!currentOperation.isCancelled)
    {
        [currentOperation cancel];
    }
}

@end
