//
//  CommentManager.h
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/30.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseService.h"
#import "Comment.h"

@interface CommentManager : NSObject

- (void)requestCommentsList:(NSMutableDictionary *)params
                    success:(void (^)(NSMutableArray *, NSInteger))success
                       fail:(void(^)(NSString *))fail;

@end
