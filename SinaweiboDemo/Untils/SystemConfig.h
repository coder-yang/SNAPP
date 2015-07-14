//
//  SystemConfig.h
//  Urundc_IOS
//
//  Created by 杨方明 on 15/1/6.
//  Copyright (c) 2015年 urun. All rights reserved.
//

#ifndef Urundc_IOS_SystemConfig_h
#define Urundc_IOS_SystemConfig_h

#define kSinaKey @"1155686117"
#define kSinaSecret @"f330a08c1d007da59d5de16f4fdef7ca"
#define kAccessToken @"accessToken"
#define kExpireTime @"expireTime"
#define kUid @"uid"

#define NONetworkPrompt @"无网络连接，请设置网络"
#define TimeOutPrompt @"网络不给力，稍后再试"
#define kLoadFail @"加载失败，点击重试"
#define kNoComment @"快抢沙发！"
#define KDefaultImageName @"icon_default_image"
#define kWeiboName @"微博"

#define NoNetworkViewHeight 80
#define kTabbarHeight 44
#define kPageCount 20

#define ViewBackgroundColor 0xf2f2f2

#define kGetCurAppVersion [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] //获取应用release版本号


#define SystemFont_10 [UIFont systemFontOfSize:10]
#define SystemFont_12 [UIFont systemFontOfSize:12]
#define SystemFont_13 [UIFont systemFontOfSize:13]
#define SystemFont_14 [UIFont systemFontOfSize:14]
#define SystemFont_16 [UIFont systemFontOfSize:16]
#define SystemFont_18 [UIFont systemFontOfSize:18]
#define SystemFont_20 [UIFont systemFontOfSize:20]
#define BoldSystemFont_12 [UIFont boldSystemFontOfSize:12]
#define BoldSystemFont_14 [UIFont boldSystemFontOfSize:14]
#define BoldSystemFont_16 [UIFont boldSystemFontOfSize:16]

#define ContentFont [UIFont systemFontOfSize:16]  //内容字体
#define NavTitleFont [UIFont systemFontOfSize:16] //导航栏标题字体

//是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
//是否为iOS8及以上系统
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)

//文件缓存路径
#define CachePath ([NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0])

#define isScreen3_5Inch ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define isScreen4Inch ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define isScreen4_7Inch ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define isScreen5_5Inch ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define kScreenWith [UIScreen mainScreen].bounds.size.width
#define kScreenheight [UIScreen mainScreen].bounds.size.height

#define WIDTH(obj)  obj.frame.size.width
#define HEIGHT(obj)  obj.frame.size.height
#define ORIGINX(obj)  obj.frame.origin.x
#define ORIGINY(obj)  obj.frame.origin.y

#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBColorAlpha(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define KWindow [[UIApplication sharedApplication].delegate window]

#define CoverNull(anobject) (((anobject==nil) || [anobject isKindOfClass:[NSNull class]])?nil:anobject)

#endif

#ifdef DEBUG
/*
 　1) __VA_ARGS__ 是一个可变参数的宏，很少人知道这个宏，这个可变参数的宏是新的C99规范中新增的，目前似乎只有gcc支持（VC6.0的编译器不支持）。宏前面加上##的作用在于，当可变参数的个数为0时，这里的##起到把前面多余的","去掉的作用,否则会编译出错, 你可以试试。
 　　2) __FILE__ 宏在预编译时会替换成当前的源文件名
 　　3) __LINE__宏在预编译时会替换成当前的行号
 　　4) __FUNCTION__宏在预编译时会替换成当前的函数名称
 */
//# define DLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);

#define DLog(fmt, ...) NSLog((@"[行号:%d] " fmt),__LINE__,##__VA_ARGS__);
//#	define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#	define pwd printf("%s %d\n", __PRETTY_FUNCTION__, __LINE__);
#define debug_object( arg ) debug( @"Object: %@", arg );
#define debug_int( arg ) debug( @"integer: %i", arg );
#define debug_float( arg ) NSLog( @"float: %f", arg );
#define debug_rect(arg) NSLog( @"CGRect ( %f, %f, %f, %f)", arg.origin.x, arg.origin.y, arg.size.width, arg.size.height );
#define debug_point( arg ) debug( @"CGPoint ( %f, %f )", arg.x, arg.y );
#define debug_bool( arg )   debug( @"Boolean: %@", ( arg == YES ? @"YES" : @"NO" ) );
#else
#	define DLog(...)
#endif

