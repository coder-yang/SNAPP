//
//  WeiboEntity.h
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/8.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiboEntity : NSObject
@property(nonatomic, strong) NSString *created_at; //创建时间
@property(nonatomic, strong) NSNumber *weiboid;
@property(nonatomic, strong) NSNumber *mid;
@property(nonatomic, strong) NSString *idstr;
@property(nonatomic, strong) NSString *text; //微博信息内容
@property(nonatomic, strong) NSString *source; //微博来源
@property(nonatomic, strong) NSNumber *favorited;
@property(nonatomic, strong) NSNumber *truncated;
@property(nonatomic, strong) NSString *thumbnail_pic;
@property(nonatomic, strong) NSString *bmiddle_pic;
@property(nonatomic, strong) NSString *original_pic;
@property(nonatomic, strong) NSDictionary *user; //用户信息 （profile_image_url：用户头像地址（中图），50×50像素 screen_name：用户名， 详情参见新浪微博文档）
@property(nonatomic, strong) NSNumber *reposts_count; //转发数
@property(nonatomic, strong) NSNumber *comments_count; //评论数
@property(nonatomic, strong) NSNumber *attitudes_count; //表态数（赞数）
@property(nonatomic, strong) NSString *visible;
@property(nonatomic, strong) NSArray *pic_urls;
@property(nonatomic, strong) NSArray *ad;

@end
