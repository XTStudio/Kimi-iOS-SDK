//
//  UIProgressView+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/5.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIProgressView+Kimi.h"
#import <Endo/EDOExporter.h>

@implementation UIProgressView (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIProgressView", @"UIView");
    EDO_EXPORT_PROPERTY(@"progress");
    EDO_EXPORT_PROPERTY(@"progressTintColor");
    EDO_EXPORT_PROPERTY(@"trackTintColor");
    EDO_EXPORT_METHOD_ALIAS(setProgress:animated:, @"setProgress");
}

@end
