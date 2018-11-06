//
//  UITabBar+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/4.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UITabBar+Kimi.h"
#import <xt-engine/EDOExporter.h>

@implementation UITabBar (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UITabBar", @"UIView");
    EDO_EXPORT_PROPERTY(@"translucent");
    EDO_EXPORT_PROPERTY(@"barTintColor");
    EDO_EXPORT_PROPERTY(@"unselectedItemTintColor");
}

@end
