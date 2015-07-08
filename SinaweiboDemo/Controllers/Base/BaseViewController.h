//
//  BaseViewController.h
//  Urundc_IOS
//
//  Created by 杨方明 on 15/1/5.
//  Copyright (c) 2015年 urun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Expand.h"
#import "SystemConfig.h"
#import "MBProgressHUD.h"
#import "URRequest.h"

#define StatusBarHeight 20 //状态栏高度固定为20
#define NavHeight 44 //自定义导航栏高度 默认为44

@interface BaseViewController : UIViewController <UIGestureRecognizerDelegate>
{
    MBProgressHUD *hud;
}

//@property (nonatomic, readonly) UIWindow *keyWindow;

/**
 *  内容区域的frame
 */
@property(nonatomic, readonly) CGRect mainContentViewFrame;

/**
 *  自定义的导航栏View
 */
@property(nonatomic, strong) UIImageView *customNav;

/**
 *  导航栏标题
 */
@property(nonatomic, strong) NSString *navTitle;

/**
 *  全屏提示框 只显示文字
 *
 *  @param text  提示内容
 *  @param delay 显示时间
 *  @param aView 提示框super view
 */
- (void)hudShowTextOnly:(NSString *)text delay:(int)delay view:(UIView *)aView;

/**
 *  全屏提示框 显示login框和文本
 *
 *  @param text  提示内容
 *  @param delay 显示时间
 *  @param aView 提示框super view
 */
- (void)hudShowWithLabelText:(NSString *)text view:(UIView *)aView;

- (void)hideHudDidSuccess:(NSString *)text;

- (void)hideHudDidFail:(NSString *)text;

/**
 *  隐藏loading框
 */
- (void)hideHud;

@end
