//
//  ReweetViewBottomBtn.m
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/30.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import "ReweetViewBottomBtn.h"
#import "NSString+Expand.h"

@implementation ReweetViewBottomBtn
@synthesize leftImgView;
@synthesize rightLb;

- (instancetype)init
{
    if(self = [super init])
    {
        leftImgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 10, 10)];
        [self addSubview:leftImgView];
        
        rightLb = [[UILabel alloc]init];
        rightLb.backgroundColor = [UIColor clearColor];
        rightLb.font = SystemFont_10;
        rightLb.textColor = [UIColor grayColor];
        [self addSubview:rightLb];
    }
    return self;
}

- (void)setImage:(UIImage *)image rightLb:(NSString *)numStr
{
    leftImgView.image = image;
    
    float rightLbWidth = [numStr getWidthByHeight:30 font:SystemFont_10];
    rightLb.frame = CGRectMake(leftImgView.x+leftImgView.width+5, 0, rightLbWidth, 30);
    rightLb.text = numStr;
    
    self.frame = CGRectMake(0, 0, 30+rightLbWidth, 30);
}

@end
