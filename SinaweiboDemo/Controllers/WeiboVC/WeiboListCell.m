//
//  WeiboListCell.m
//  UrunNews
//
//  Created by 杨方明 on 15/6/9.
//  Copyright (c) 2015年 URUN. All rights reserved.
//

#import "WeiboListCell.h"
#import "UIImageView+WebCache.h"
#import "UIColor+Expand.h"

@implementation WeiboListCell
@synthesize userImg;
@synthesize userNameLb;
@synthesize createTimeLb;
@synthesize sourceLb;
@synthesize textLb;
@synthesize retweetView;
@synthesize gridView;
@synthesize spaceLine;
@synthesize reportsBtn;
@synthesize hLine1;
@synthesize commentBtn;
@synthesize hLine2;
@synthesize praiseBtn;
@synthesize bottomLine;
@synthesize fromLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        spaceView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWith, 10)];
        spaceView.backgroundColor = [UIColor colorWithHex:0xf2f2f2];
        [self addSubview:spaceView];

        userImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, ORIGINY(spaceView)+HEIGHT(spaceView)+10, 30, 30)];
        [self addSubview:userImg];
        
        userNameLb = [[UILabel alloc]initWithFrame:CGRectMake(ORIGINX(userImg)+WIDTH(userImg)+10, ORIGINY(spaceView)+HEIGHT(spaceView)+10, kScreenWith-100, 15)];
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
        
        spaceLine = [[UIImageView alloc]init];
        spaceLine.image = [UIImage imageNamed:@"icon_horizontal_line"];
        [self addSubview:spaceLine];
        
        reportsBtn = [[WeiboListBtn alloc]init];
        reportsBtn.leftImg.image = [UIImage imageNamed:@"icon_share"];
        reportsBtn.rightLb.text = @"转发";
        [self addSubview:reportsBtn];
        
        hLine1 = [[UIImageView alloc]init];
        hLine1.image = [UIImage imageNamed:@"icon_vertical_line"];
        [self addSubview:hLine1];
        
        commentBtn = [[WeiboListBtn alloc]init];
        commentBtn.leftImg.image = [UIImage imageNamed:@"icon_comment"];
        commentBtn.rightLb.text = @"评论";
        [self addSubview:commentBtn];
        
        hLine2 = [[UIImageView alloc]init];
        hLine2.image = [UIImage imageNamed:@"icon_vertical_line"];
        [self addSubview:hLine2];
        
        praiseBtn = [[WeiboListBtn alloc]init];
        praiseBtn.leftImg.image = [UIImage imageNamed:@"icon_parise"];
        praiseBtn.rightLb.text = @"赞";
        [self addSubview:praiseBtn];
        
        bottomLine = [[UIImageView alloc]init];
        bottomLine.image = [UIImage imageNamed:@"icon_horizontal_line"];
        [self addSubview:bottomLine];
        
    }
    return self;
}

- (void)layoutCellWithEntity:(WeiboEntity *)entity
{
    [userImg sd_setImageWithURL:[NSURL URLWithString: entity.user.profile_image_url] placeholderImage:[UIImage imageNamed:@"icon_hardImg"]];

    float createTimeWidth = [entity.created_at getWidthByHeight:10 font:SystemFont_10];
    float fromLabelWidth = [fromLabel.text getWidthByHeight:10 font:SystemFont_10];
    float sourceWidth = [entity.source getWidthByHeight:10 font:SystemFont_10];

    createTimeLb.frame = CGRectMake(ORIGINX(userNameLb), ORIGINY(userNameLb)+HEIGHT(userNameLb)+5, createTimeWidth, 10);
    fromLabel.frame = CGRectMake(ORIGINX(createTimeLb)+WIDTH(createTimeLb)+5, ORIGINY(createTimeLb), fromLabelWidth, 10);
    sourceLb.frame = CGRectMake(ORIGINX(fromLabel)+WIDTH(fromLabel)+5, ORIGINY(fromLabel), sourceWidth, 10);

    userNameLb.text = entity.user.screen_name;
    createTimeLb.text = entity.created_at;
    sourceLb.text = entity.source;
    
    if(entity.reposts_count > 0)
    {
        reportsBtn.rightLb.text = [NSString stringWithFormat:@"%ld",(long)entity.reposts_count];
    }
    
    if(entity.comments_count > 0)
    {
        commentBtn.rightLb.text = [NSString stringWithFormat:@"%ld",(long)entity.comments_count];
    }
    
    if(entity.attitudes_count > 0)
    {
        praiseBtn.rightLb.text = [NSString stringWithFormat:@"%ld",(long)entity.attitudes_count];
    }
    
    float textHeight = [entity.weiboText getHeightByWidth:kScreenWith-20 font:WeiboTextFont];
    textLb.frame = CGRectMake(10, ORIGINY(userImg)+HEIGHT(userImg)+10, kScreenWith-20, textHeight);
    textLb.font = WeiboTextFont;
    textLb.text = entity.weiboText;
    
    if(entity.retweeted_status)
    {
        if(!retweetView)
        {
            retweetView = [[ReweetView alloc]init];
            [self addSubview:retweetView];
        }
        
        gridView.frame = CGRectMake(10, ORIGINY(textLb)+HEIGHT(textLb)+10, 0, 0);

        [retweetView layoutWithEntity:entity];
        retweetView.frame = CGRectMake(0, ORIGINY(textLb)+HEIGHT(textLb)+10, kScreenWith, HEIGHT(retweetView.reweetTextLb)+20+[GridView getGridViewHeight:entity.retweeted_status]);
        spaceLine.frame = CGRectMake(0, ORIGINY(retweetView)+HEIGHT(retweetView)+0.5, kScreenWith, 0.5);
    }
    else
    {
        if(!gridView)
        {
            gridView = [[GridView alloc]init];
            [self addSubview:gridView];
        }

        [gridView setSubViews:entity];
        gridView.frame = CGRectMake(10, ORIGINY(textLb)+HEIGHT(textLb)+10, [GridView getGridViewWidth:entity], [GridView getGridViewHeight:entity]);
        
        spaceLine.frame = CGRectMake(0, ORIGINY(gridView)+HEIGHT(gridView)+0.5, kScreenWith, 0.5);
    }
    
    reportsBtn.frame = CGRectMake(0, ORIGINY(spaceLine)+HEIGHT(spaceLine), kBtnWidth, kBtnHeight);
    hLine1.frame = CGRectMake(ORIGINX(reportsBtn)+WIDTH(reportsBtn), ORIGINY(reportsBtn)+5, 0.5, 20);
    commentBtn.frame = CGRectMake(ORIGINX(reportsBtn)+WIDTH(reportsBtn)+0.5, ORIGINY(reportsBtn), kBtnWidth, kBtnHeight);
    hLine2.frame = CGRectMake(ORIGINX(commentBtn)+WIDTH(commentBtn), ORIGINY(commentBtn)+5, 0.5, 20);
    praiseBtn.frame = CGRectMake(ORIGINX(commentBtn)+WIDTH(commentBtn)+0.5, ORIGINY(commentBtn), kBtnWidth, kBtnHeight);
    bottomLine.frame = CGRectMake(0, ORIGINY(praiseBtn)+HEIGHT(praiseBtn)-0.5, kScreenWith, 0.5);
}

@end
