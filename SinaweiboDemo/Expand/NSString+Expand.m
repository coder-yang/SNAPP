//
//  NSString+Expand.m
//  Urundc_IOS
//
//  Created by 杨方明 on 15/1/8.
//  Copyright (c) 2015年 urun. All rights reserved.
//

#import "NSString+Expand.h"

#import "CommonCrypto/CommonDigest.h"    //MD5

#import <CommonCrypto/CommonCryptor.h>  //DES 加密

@implementation NSString (Expand)

//文本先进行DES加密。然后再转成base64
+ (NSString *)base64StringFromText:(NSString *)text withKey:(NSString*)key
{
    if (text && ![text isEqualToString:@""]) {
        
        NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
        
        //IOS 自带DES加密 Begin
        data = [self DESEncrypt:data key:key];
        //IOS 自带DES加密 End
        
        NSString *base64Str = [GTMBase64 stringByEncodingData:data];
        
        return base64Str;
    }
    else {
        return @"";
    }
}



const Byte iv[] = {1,2,3,4,5,6,7,8};
+ (NSData *) DESEncrypt:(NSData *)data key:(NSString *)key
{
    NSUInteger dataLength = [data length];
    //    unsigned char buffer[1024];
    //    memset(buffer, 0, sizeof(char));
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess)
    {
        return [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}


//判断字符串是否为空
+ (BOOL)isEmptyString:(NSString *)string
{
    if(!string || [string isKindOfClass:[NSNull class]] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""] || string.length == 0)
    {
        return YES;
    }
    return NO;
}

//判断字符串是否为手机号码
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    //    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$"; //新增 181
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+(NSString*)getVisitVerify:(NSString *)string
{
   // 获取验证码VisitVerify
   
    NSString *CurrentDate = [self getCurrentDateWithFormat:@"yyyy-MM-dd"];

    //获取缓存数据
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *CacheDate = [userDefaults objectForKey:@"CacheDate"];
    NSString *CacheVerifyCode = [userDefaults objectForKey:@"CacheVerifyCode"];
    //判断是否有当日的缓存
    if( [CacheDate isEqualToString:CurrentDate] && ![CacheVerifyCode isEqualToString:@""] ){
        NSLog(@"%@",CacheVerifyCode);
        return CacheVerifyCode;
    }
    

    else //没有则生成新的验证码VisitVerify
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:CurrentDate forKey:@"CacheDate"];
        [userDefaults synchronize];
        
        NSString *newVerifyCode = [CurrentDate stringByAppendingString:string];
        NSString *VerifyCode = [self GetMd5:newVerifyCode];
        return VerifyCode;
    }
}


+ (NSString *) md5:(NSString *)str lenth:(int)lenth{
    const char *cStr = [str UTF8String];
    unsigned char result[lenth];
    CC_MD5(cStr, strlen(cStr), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < lenth/2; i++){
        [hash appendFormat:@"%02X", result[i]];
    }
    
    return [hash lowercaseString];
}

+ (NSString *)GetMd5:(NSString *)str
{
    NSString *md5Str = [self md5:str lenth:32];
    const int count = 5;  //连续多少次生产相同，才认为是正确的。
    NSString* result;
    for(int i = 0; i < count; i++)
    {
        if ([md5Str isEqualToString:@""] || [md5Str isEqualToString:@"00000000000000000000000000000000"]) {
            continue;
        }
        //第一次赋值，以后都得比较
        if ([result isEqualToString:@""]) {
            result = md5Str;
        }
        
        else
        {
            //如果前后不对应，则不是连续相同，有其中一次是错误的，清空，重新来
            if(![result isEqualToString:md5Str])
            {
                result = @"";
                i = -1;
            }
        }
        
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:result forKey:@"CacheVerifyCode"];
    [userDefaults synchronize];
    
    return result;
}

//获取当前时间
+ (NSString *)getCurrentDateWithFormat:(NSString *)format
{
    NSDateFormatter *nsdf2=[[NSDateFormatter alloc] init];
    [nsdf2 setDateStyle:NSDateFormatterShortStyle];
    [nsdf2 setDateFormat:format]; //HH:mm:ss
    NSString *t2 = [nsdf2 stringFromDate:[NSDate date]];
    
    return t2;
}

+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    if (!format) {
        format = @"yyyy-MM-dd";
    }
    [df setDateFormat:format];
    
    return [df stringFromDate:date];
}


+ (NSString *)replaceNullByStr:(NSObject *)source string:(NSString *)str
{
    NSString *result = (NSString*)source;
    if (!source) {
        result = @"";
    }
    else if ([source isKindOfClass:[NSNull class]]) {
        result = str;
    }
    
    return result;
}

- (NSDate *)dateValue
{
    return [self dateValueWithFormatString:@"yyyy-MM-dd"];
}

