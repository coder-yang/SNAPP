//
//  WeiboDetailCell.m
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/30.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import "WeiboDetailCell.h"
#import "UIColor+Expand.h"
#import "UIImageView+WebCache.h"
#import "NSString+Expand.h"

@implementation WeiboDetailCell
@synthesize userImg;
@synthesize userNameLb;
@synthesize createTimeLb;
@synthesize sourceLb;
@synthesize textLb;
@synthesize retweetView;
@synthesize gridView;
@synthesize reportBtn;
@synthesize commentBtn;
@synthesize praiseBtn;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UIView *spaceView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWith, 10)];
        spaceView.backgroundColor = [UIColor colorWithHex:0xf2f2f2];
        [self addSubview:spaceView];
        
        userImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, spaceView.y+spaceView.height+10, 30, 30)];
        [self addSubview:userImg];
        
        userNameLb = [[UILabel alloc]initWithFrame:CGRectMake(userImg.x+userImg.width+10, spaceView.y+spaceView.height+10, kScreenWith-100, 15)];
        userNameLb.backgroundColor = [UIColor clearColor];
        userNameLb.font = SystemFont_14;
        userNameLb.textColor = [UIColor blackColor];
        [self addSubview:userNameLb];
        
        createTimeLb = [[UILabel alloc]init];
        createTimeLb.backgroundColor = [UIColor clearColor];
        createTimeLb.textColor = [UIColor grayColor];
        createTimeLb.font = SystemFont_10;
        [self addSubview:createTimeLb];
        
        fromLabel = [[UILabel alloc]init];
        fromLabel.backgroundColor = [UIColor clearColor];
        fromLabel.textColor = [UIColor grayColor];
        fromLabel.text = @"来自";
        fromLabel.font = SystemFont_10;
        [self addSubview:fromLabel];
        
        sourceLb = [[UILabel alloc]init];
        sourceLb.backgroundColor = [UIColor clearColor];
        sourceLb.textColor = [UIColor grayColor];
        sourceLb.font = SystemFont_10;
        [self addSubview:sourceLb];
        
        textLb = [[UILabel alloc]init];
        textLb.backgroundColor = [UIColor clearColor];
        textLb.font = [UIFont systemFontOfSize:14];
        textLb.textColor = [UIColor blackColor];
        textLb.numberOfLines = 0;
        textLb.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:textLb];
        
        retweetView = [[ReweetView alloc]init];
        [self addSubview:retweetView];
        
        reportBtn = [[ReweetViewBottomBtn alloc]init];
        [self addSubview:reportBtn];
        
        commentBtn = [[ReweetViewBottomBtn alloc]init];
        [self addSubview:commentBtn];
        
        praiseBtn = [[ReweetViewBottomBtn alloc]init];
        [self addSubview:praiseBtn];
        
        spaceLine = [[UIImageView alloc]init];
        spaceLine.image = [UIImage imageNamed:@"icon_horizontal_line"];
        [self addSubview:spaceLine];
    }
    return self;
}

-(void)layoutCellWithEntity:(WeiboEntity *)entity
{
    [userImg sd_setImageWithURL:[NSURL URLWithString: entity.user.profile_image_url] placeholderImage:[UIImage imageNamed:@"icon_hardImg"]];
    
    float createTimeWidth = [entity.created_at getWidthByHeight:10 font:SystemFont_10];
    float fromLabelWidth = [fromLabel.text getWidthByHeight:10 font:SystemFont_10];
    float sourceWidth = [entity.source getWidthByHeight:10 font:SystemFont_10];
    
    createTimeLb.frame = CGRectMake(userNameLb.x, userNameLb.y+userNameLb.height+5, createTimeWidth, 10);
    fromLabel.frame = CGRectMake(createTimeLb.x+createTimeLb.width+5, createTimeLb.y, fromLabelWidth, 10);
    sourceLb.frame = CGRectMake(fromLabel.x+fromLabel.width+5, fromLabel.y, sourceWidth, 10);
    
    userNameLb.text = entity.user.screen_name;
    createTimeLb.text = entity.created_at;
    sourceLb.text = entity.source;
    
    float textHeight = [entity.weiboText getHeightByWidth:kScreenWith-20 font:WeiboTextFont];
    textLb.frame = CGRectMake(10, userImg.y+userImg.height+10, kScreenWith-20, textHeight);
    textLb.font = WeiboTextFont;
    textLb.text = entity.weiboText;
    
    if(entity.retweeted_status)
    {
        if(!retweetView)
        {
            retweetView = [[ReweetView alloc]init];
            [self addSubview:retweetView];
        }
        
        gridView.frame = CGRectMake(10, textLb.y+textLb.height+10, 0, 0);
        
        [retweetView layoutWithEntity:entity isDetail:YES];
        retweetView.frame = CGRectMake(0, textLb.y+textLb.height+10, kScreenWith, retweetView.reweetTextLb.height+20+[GridView getDetailGridViewHeight:entity.retweeted_status]+20);
        spaceLine.frame = CGRectMake(0, retweetView.y+retweetView.height+0.5, kScreenWith, 0.5);
    }
    else
    {
        if(!gridView)
        {
            gridView = [[GridView alloc]init];
            [self addSubview:gridView];
        }
        
        [gridView setDetailSubViews:entity];
        gridView.frame = CGRectMake(10, textLb.y+textLb.height+10, [GridView getDetailGridViewWidth:entity], [GridView getDetailGridViewHeight:entity]);
        
        spaceLine.frame = CGRectMake(0, gridView.y+gridView.height+0.5, kScreenWith, 0.5);
    }
    
    if(entity.retweeted_status)
    {
        NSString *reportNumStr = [NSString stringWithFormat:@"%lu",entity.retweeted_status.reposts_count];
        NSString *commentNumStr = [NSString stringWithFormat:@"%lu",entity.retweeted_status.comments_count];
        NSString *praiseNumStr = [NSString stringWithFormat:@"%lu",entity.retweeted_status.attitudes_count];
        
        [reportBtn setImage:[UIImage imageNamed:@"icon_share"] rightLb:reportNumStr];
        [commentBtn setImage:[UIImage imageNamed:@"icon_write"] rightLb:commentNumStr];
        [praiseBtn setImage:[UIImage imageNamed:@"icon_parise"] rightLb:praiseNumStr];
        
        praiseBtn.x = kScreenWith-10-praiseBtn.width;
        praiseBtn.y = spaceLine.y+spaceLine.height-31;
        commentBtn.x = kScreenWith-praiseBtn.width-commentBtn.width-5;
        commentBtn.y = praiseBtn.y;
        reportBtn.x = kScreenWith-praiseBtn.width-commentBtn.width-reportBtn.width;
        reportBtn.y = commentBtn.y;
    }
}

@end
