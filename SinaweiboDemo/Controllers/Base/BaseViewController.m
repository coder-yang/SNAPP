//
//  BaseViewController.m
//  Urundc_IOS
//
//  Created by 杨方明 on 15/1/5.
//  Copyright (c) 2015年 urun. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
{
    UILabel *titleLabel;
}
@end

@implementation BaseViewController

@synthesize mainContentViewFrame;
@synthesize customNav;
@synthesize navTitle;

//返回主内容视图，默认值为空，如果继承BaseViewController，一般都需要重写此方法。重写此方法后，则不能重写loadView方法，不然会导致此方法失效。如果不重写此方法，一定要重写loadView方法，这样才能保证视图初始化成功。
- (UIView *)mainContentView
{
    return nil;
}

//初始化主内容视图位置
- (void)initMainContentViewFrame
{
    CGRect rect = [UIScreen mainScreen].bounds;
    mainContentViewFrame = CGRectMake(0, StatusBarHeight+NavHeight, rect.size.width, rect.size.height-StatusBarHeight-NavHeight);
}

/**
 *  自定义导航栏
 */
- (void)showCustomNav
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    CGRect rect = [UIScreen mainScreen].bounds;
    CGRect navRect = CGRectMake(0, 0, rect.size.width , NavHeight+StatusBarHeight);
    customNav = [[UIImageView alloc]initWithFrame:navRect];
    [customNav setBackgroundColor:[UIColor colorWithHex:0xf6f6f6]];
    [self.view addSubview:customNav];
    
    if(isScreen3_5Inch || isScreen4Inch)
    {
        //TODO
    }
}

/**
 *  自定义导航栏返回按钮
 */
- (void)showCustomNavBackButton
{
    if([self showBackButton])
    {
        customNav.userInteractionEnabled = YES;
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = CGRectMake(0, StatusBarHeight, 50, 44); //14*25
        [leftButton setImageEdgeInsets:UIEdgeInsetsMake(10, 11, 10, 25)]; //top, left, bottom, right
        [leftButton setImage:[UIImage imageNamed:@"icon_return"] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(onBackButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [customNav addSubview:leftButton];
    }
}

/**
 *  自定义导航栏标题
 */
- (void)showCustomTitle
{
    if([self showTitle])
    {
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, StatusBarHeight, 200, NavHeight)];
        titleLabel.center = CGPointMake(self.mainContentViewFrame.size.width/2, StatusBarHeight+NavHeight/2);
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = NavTitleFont;
        [self.customNav addSubview:titleLabel];
    }
}

/**
 *  默认显示导航栏返回按钮 如果不需要 在子类重写此方法 返回NO即可
 */
- (BOOL)showBackButton
{
    return YES;
}

/**
 *  默认显示导航栏标题 如果不需要 在子类重写 返回NO
 */
- (BOOL)showTitle
{
    return YES;
}

- (void)setNavTitle:(NSString *)aTitle
{
    titleLabel.text = aTitle;
}

- (void)onBackButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark- BaseViewController life cycle
- (id)init
{
    if(self = [super init])
    {
        [self initMainContentViewFrame];
    }
    return self;
}

- (void)loadView
{
    UIView *contentView = [self mainContentView];
    NSAssert(contentView!=nil, @"Subclass must implepment mainContentView.");
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view  addSubview:contentView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];

    UISwipeGestureRecognizer *rightSwipeGes = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe)];
    rightSwipeGes.direction = UISwipeGestureRecognizerDirectionRight;
    rightSwipeGes.delegate = self;
    [self.view addGestureRecognizer:rightSwipeGes];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self showCustomNav];
    [self showCustomNavBackButton];
    [self showCustomTitle];
}

#pragma mark - 滑动手势
//默认返回上一级，如果有不同需求在子类重写
- (void)rightSwipe
{
    [self onBackButtonClick];
}

#pragma mark hud
- (void)hudShowTextOnly:(NSString *)text delay:(int)delay view:(UIView *)aView
{
    hud = [MBProgressHUD showHUDAddedTo:aView animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.margin = 10.f;
//    hud.yOffset = 200; //设置距离视图中心的y坐标
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:delay];
}

- (void)hudShowWithLabelText:(NSString *)text view:(UIView *)aView
{
    hud = [[MBProgressHUD alloc]initWithView:aView];
    [aView addSubview:hud];
    
    hud.detailsLabelText = text;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
}

- (void)hideHudDidSuccess:(NSString *)text
{
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.detailsLabelText = text;
    [hud hide:YES afterDelay:2];
}

- (void)hideHudDidFail:(NSString *)text
{
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x_icon_reqeustFail"]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.detailsLabelText = text;
    [hud hide:YES afterDelay:2];
}

- (void)hideHud
{
    [hud hide:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
