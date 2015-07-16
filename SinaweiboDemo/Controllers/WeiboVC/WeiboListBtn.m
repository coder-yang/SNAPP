//
//  WeiboListBtn.m
//  UrunNews
//
//  Created by 杨方明 on 15/6/9.
//  Copyright (c) 2015年 URUN. All rights reserved.
//

#import "WeiboListBtn.h"

@implementation WeiboListBtn
@synthesize leftImg;
@synthesize rightLb;

- (instancetype)init
{
    if(self = [super init])
    {
        leftImg = [[UIImageView alloc]initWithFrame:CGRectMake(kBtnWidth/2-15, (kBtnHeight-15)/2, 15, 15)];
        [self addSubview:leftImg];
        
        rightLb = [[UILabel alloc]initWithFrame:CGRectMake(kBtnWidth/2+5, 0, kBtnWidth/2, kBtnHeight)];
        rightLb.backgroundColor = [UIColor clearColor];
        rightLb.textColor = [UIColor grayColor];
        rightLb.font = SystemFont_10;
        [self addSubview:rightLb];
    }
    return self;
}

@end
