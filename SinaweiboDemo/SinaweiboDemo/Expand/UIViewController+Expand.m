//
//  UIViewController+Expand.m
//  MedicalPatients
//
//  Created by 杨方明 on 15/12/1.
//  Copyright © 2015年 云润大数据. All rights reserved.
//

#import "UIViewController+Expand.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

static const void *HttpRequestHUDKey = &HttpRequestHUDKey;

@implementation UIViewController (Expand)

@end

@implementation UIViewController (HUD)

#pragma mark hud
- (MBProgressHUD *)HUD
{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD
{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)hudShowTextOnly:(NSString *)text delay:(int)delay view:(UIView *)aView
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:aView animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    hud.yOffset = 150; //设置距离视图中心的y坐标
    [hud hide:YES afterDelay:delay];
}

- (void)hudShowWithLabelText:(NSString *)text view:(UIView *)aView
{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:aView];
    [aView addSubview:hud];
    
    hud.detailsLabelText = text;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    [self setHUD:hud];
}

- (void)hideHudDidSuccess:(NSString *)text
{
    MBProgressHUD *hud = [self HUD];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.detailsLabelText = text;
    [hud hide:YES afterDelay:2];
}

- (void)hideHudDidFail:(NSString *)text
{
    MBProgressHUD *hud = [self HUD];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x_icon_reqeustFail"]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.detailsLabelText = text;
    [hud hide:YES afterDelay:2];
}

- (void)hideHud
{
    [[self HUD] hide:YES];
}

@end