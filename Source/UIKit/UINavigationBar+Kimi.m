//
//  UINavigationBar+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/4.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UINavigationBar+Kimi.h"
#import "EDOExporter.h"

@implementation UINavigationBar (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UINavigationBar", @"UIView");
    EDO_EXPORT_PROPERTY(@"translucent");
    EDO_EXPORT_PROPERTY(@"barTintColor");
    EDO_EXPORT_PROPERTY(@"titleTextAttributes");
    EDO_EXPORT_PROPERTY(@"backIndicatorImage");
    EDO_EXPORT_PROPERTY(@"backIndicatorTransitionMaskImage");
}

@end
