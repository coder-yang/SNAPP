//
//  GridView.h
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/14.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboEntity.h"

#define kMarginX 5
#define kMarginY 5
#define kCount 3
#define kImgWidth 70
#define kImgHeight 70
#define kMiddleImgWidth ((kScreenWith-20-((kCount-1)*kMarginX))/kCount)
#define kMiddleImgHeight kMiddleImgWidth


@interface GridView : UIView

//小图(微博列表页)
+ (float)getGridViewWidth:(WeiboEntity *)entity;

+ (float)getGridViewHeight:(WeiboEntity *)entity;

- (void)setSubViews:(WeiboEntity *)entity;

//中图(微博正文页)
+ (float)getDetailGridViewWidth:(WeiboEntity *)entity;

+ (float)getDetailGridViewHeight:(WeiboEntity *)entity;

- (void)setDetailSubViews:(WeiboEntity *)entity;

@end
