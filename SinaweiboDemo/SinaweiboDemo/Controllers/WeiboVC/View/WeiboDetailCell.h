//
//  WeiboDetailCell.h
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/30.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReweetView.h"
#import "GridView.h"
#import "ReweetViewBottomBtn.h"

@interface WeiboDetailCell : UITableViewCell
{
    UILabel *fromLabel;
    UIImageView *spaceLine;
}
@property (nonatomic, strong) UIImageView *userImg;
@property (nonatomic, strong) UILabel *userNameLb;
@property (nonatomic, strong) UILabel *createTimeLb;
@property (nonatomic, strong) UILabel *sourceLb;
@property (nonatomic, strong) UILabel *textLb;
@property (nonatomic, strong) ReweetView *retweetView;
@property (nonatomic, strong) GridView *gridView;
@property (nonatomic, strong) ReweetViewBottomBtn *reportBtn;
@property (nonatomic, strong) ReweetViewBottomBtn *commentBtn;
@property (nonatomic, strong) ReweetViewBottomBtn *praiseBtn;

- (void)layoutCellWithEntity:(WeiboEntity *)entity;

@end
