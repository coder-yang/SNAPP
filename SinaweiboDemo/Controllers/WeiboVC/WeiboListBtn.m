//
//  WeiboListBtn.m
//  UrunNews
//
//  Created by 杨方明 on 15/6/9.
//  Copyright (c) 2015年 URUN. All rights reserved.
//

#import "WeiboListBtn.h"
#define kBtnWidth ((kScreenWith-2)/3)

@implementation WeiboListBtn
@synthesize leftImg;
@synthesize rightLb;

- (instancetype)init
{
    if(self = [super init])
    {
        leftImg = [[UIImageView alloc]initWithFrame:CGRectMake(kBtnWidth/2-20, 5, 20, 20)];
        [self addSubview:leftImg];
        
        rightLb = [[UILabel alloc]initWithFrame:CGRectMake(kBtnWidth/2+10, 0, kBtnWidth/2, 30)];
        rightLb.backgroundColor = [UIColor clearColor];
        rightLb.textColor = [UIColor grayColor];
        rightLb.font = SystemFont_14;
        [self addSubview:rightLb];
    }
    return self;
}

@end