- (NSDate *)dateValueWithFormatString:(NSString *)formatString
{
    NSDateFormatter *strToDateFormatter = [[NSDateFormatter alloc] init];
    [strToDateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]]; //适应中文环境，如果不写中文环境下转出来为nil
    
    NSDate *date = nil;
    @synchronized(strToDateFormatter)
    {
        [strToDateFormatter setDateFormat:formatString];
        date = [strToDateFormatter dateFromString:self];
    }
    return date;
}

/*
 其中如果options参数为NSStringDrawingUsesLineFragmentOrigin，那么整个文本将以每行组成的矩形为单位计算整个文本的尺寸。（在这里有点奇怪，因为字体高度大概是13.8，textView中大概有10行文字，此时用该选项计算出来的只有5行，即高度为69，而同时使用NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin却可以得出文字刚好有10行，即高度为138，这里要等iOS7官方的文档出来再看看选项的说明，因为毕竟以上文档是iOS6的东西）
 
 如果为NSStringDrawingTruncatesLastVisibleLine或者NSStringDrawingUsesDeviceMetric，那么计算文本尺寸时将以每个字或字形为单位来计算。
 
 如果为NSStringDrawingUsesFontLeading则以字体间的行距（leading，行距：从一行文字的底部到另一行文字底部的间距。）来计算。
 
 各个参数是可以组合使用的，如NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine。
 */
- (int)getHeightByWidth:(float)aWidth font:(UIFont *)aFont
{
    CGRect rect = [self boundingRectWithSize:CGSizeMake(aWidth, LONG_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:@{NSFontAttributeName:aFont}
                                     context:nil];
    
    return ceil(rect.size.height);
}

- (int)getWidthByHeight:(float)aHeight font:(UIFont *)aFont
{
    CGRect rect = [self boundingRectWithSize:CGSizeMake(LONG_MAX, 20)
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:@{NSFontAttributeName:aFont}
                                     context:nil];
    return ceil(rect.size.width);
    
}

-(NSMutableAttributedString *)attributedStringFromStingWithFont:(UIFont *)font
                                                withLineSpacing:(CGFloat)lineSpacing
{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName:font}];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    
    [attributedStr addAttribute:NSParagraphStyleAttributeName
                          value:paragraphStyle
                          range:NSMakeRange(0, [self length])];
    return attributedStr;
}

+ (NSString *)getTimeInterval:(NSString *)getPushTime currentTime:(NSString *)currentTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSDate *getpushDate = [dateFormatter dateFromString:getPushTime];
    NSDate *currentDate = [dateFormatter dateFromString:currentTime];
    
    NSTimeInterval x;
    if([getpushDate compare:currentDate] == NSOrderedAscending) //时间小于当前时间
    {
        x = [currentDate timeIntervalSinceDate:getpushDate];
    }
    else
    {
        x = [getpushDate timeIntervalSinceDate:currentDate];
    }

    
    x = [currentDate timeIntervalSinceDate:getpushDate];
    int days = abs((int)x/(3600*24));
    int hours = abs((int)x%(3600*24)/3600);
    int minite = abs((int)x%(3600*24)%3600/60);
    int second = abs((int)x%(3600*24)%3600%60);
    
    if(days != 0)
    {
        return [NSString stringWithFormat:@"%i天前",days];
    }
    else if(hours != 0)
    {
        return [NSString stringWithFormat:@"%i小时前",hours];
    }
    else if (minite != 0)
    {
        return [NSString stringWithFormat:@"%i分钟前",minite];
    }
    else if (second !=0 )
    {
        return [NSString stringWithFormat:@"刚刚"];
    }
    else
    {
        return @"现在";
    }
}

+ (long)getTimeIntervalSecond:(NSString *)getPushTime currentTime:(NSString *)currentTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSDate *getpushDate = [dateFormatter dateFromString:getPushTime];
    NSDate *currentDate = [dateFormatter dateFromString:currentTime];
    
    NSTimeInterval x;
    if([getpushDate compare:currentDate] == NSOrderedAscending) //时间小于当前时间
    {
        x = [currentDate timeIntervalSinceDate:getpushDate];
    }
    else
    {
        x = [getpushDate timeIntervalSinceDate:currentDate];
    }
    
    
    x = [currentDate timeIntervalSinceDate:getpushDate];
    
    return x;
}

+ (NSString *)timeStampToString:(NSString *)dateStr format:(NSString *)formatStr
{
    NSString *timeStamp = [dateStr substringWithRange:NSMakeRange(6, 13)];
    
    NSTimeInterval dateInterval = [timeStamp doubleValue];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatStr];
    
    NSString *dateString = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:dateInterval / 1000.0]];
    return dateString;
}

@end
