//
//  UIImageView+Extend.m
//  Kitchen
//
//  Created by 杨方明 on 15/3/27.
//  Copyright (c) 2015年 rurn. All rights reserved.
//

#import "UIImageView+Extend.h"

@implementation UIImageView (Extend)

+ (float)getHeightByNewWidth:(float)newWidth image:(UIImage *)image
{
    float newHeight = newWidth * image.size.height/image.size.width;
    return newHeight;
}

+ (float)getWidthByNewHeight:(float)newHeight image:(UIImage *)image
{
    float newWidth = newHeight * image.size.width/image.size.height;
    return newWidth;
}

- (UIImage *)cutImageFromImage:(UIImage *)aImage cutFrame:(CGSize)curRect
{
    CGRect rect;
    //要裁剪的图片区域，按照原图的像素大小来，超过原图大小的边自动适配
    //
    if(aImage.size.width>=aImage.size.height)
    {
        rect =  CGRectMake(0, 0, aImage.size.height, aImage.size.width*curRect.width/curRect.height);
    }
    else
    {
        rect =  CGRectMake(0, 0, aImage.size.width, aImage.size.width*curRect.height/curRect.width);
    }
    CGImageRef cgimg = CGImageCreateWithImageInRect([aImage CGImage], rect);
    UIImage *image = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);//用完一定要释放，否则内存泄露
    return image;
}

@end
