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

@implementation GridView

+ (float)getGridViewWidth
{
    return kCount*(kImgWidth + kMarginX) - kMarginX;
}

+ (float)getGridViewHeight:(NSArray *)aImgs
{
    if(aImgs.count>0)
    {
        return ((aImgs.count/3)+((aImgs.count%3>0)?1:0))*(kImgHeight + kMarginY) - kMarginY + 10;
    }
    else
    {
        return 0.0;
    }
}

- (void)setSubViews:(NSArray *)aImgs
{
    for(int i=0; i<aImgs.count; i++)
    {
        NSInteger column = i%kCount; //列
        NSInteger line = i/kCount; //行
        NSLog(@"%ld行 %ld列",(long)line,(long)column);
        
        NSURL *imgUrl = [NSURL URLWithString:[aImgs[i] objectForKey:@"thumbnail_pic"]];
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.backgroundColor = [UIColor colorWithHex:0xf2f2f2];
        imgView.frame = CGRectMake(column * (kImgWidth + kMarginX), line * (kMarginY + kImgHeight), kImgWidth, kImgHeight);
        [imgView sd_setImageWithURL:imgUrl placeholderImage:nil];
        [self addSubview:imgView];
    }
    self.frame = CGRectMake(0, 0, [GridView getGridViewWidth], [GridView getGridViewHeight:aImgs]);
}

@end