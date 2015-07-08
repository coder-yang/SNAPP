//
//  NSString+Expand.h
//  Urundc_IOS
//
//  Created by 杨方明 on 15/1/8.
//  Copyright (c) 2015年 urun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTMBase64.h"

@interface NSString (Expand)

+ (NSString *)base64StringFromText:(NSString *)text withKey:(NSString*)key;

+ (NSData *) DESEncrypt:(NSData *)data key:(NSString *)key;

+ (BOOL)isEmptyString:(NSString *)string;

+ (BOOL)isMobileNumber:(NSString *)mobileNum;

+ (NSString*)getVisitVerify:(NSString *)string;

+ (NSString *)GetMd5:(NSString *)string;


+ (NSString *)getPhoneSN;

+ (NSString *) md5:(NSString *)str lenth:(int)lenth;

+ (NSString *)replaceNullByStr:(NSObject *)source string:(NSString *)str;

+ (NSString *)getCurrentDateWithFormat:(NSString *)format;

//date转string
+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format;

//string转date
- (NSDate *)dateValueWithFormatString:(NSString *)formatString;

//string转date
- (NSDate *)dateValue;

//获取字符串高度通过宽度
- (int)getHeightByWidth:(float)aWidth font:(UIFont *)aFont;

//获取字符串宽度通过高度
- (int)getWidthByHeight:(float)aHeight font:(UIFont *)aFont;

//string转NSMutableAttributedString
-(NSMutableAttributedString *)attributedStringFromStingWithFont:(UIFont *)font
                                                withLineSpacing:(CGFloat)lineSpacing;

//获取时间间隔
+ (NSString *)getTimeInterval:(NSString *)getPushTime currentTime:(NSString *)currentTime;

+ (long)getTimeIntervalSecond:(NSString *)getPushTime currentTime:(NSString *)currentTime;

//时间戳转时间
+ (NSString *)timeStampToString:(NSString *)dateStr format:(NSString *)formatStr;

@end
