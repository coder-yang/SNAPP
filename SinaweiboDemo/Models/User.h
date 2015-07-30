//
//  User.h
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/14.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property(nonatomic, assign) NSInteger uid; //用户UID  (原id)
@property(nonatomic, strong) NSString *idstr; //字符串型的用户UID
@property(nonatomic, strong) NSString *screen_name; //用户昵称
@property(nonatomic, strong) NSString *name; //友好显示名称
@property(nonatomic, assign) NSInteger province; //用户所在省级ID
@property(nonatomic, assign) NSInteger city; //用户所在城市ID
@property(nonatomic, strong) NSString *location; //用户所在地
@property(nonatomic, strong) NSString *userDescription; //用户个人描述 (原description)
@property(nonatomic, strong) NSString *url; //用户博客地址
@property(nonatomic, strong) NSString *profile_image_url; //用户头像地址（中图），50×50像素
@property(nonatomic, strong) NSString *profile_url; //用户的微博统一URL地址
@property(nonatomic, strong) NSString *domain; //用户的个性化域名
@property(nonatomic, strong) NSString *weihao; //用户的微号
@property(nonatomic, strong) NSString *gender; //性别，m：男、f：女、n：未知
@property(nonatomic, assign) NSInteger followers_count; //粉丝数
@property(nonatomic, assign) NSInteger friends_count; //关注数
@property(nonatomic, assign) NSInteger statuses_count ; //微博数
@property(nonatomic, assign) NSInteger favourites_count; //收藏数
@property(nonatomic, strong) NSString *created_at; //用户创建（注册）时间
@property(nonatomic, assign) BOOL following; //暂未支持
@property(nonatomic, assign) BOOL allow_all_act_msg; //是否允许所有人给我发私信，true：是，false：否
@property(nonatomic, assign) BOOL geo_enabled; //是否允许标识用户的地理位置，true：是，false：否
@property(nonatomic, assign) BOOL verified; //是否是微博认证用户，即加V用户，true：是，false：否
@property(nonatomic, assign) NSInteger verified_type; //暂未支持
@property(nonatomic, strong) NSString *remark; //用户备注信息，只有在查询用户关系时才返回此字段
@property(nonatomic, assign) NSInteger allow_all_comment; 
@property(nonatomic, strong) NSString *avatar_large;
@property(nonatomic, strong) NSString *avatar_hd;
@property(nonatomic, strong) NSString *verified_reason;
@property(nonatomic, assign) NSInteger star;
@property(nonatomic, assign) BOOL follow_me;
@property(nonatomic, assign) NSInteger online_status;
@property(nonatomic, assign) NSInteger bi_followers_count;
@property(nonatomic, assign) NSInteger lang;

@end
