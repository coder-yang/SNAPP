//
//  GridView.h
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/14.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboEntity.h"

#define kImgWidth 70
#define kImgHeight 70
#define kMarginX 5
#define kMarginY 5
#define kCount 3

@interface GridView : UIView

+ (float)getGridViewWidth:(WeiboEntity *)entity;

+ (float)getGridViewHeight:(WeiboEntity *)entity;

- (void)setSubViews:(WeiboEntity *)entity;

@end
