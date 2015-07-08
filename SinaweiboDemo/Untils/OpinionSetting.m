//
//  OpinionSetting.m
//  OPinion
//
//  Created by li sha on 12-7-24.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import "OpinionSetting.h"
#import "JSONKit.h"
#import "NSString+Expand.h"

@implementation OpinionSetting

+ (void)setViewLayer:(UIView *)view radius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color
{
    CALayer *layer = [view layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:radius];
    [layer setBorderWidth:width];
    [layer setBorderColor:[color CGColor]];
}

+ (BOOL)hasNetWork
{
//    Reachability *reachability = [Reachability reachabilityWithHostName:CheckNetworkHost]; //会卡住主线程，建议使用下面的方式
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    if([reachability currentReachabilityStatus] == NotReachable)
    {
        return NO;
    }
    
    return YES;
}

@end
