//
//  UIWindow+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/8/15.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIWindow+Kimi.h"
#import <Endo/EDOExporter.h>

@implementation UIWindow (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIWindow", @"UIView");
    EDO_EXPORT_PROPERTY(@"rootViewController");
    EDO_EXPORT_METHOD(endEditing:);
}

@end