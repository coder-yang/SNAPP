//
//  CommentHeadBtn.m
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/30.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import "CommentHeadBtn.h"
#import "NSString+Expand.h"

@implementation CommentHeadBtn
@synthesize leftLb;
@synthesize rightLb;

- (instancetype)init
{
    if(self = [super init])
    {
        leftLb = [[UILabel alloc]init];
        leftLb.backgroundColor = [UIColor clearColor];
        leftLb.font = SystemFont_14;
        leftLb.textColor = [UIColor blackColor];
        [self addSubview:leftLb];
        
        rightLb = [[UILabel alloc]init];
        rightLb.backgroundColor = [UIColor clearColor];
        rightLb.font = SystemFont_14;
        rightLb.textColor = [UIColor blackColor];
        [self addSubview:rightLb];
    }
    return self;
}

- (void)setLeftText:(NSString *)leftText rightText:(NSString *)rightText
{
    float leftTextWidth = [leftText getWidthByHeight:30 font:SystemFont_14];
    float rightTextWidth = [rightText getWidthByHeight:30 font:SystemFont_14];
    
    leftLb.text = leftText;
    rightLb.text = rightText;
    
    leftLb.frame = CGRectMake(10, 0, leftTextWidth, 30);
    rightLb.frame = CGRectMake(leftLb.x+leftLb.width+5, 0, rightTextWidth, 30);
    
    self.frame = CGRectMake(0, 0, leftTextWidth+rightTextWidth+20, 30);
}

- (void)setTextColor:(UIColor *)color
{
    leftLb.textColor = color;
    rightLb.textColor = color;
}

@end
