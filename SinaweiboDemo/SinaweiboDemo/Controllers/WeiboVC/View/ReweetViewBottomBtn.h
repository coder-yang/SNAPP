//
//  ReweetViewBottomBtn.h
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/30.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReweetViewBottomBtn : UIButton

@property (nonatomic, strong) UIImageView *leftImgView;
@property (nonatomic, strong) UILabel *rightLb;

- (void)setImage:(UIImage *)image rightLb:(NSString *)numStr;

@end
