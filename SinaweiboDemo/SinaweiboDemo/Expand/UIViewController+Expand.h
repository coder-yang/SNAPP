//
//  UIViewController+Expand.h
//  MedicalPatients
//
//  Created by 杨方明 on 15/12/1.
//  Copyright © 2015年 云润大数据. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Expand)

@end

@interface UIViewController (HUD)

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

/**
 *  隐藏请求成功的提示框
 *
 *  @param text 成功提示语
 */
- (void)hideHudDidSuccess:(NSString *)text;

/**
 *  隐藏请求失败的提示框
 *
 *  @param text 失败提示语
 */
- (void)hideHudDidFail:(NSString *)text;

/**
 *  隐藏loading框
 */
- (void)hideHud;

@end
