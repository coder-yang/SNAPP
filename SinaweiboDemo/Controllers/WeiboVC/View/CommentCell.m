//
//  CommentCell.m
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/30.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import "CommentCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+Expand.h"

@implementation CommentCell
@synthesize userImg;
@synthesize userNameLb;
@synthesize createTimeLb;
@synthesize contentLb;
@synthesize praiseBtn;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        userImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
        [self addSubview:userImg];
        
        userNameLb = [[UILabel alloc]initWithFrame:CGRectMake(userImg.x+userImg.width+10, 10, kScreenWith-100, 15)];
        userNameLb.backgroundColor = [UIColor clearColor];
        userNameLb.font = SystemFont_12;
        userNameLb.textColor = [UIColor blackColor];
        [self addSubview:userNameLb];
        
        createTimeLb = [[UILabel alloc]initWithFrame:CGRectMake(userNameLb.x, userNameLb.y+userNameLb.height+5, 200, 10)];
        createTimeLb.backgroundColor = [UIColor clearColor];
        createTimeLb.textColor = [UIColor grayColor];
        createTimeLb.font = SystemFont_10;
        [self addSubview:createTimeLb];
        
        contentLb = [[UILabel alloc]initWithFrame:CGRectMake(userNameLb.x, userImg.y+userImg.height+10, kScreenWith-userImg.x-userImg.width-20, 0)];
        contentLb.backgroundColor = [UIColor clearColor];
        contentLb.font = SystemFont_14;
        contentLb.textColor = [UIColor blackColor];
        contentLb.numberOfLines = 0;
        contentLb.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:contentLb];
        
        praiseBtn = [[CommentPraiseBtn alloc]init];
        [self addSubview:praiseBtn];
        
        spaceLine = [[UIImageView alloc]init];
        spaceLine.image = [UIImage imageNamed:@"icon_horizontal_line"];
        [self addSubview:spaceLine];

    }
    return self;
}

- (void)layoutWithEntity:(Comment *)comment
{
    [userImg sd_setImageWithURL:[NSURL URLWithString: comment.user.profile_image_url] placeholderImage:[UIImage imageNamed:@"icon_hardImg"]];
    createTimeLb.text = comment.created_at;
    
    float contentTextHeight = [comment.text getHeightByWidth:kScreenWith-userImg.x-userImg.width-20 font:SystemFont_14];
    contentLb.height = contentTextHeight;
    contentLb.text = comment.text;
    
    userNameLb.text = comment.user.name;
    
    if(comment.status.attitudes_count > 0)
    {
        [praiseBtn setRightText:[NSString stringWithFormat:@"%lu",comment.status.attitudes_count]];
    }
    else
    {
        [praiseBtn setRightText:@""];
    }
    praiseBtn.x = kScreenWith-10-praiseBtn.width;
    praiseBtn.y = 10;
    
    spaceLine.frame = CGRectMake(0, contentLb.y+contentLb.height+9, kScreenWith, 1);
}

@end
