//
//  CommentHeadBtn.h
//  SinaweiboDemo
//
//  Created by 杨方明 on 15/7/30.
//  Copyright (c) 2015年 Simon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentHeadBtn : UIButton

@property (nonatomic, strong) UILabel *leftLb;
@property (nonatomic, strong) UILabel *rightLb;

- (void)setLeftText:(NSString *)leftText rightText:(NSString *)rightText;

- (void)setTextColor:(UIColor *)color;

@end
