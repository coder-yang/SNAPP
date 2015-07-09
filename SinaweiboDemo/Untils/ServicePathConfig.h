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
    kRequestFriendTimeLineTag,
}OperationTag;

//生产环境
#define kServiceRoot @"https://api.weibo.com/2/" //微博服务器

/**
 *  获取当前登录用户及其所关注用户的最新微博的ID
 * HTTP请求方式 GET
 * param
 * 参数              必选    类型及范围    说明
 * source           false 	string      采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
 * access_token 	false 	string      采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 * since_id         false 	int64       若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 * max_id           false 	int64       若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 * count            false 	int         单页返回的记录条数，最大不超过100，默认为20。
 * page             false 	int         返回结果的页码，默认为1。
 * base_app         false 	int         是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
 * feature          false 	int         过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0。
 */
#define kRequestFriendTimeLine @"statuses/friends_timeline.json"

//#define kRequestFriendTimeLine @"statuses/public_timeline.json"

