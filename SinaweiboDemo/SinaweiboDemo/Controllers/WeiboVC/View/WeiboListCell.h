//
//  WeiboListCell.h
//  UrunNews
//
//  Created by 杨方明 on 15/6/9.
//  Copyright (c) 2015年 URUN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboListBtn.h"
#import "WeiboEntity.h"
#import "NSString+Expand.h"
#import "ReweetView.h"
#import "GridView.h"

@interface WeiboListCell : UITableViewCell
{
    UIView *spaceView;
}
@property (nonatomic, strong) UIImageView *userImg;
@property (nonatomic, strong) UILabel *userNameLb;
@property (nonatomic, strong) UILabel *createTimeLb;
@property (nonatomic, strong) UILabel *sourceLb;
@property (nonatomic, strong) UILabel *textLb;
@property (nonatomic, strong) ReweetView *retweetView;
@property (nonatomic, strong) GridView *gridView;
@property (nonatomic, strong) UIImageView *spaceLine;
@property (nonatomic, strong) WeiboListBtn *reportsBtn;
@property (nonatomic, strong) UIImageView *hLine1;
@property (nonatomic, strong) WeiboListBtn *commentBtn;
@property (nonatomic, strong) UIImageView *hLine2;
@property (nonatomic, strong) WeiboListBtn *praiseBtn;
@property (nonatomic, strong) UIImageView *bottomLine;
@property (nonatomic, strong) UILabel *fromLabel;

- (void)layoutCellWithEntity:(WeiboEntity *)entity;

@end
