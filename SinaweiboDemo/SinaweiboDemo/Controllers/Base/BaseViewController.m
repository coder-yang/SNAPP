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
@synthesize backBtnLabel;
@synthesize backText;

//返回主内容视图，默认值为空，如果继承BaseViewController，一般都需要重写此方法。重写此方法后，则不能重写loadView方法，不然会导致此方法失效。如果不重写此方法，一定要重写loadView方法，这样才能保证视图初始化成功。
- (UIView *)mainContentView
{
    return nil;
}

//默认返回no，如有需要，子类重写
- (BOOL)isExistTabBar
{
    return NO;
}

//初始化主内容视图位置
- (void)initMainContentViewFrame
{
    CGRect rect = [UIScreen mainScreen].bounds;
    mainContentViewFrame = CGRectMake(0, StatusBarHeight+NavHeight, rect.size.width, rect.size.height-StatusBarHeight-NavHeight-([self isExistTabBar]?kTabbarHeight:0));
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
        leftButton.frame = CGRectMake(0, StatusBarHeight, 110, 44);
        
        UIImageView *backImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 15, 30)];
        backImgView.image = [UIImage imageNamed:@"navigationbar_back_withtext"];
        [leftButton addSubview:backImgView];
        
        backBtnLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 60, 44)];
        backBtnLabel.backgroundColor = [UIColor clearColor];
        backBtnLabel.font = SystemFont_14;
        backBtnLabel.textColor = [UIColor blackColor];
        backBtnLabel.text = self.backText;
        [leftButton addSubview:backBtnLabel];
        
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

- (NSString *)navTitle
{
    return titleLabel.text;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
