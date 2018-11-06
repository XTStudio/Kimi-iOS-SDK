//
//  UIScreen+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/3.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIScreen+Kimi.h"
#import "EDOExporter.h"

@implementation UIScreen (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIScreen", nil);
    EDO_EXPORT_READONLY_PROPERTY(@"bounds");
    EDO_EXPORT_READONLY_PROPERTY(@"scale");
    EDO_EXPORT_INITIALIZER({
        return [UIScreen mainScreen];
    });
    EDO_EXPORT_SCRIPT(@"Initializer.main = new Initializer();");
}

@end
