//
//  WeiboListCell.m
//  UrunNews
//
//  Created by 杨方明 on 15/6/9.
//  Copyright (c) 2015年 URUN. All rights reserved.
//

#import "WeiboListCell.h"
#import "UIImageView+WebCache.h"
#define kBtnWidth ((kScreenWith-2)/3)
#import "UIColor+Expand.h"

@implementation WeiboListCell
@synthesize userImg;
@synthesize userNameLb;
@synthesize createTimeLb;
@synthesize sourceLb;
@synthesize textLabel;
@synthesize imageView;
@synthesize spaceLine;
@synthesize reportsBtn;
@synthesize hLine1;
@synthesize commentBtn;
@synthesize hLine2;
@synthesize praiseBtn;
@synthesize bottomLine;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        userDefault = [NSUserDefaults standardUserDefaults];

        userImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
        [self addSubview:userImg];
        
        userNameLb = [[UILabel alloc]initWithFrame:CGRectMake(ORIGINX(userImg)+WIDTH(userImg)+10, 10, kScreenWith-100, 15)];
        userNameLb.backgroundColor = [UIColor clearColor];
        userNameLb.font = SystemFont_14;
        userNameLb.textColor = [UIColor blackColor];
        [self addSubview:userNameLb];
        
        createTimeLb = [[UILabel alloc]initWithFrame:CGRectMake(ORIGINX(userNameLb), ORIGINY(userNameLb)+HEIGHT(userNameLb)+5, 50, 10)];
        createTimeLb.backgroundColor = [UIColor clearColor];
        createTimeLb.textColor = [UIColor grayColor];
        createTimeLb.font = SystemFont_12;
        [self addSubview:createTimeLb];
        
        UILabel *spaceLb = [[UILabel alloc]initWithFrame:CGRectMake(ORIGINX(createTimeLb)+WIDTH(createTimeLb), ORIGINY(createTimeLb), 30, 10)];
        spaceLb.backgroundColor = [UIColor clearColor];
        spaceLb.textColor = [UIColor grayColor];
        spaceLb.text = @"来自";
        spaceLb.font = SystemFont_12;
        [self addSubview:spaceLb];
        
        sourceLb = [[UILabel alloc]initWithFrame:CGRectMake(ORIGINX(spaceLb)+WIDTH(spaceLb), ORIGINY(spaceLb), 200, 10)];
        sourceLb.backgroundColor = [UIColor clearColor];
        sourceLb.textColor = [UIColor grayColor];
        sourceLb.font = SystemFont_12;
        [self addSubview:sourceLb];
        
        textLabel = [[UILabel alloc]init];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.font = [UIFont systemFontOfSize:14];
        textLabel.textColor = [UIColor blackColor];
        textLabel.numberOfLines = 0;
        textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:textLabel];
        
        imageView = [[UIImageView alloc]init];
        [self addSubview:imageView];
        
        spaceLine = [[UIImageView alloc]init];
        spaceLine.image = [UIImage imageNamed:@"icon_daytime_line"];
        [self addSubview:spaceLine];
        
        reportsBtn = [[WeiboListBtn alloc]init];
        reportsBtn.leftImg.image = [UIImage imageNamed:@"icon_write2"];
        reportsBtn.rightLb.text = @"0";
        [self addSubview:reportsBtn];
        
        hLine1 = [[UIImageView alloc]init];
        hLine1.image = [UIImage imageNamed:@"icon_line_vertical"];
        [self addSubview:hLine1];
        
        commentBtn = [[WeiboListBtn alloc]init];
        commentBtn.leftImg.image = [UIImage imageNamed:@"icon_favorites_comments"];
        commentBtn.rightLb.text = @"0";
        [self addSubview:commentBtn];
        
        hLine2 = [[UIImageView alloc]init];
        hLine2.image = [UIImage imageNamed:@"icon_line_vertical"];
        [self addSubview:hLine2];
        
        praiseBtn = [[WeiboListBtn alloc]init];
        praiseBtn.leftImg.image = [UIImage imageNamed:@"icon_like"];
        praiseBtn.rightLb.text = @"0";
        [self addSubview:praiseBtn];
        
        bottomLine = [[UIImageView alloc]init];
        bottomLine.image = [UIImage imageNamed:@"icon_daytime_line"];
        [self addSubview:bottomLine];
        
        spaceView = [[UIView alloc]init];
        spaceView.backgroundColor = [UIColor colorWithHex:0xf2f2f2];
        [self addSubview:spaceView];
        
    }
    return self;
}

- (void)layoutCellWithEntity:(WeiboEntity *)entity
{
    [userImg sd_setImageWithURL:[NSURL URLWithString: entity.user.profile_image_url] placeholderImage:[UIImage imageNamed:@"icon_hardImg"]];

    userNameLb.text = entity.user.screen_name;//[userInfo objectForKey:@"screen_name"];
    createTimeLb.text = entity.created_at;
    sourceLb.text = entity.source;
    
    float textHeight = [entity.weiboText getHeightByWidth:kScreenWith-20 font:WeiboTextFont];
    textLabel.frame = CGRectMake(10, ORIGINY(userImg)+HEIGHT(userImg)+10, kScreenWith-20, textHeight);
    textLabel.font = WeiboTextFont;
    textLabel.text = entity.weiboText;
    
    imageView.frame = CGRectMake(10, ORIGINY(textLabel)+HEIGHT(textLabel)+10, 70, 70);
    [imageView sd_setImageWithURL:[NSURL URLWithString:entity.thumbnail_pic] placeholderImage:[UIImage imageNamed:KDefaultImageName]];

    spaceLine.frame = CGRectMake(0, ORIGINY(imageView)+HEIGHT(imageView)+9, kScreenWith, 1);
    reportsBtn.frame = CGRectMake(0, ORIGINY(imageView)+HEIGHT(imageView)+10, kBtnWidth, 30);
    hLine1.frame = CGRectMake(ORIGINX(reportsBtn)+WIDTH(reportsBtn), ORIGINY(reportsBtn)+10, 1, 20);
    commentBtn.frame = CGRectMake(ORIGINX(reportsBtn)+WIDTH(reportsBtn), ORIGINY(reportsBtn), kBtnWidth, 30);
    hLine2.frame = CGRectMake(ORIGINX(commentBtn)+WIDTH(commentBtn), ORIGINY(commentBtn)+10, 1, 20);
    praiseBtn.frame = CGRectMake(ORIGINX(commentBtn)+WIDTH(commentBtn), ORIGINY(commentBtn), kBtnWidth, 30);
    bottomLine.frame = CGRectMake(0, ORIGINY(praiseBtn)+HEIGHT(praiseBtn)-1, kScreenWith, 1);
    spaceView.frame = CGRectMake(0,ORIGINY(praiseBtn)+HEIGHT(praiseBtn), kScreenWith, 10);
}

@end
