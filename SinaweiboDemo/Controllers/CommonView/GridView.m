//
//  GridView.m
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/14.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import "GridView.h"
#import "UIImageView+WebCache.h"
#import "UIColor+Expand.h"
#import "UIImageView+Extend.h"

@implementation GridView

+ (float)getGridViewWidth:(WeiboEntity *)entity
{
    if(entity.pic_urls.count == 1)
    {
        return entity.imageWidth;
    }
    else
    {
        return kCount*(kImgWidth + kMarginX) - kMarginX;
    }
}

+ (float)getGridViewHeight:(WeiboEntity *)entity
{
    if(entity.pic_urls.count == 1)
    {
        NSLog(@"%@",entity.weiboText);
        NSLog(@"%ld",(long)entity.imageHeight);
        return entity.imageHeight;
    }
    if(entity.pic_urls.count > 1)
    {
        return ((entity.pic_urls.count/3)+((entity.pic_urls.count%3>0)?1:0))*(kImgHeight + kMarginY) - kMarginY + 10;
    }
    else
    {
        return 0.0;
    }
}

- (void)setSubViews:(WeiboEntity *)entity
{
    for(int i=0; i<entity.pic_urls.count; i++)
    {
        NSInteger column = i%kCount; //列
        NSInteger line = i/kCount; //行
        
        NSURL *imgUrl = nil;
        if([entity.pic_urls[i] objectForKey:@"thumbnail_pic"])
        {
            imgUrl = [NSURL URLWithString:[entity.pic_urls[i] objectForKey:@"thumbnail_pic"]];
        }
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.backgroundColor = [UIColor colorWithHex:0xf2f2f2];
        
        if(entity.pic_urls.count == 1)
        {
            imgView.frame = CGRectMake(column * (kImgWidth + kMarginX), line * (kMarginY + kImgHeight), entity.imageWidth, entity.imageHeight);
            [imgView sd_setImageWithURL:imgUrl placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if(error)
                {
                    DLog(@"%@",error);
                }
                else
                {
                    if(image)
                    {
                        imgView.image = image;
                    }
                }
            }];
        }
        else
        {
            imgView.frame = CGRectMake(column * (kImgWidth + kMarginX), line * (kMarginY + kImgHeight), kImgWidth, kImgHeight);
            [imgView sd_setImageWithURL:imgUrl placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if(error)
                {
                    DLog(@"%@",error);
                }
                else
                {
                    if(image)
                    {
                        imgView.image = [imgView cutImageFromImage:image cutFrame:CGSizeMake(kImgWidth, kImgHeight)];
                    }
                }
            }];
        }

        [self addSubview:imgView];
    }
    self.frame = CGRectMake(0, 0, [GridView getGridViewWidth:entity], [GridView getGridViewHeight:entity]);
}

@end
