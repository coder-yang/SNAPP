//
//  GridView.h
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/14.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kImgWidth 70
#define kImgHeight 70
#define kMarginX 5
#define kMarginY 5
#define kCount 3

@interface GridView : UIView

+ (float)getGridViewWidth;

+ (float)getGridViewHeight:(NSArray *)aImgs;

- (void)setSubViews:(NSArray *)aImgs;

@end
