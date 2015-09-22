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
        return entity.thumbnail_pic_w;
    }
    else
    {
        return kCount*(kImgWidth + kMarginX) - kMarginX;
    }
}

+ (float)getDetailGridViewWidth:(WeiboEntity *)entity
{
    if(entity.pic_urls.count == 1)
    {
        return entity.bmiddle_pic_w;
    }
    else
    {
        return kCount*(kMiddleImgWidth + kMarginX) - kMarginX;
    }
}

+ (float)getGridViewHeight:(WeiboEntity *)entity
{
    if(entity.pic_urls.count == 1)
    {
        return entity.thumbnail_pic_h + 10;
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

+ (float)getDetailGridViewHeight:(WeiboEntity *)entity
{
    if(entity.pic_urls.count == 1)
    {
        return entity.bmiddle_pic_h + 11;
    }
    if(entity.pic_urls.count > 1)
    {
        return ((entity.pic_urls.count/3)+((entity.pic_urls.count%3>0)?1:0))*(kMiddleImgWidth + kMarginY) - kMarginY + 11;
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
        NSInteger column;
        NSInteger line;
        if(entity.pic_urls.count == 4)
        {//4张图的时候两列展示
            column = i%2; //列
            line = i/2; //行
        }
        else
        {
            column = i%kCount; //列
            line = i/kCount; //行
        }
        
        NSURL *imgUrl = nil;
        if(entity.pic_urls.count > 1)
        {
            
            if([entity.pic_urls[i] objectForKey:@"original_pic"])
            {
                imgUrl = [NSURL URLWithString:[entity.pic_urls[i] objectForKey:@"original_pic"]];
            }
            else if([entity.pic_urls[i] objectForKey:@"bmiddle_pic"])
            {
                imgUrl = [NSURL URLWithString:[entity.pic_urls[i] objectForKey:@"bmiddle_pic"]];
            }
            else if([entity.pic_urls[i] objectForKey:@"thumbnail_pic"])
            {
                imgUrl = [NSURL URLWithString:[entity.pic_urls[i] objectForKey:@"thumbnail_pic"]];
            }
        }
        else
        {
            if(entity.bmiddle_pic)
            {
                imgUrl = [NSURL URLWithString:entity.bmiddle_pic];
            }
            else if(entity.thumbnail_pic)
            {
                imgUrl = [NSURL URLWithString:entity.thumbnail_pic];
            }
        }
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.backgroundColor = [UIColor colorWithHex:0xd4d2d2];
        
        if(entity.pic_urls.count == 1)
        {
            imgView.frame = CGRectMake(column * (kImgWidth + kMarginX), line * (kMarginY + kImgHeight), entity.thumbnail_pic_w, entity.thumbnail_pic_h);
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

- (void)setDetailSubViews:(WeiboEntity *)entity
{
    for(int i=0; i<entity.pic_urls.count; i++)
    {
        NSInteger column;
        NSInteger line;
        if(entity.pic_urls.count == 4)
        {//4张图的时候两列展示
            column = i%2; //列
            line = i/2; //行
        }
        else
        {
            column = i%kCount; //列
            line = i/kCount; //行
        }
        
        NSURL *imgUrl = nil;

        if([entity.pic_urls[i] objectForKey:@"bmiddle_pic"])
        {
            imgUrl = [NSURL URLWithString:[entity.pic_urls[i] objectForKey:@"bmiddle_pic"]];
        }
        else if([entity.pic_urls[i] objectForKey:@"thumbnail_pic"])
        {
            imgUrl = [NSURL URLWithString:[entity.pic_urls[i] objectForKey:@"thumbnail_pic"]];
        }
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.backgroundColor = [UIColor colorWithHex:0xd4d2d2];
        
        if(entity.pic_urls.count == 1)
        {
            imgUrl = [NSURL URLWithString:entity.bmiddle_pic];
            
            imgView.frame = CGRectMake(column * (kMiddleImgWidth + kMarginX), line * (kMarginY + kMiddleImgHeight), entity.bmiddle_pic_w, entity.bmiddle_pic_h);
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
            imgView.frame = CGRectMake(column * (kMiddleImgWidth + kMarginX), line * (kMarginY + kMiddleImgHeight), kMiddleImgWidth, kMiddleImgHeight);
            [imgView sd_setImageWithURL:imgUrl placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if(error)
                {
                    DLog(@"%@",error);
                }
                else
                {
                    if(image)
                    {
                        imgView.image = [imgView cutImageFromImage:image cutFrame:CGSizeMake(kMiddleImgWidth, kMiddleImgHeight)];
                    }
                }
            }];
        }
        
        [self addSubview:imgView];
    }
    self.frame = CGRectMake(0, 0, [GridView getDetailGridViewWidth:entity], [GridView getDetailGridViewHeight:entity]);
}

@end
