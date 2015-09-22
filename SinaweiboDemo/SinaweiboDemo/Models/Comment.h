//
//  Comment.h
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/30.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "WeiboEntity.h"

@interface Comment : NSObject

@property (nonatomic, strong) NSString *created_at; //评论创建时间
@property (nonatomic, assign) NSInteger ID;  //评论的ID
@property (nonatomic, strong) NSString *text; //评论的内容
@property (nonatomic, strong) NSString *source; //评论的来源
@property (nonatomic, strong) User *user; //评论作者的用户信息字段
@property (nonatomic, strong) NSString *mid; //评论的MID
@property (nonatomic, strong) NSString *idstr; //字符串型的评论ID
@property (nonatomic, strong) WeiboEntity *status; //评论的微博信息字段
@property (nonatomic, strong) Comment *reply_comment; //评论来源评论，当本评论属于对另一评论的回复时返回此字段

@end
