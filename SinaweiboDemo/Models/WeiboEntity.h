//
//  WeiboEntity.h
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/8.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface WeiboEntity : NSObject
@property(nonatomic, strong) NSString *created_at; //创建时间
@property(nonatomic, assign) NSInteger ID; //微博ID
@property(nonatomic, assign) NSInteger mid; //微博MID
@property(nonatomic, strong) NSString *idstr; //字符串型的微博ID
@property(nonatomic, strong) NSString *weiboText; //微博信息内容
@property(nonatomic, strong) NSString *source; //微博来源
@property(nonatomic, assign) BOOL favorited; //是否已收藏，true：是，false：否
@property(nonatomic, assign) BOOL truncated; //是否被截断，true：是，false：否
@property(nonatomic, strong) WeiboEntity *retweeted_status; //被转发的微博
@property(nonatomic, strong) NSString *thumbnail_pic;
@property(nonatomic, strong) NSString *bmiddle_pic;
@property(nonatomic, strong) NSString *original_pic;
@property(nonatomic, strong) User *user; //用户信息 （profile_image_url：用户头像地址（中图），50×50像素 screen_name：用户名， 详情参见新浪微博文档）
@property(nonatomic, assign) NSInteger reposts_count; //转发数
@property(nonatomic, assign) NSInteger comments_count; //评论数
@property(nonatomic, assign) NSInteger attitudes_count; //表态数（赞数）
@property(nonatomic, strong) NSString *visible;
@property(nonatomic, strong) NSArray *pic_urls;
@property(nonatomic, strong) NSArray *ad;

@property(nonatomic, assign) NSInteger imageWidth;
@property(nonatomic, assign) NSInteger imageHeight;

@end
