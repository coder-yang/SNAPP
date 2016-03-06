//
//  DATManager.h
//  Urundc_IOS
//
//  Created by 杨方明 on 15/1/13.
//  Copyright (c) 2015年 urun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDAT.h"

@interface DATManager : NSObject


+ (instancetype)sharedDATManager;

- (void)initDB;

@end
