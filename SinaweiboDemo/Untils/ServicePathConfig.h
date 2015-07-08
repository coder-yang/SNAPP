//
//  ServicePathConfig.h
//  Urundc_IOS
//
//  Created by 杨方明 on 15/1/8.
//  Copyright (c) 2015年 urun. All rights reserved.
//

//请求操作的标识，用来获取指定的请求
typedef enum
{
    kRequestLoginTag,
}OperationTag;

//生产环境
#define kServiceRoot @"http://123.182.227.41:8121" //外网发布服务器 (登录专用)

/**
 *  用户检查
 */
#define kRequestRegiterCheckName @"/DataCenter/CustomerService/CheckName"

