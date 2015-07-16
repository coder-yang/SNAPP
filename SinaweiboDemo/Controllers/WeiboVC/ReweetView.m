//
//  ReweetView.m
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/15.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import "ReweetView.h"
#import "UIColor+Expand.h"
#import "NSString+Expand.h"

@implementation ReweetView

@synthesize reweetTextLb;

@synthesize gridView;

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor colorWithHex:0xf2f2f2];
        
        reweetTextLb = [[UILabel alloc]init];
        reweetTextLb.textColor = [UIColor grayColor];
        reweetTextLb.font = RetweetWeiboTextFont;
        reweetTextLb.numberOfLines = 0;
        reweetTextLb.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:reweetTextLb];
        
        gridView = [[GridView alloc]init];
        [self addSubview:gridView];
    }
    return self;
}

-(void)layoutWithEntity:(WeiboEntity *)entity
{
    NSString *retweetStr = [NSString stringWithFormat:@"@%@ %@", entity.retweeted_status.user.name,entity.retweeted_status.weiboText];
    float retweetHeight = [retweetStr getHeightByWidth:kScreenWith-20 font:RetweetWeiboTextFont];
    reweetTextLb.frame = CGRectMake(10, 10, kScreenWith-20, retweetHeight);
    reweetTextLb.text = retweetStr;
    
    [gridView setSubViews:entity.retweeted_status.pic_urls];
    gridView.frame = CGRectMake(10, ORIGINY(reweetTextLb)+HEIGHT(reweetTextLb)+10, [GridView getGridViewWidth], [GridView getGridViewHeight:entity.retweeted_status.pic_urls]);
}

@end
