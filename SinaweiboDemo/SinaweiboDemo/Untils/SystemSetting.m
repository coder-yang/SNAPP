//
//  OpinionSetting.m
//  OPinion
//
//  Created by li sha on 12-7-24.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import "SystemSetting.h"
#import "NSString+Expand.h"

@implementation SystemSetting

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

+ (NSString *)getAccesstoken
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:kAccessToken];
}

+ (BOOL)isVaildToken
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDate *expireDate = [userDefaults objectForKey:kExpireTime];
    
    if([self dateLongValue:[NSDate date]] < [self dateLongValue:expireDate])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (long long)dateLongValue:(NSDate *)date
{
    NSString *dateStr = [NSString stringFromDate:date format:@"yyyy-MM-dd HH:mm:ss"];
    NSArray *arr = [dateStr componentsSeparatedByString:@" "];
    NSString *yearStr = arr[0];
    NSString *timeStr = arr[1];
    NSArray *yearArr = [yearStr componentsSeparatedByString:@"-"];
    NSArray *timeArr = [timeStr componentsSeparatedByString:@":"];
    NSMutableString *resultString = [NSMutableString string];
    for(NSString *string in yearArr)
    {
        [resultString appendString:string];
    }
    
    for(NSString *string in timeArr)
    {
        [resultString appendString:string];
    }
    
    return [resultString longLongValue];
}

+ (float)getNewHeightFromSize:(CGSize)size newWidth:(float)newWidth
{
    return newWidth*size.height/size.width;
}

+ (float)getNewWidthFromSize:(CGSize)size newHeight:(float)newHeight
{
    return newHeight*size.width/size.height;
}

@end
