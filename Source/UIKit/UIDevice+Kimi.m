//
//  UIDevice+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/3.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIDevice+Kimi.h"
#import <xt_engine/EDOExporter.h>

@implementation UIDevice (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIDevice", nil);
    EDO_EXPORT_READONLY_PROPERTY(@"name");
    EDO_EXPORT_READONLY_PROPERTY(@"model");
    EDO_EXPORT_READONLY_PROPERTY(@"systemName");
    EDO_EXPORT_READONLY_PROPERTY(@"systemVersion");
    EDO_EXPORT_READONLY_PROPERTY(@"identifierForVendor");
    EDO_EXPORT_INITIALIZER({
        return [UIDevice currentDevice];
    });
    EDO_EXPORT_SCRIPT(@"Initializer.current = new Initializer();");
}

@end
