//
//  NSMutableAttributedString+Extend.m
//  UrunNews
//
//  Created by 杨方明 on 15/4/13.
//  Copyright (c) 2015年 URUN. All rights reserved.
//

#import "NSMutableAttributedString+Extend.h"

@implementation NSMutableAttributedString (Extend)

- (float)getMutableAttributedStringHeightByWidth:(float)width
{
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                                    options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                    context:nil];
    return rect.size.height;
}

@end
