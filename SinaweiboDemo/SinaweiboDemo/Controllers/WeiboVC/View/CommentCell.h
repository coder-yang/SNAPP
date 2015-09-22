//
//  CommentCell.h
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/30.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentPraiseBtn.h"
#import "Comment.h"

@interface CommentCell : UITableViewCell
{
    UIImageView *spaceLine;
}

@property (nonatomic, strong) UIImageView *userImg;
@property (nonatomic, strong) UILabel *userNameLb;
@property (nonatomic, strong) UILabel *createTimeLb;
@property (nonatomic, strong) UILabel *contentLb;
@property (nonatomic, strong) CommentPraiseBtn *praiseBtn;

- (void)layoutWithEntity:(Comment *)comment;

@end
