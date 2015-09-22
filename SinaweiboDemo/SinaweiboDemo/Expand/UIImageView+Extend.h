//
//  UIImageView+Extend.h
//  Kitchen
//
//  Created by 杨方明 on 15/3/27.
//  Copyright (c) 2015年 rurn. All rights reserved.
//

#import <UIKit/UIKit.h>

//http://stackoverflow.com/questions/7164435/remote-image-size-without-downloading

typedef void (^UIImageSizeRequestCompleted) (NSURL* imgURL, CGSize size);

@interface UIImageView (Extend)

//获取图片的真实尺寸
+ (void) requestSizeFor: (NSURL*) imgURL completion: (UIImageSizeRequestCompleted) completion;

+ (float)getHeightByNewWidth:(float)newWidth image:(UIImage *)image;

+ (float)getWidthByNewHeight:(float)newHeight image:(UIImage *)image;

- (UIImage *)cutImageFromImage:(UIImage *)aImage cutFrame:(CGSize)curRect;

@end
