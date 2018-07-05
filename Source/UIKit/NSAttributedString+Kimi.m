//
//  NSAttributedString+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/29.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "NSAttributedString+Kimi.h"
#import <Endo/EDOExporter.h>

@implementation NSAttributedString (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIAttributedString", nil);
    EDO_EXPORT_METHOD(edo_mutable);
    EDO_EXPORT_INITIALIZER({
        NSString *str = 0 < arguments.count && [arguments[0] isKindOfClass:[NSString class]] ? arguments[0] : @"";
        NSDictionary *attributes = 1 < arguments.count && [arguments[1] isKindOfClass:[NSDictionary class]] ? arguments[1] : @{};
        return [[NSAttributedString alloc] initWithString:str attributes:attributes];
    });
    EDO_EXPORT_CONST(@"UIForegroundColorAttributeName", NSForegroundColorAttributeName);
    EDO_EXPORT_CONST(@"UIFontAttributeName", NSFontAttributeName);
    EDO_EXPORT_CONST(@"UIBackgroundColorAttributeName", NSBackgroundColorAttributeName);
    EDO_EXPORT_CONST(@"UIKernAttributeName", NSKernAttributeName);
    EDO_EXPORT_CONST(@"UIStrikethroughStyleAttributeName", NSStrikethroughStyleAttributeName);
    EDO_EXPORT_CONST(@"UIUnderlineStyleAttributeName", NSUnderlineStyleAttributeName);
    EDO_EXPORT_CONST(@"UIStrokeColorAttributeName", NSStrokeColorAttributeName);
    EDO_EXPORT_CONST(@"UIStrokeWidthAttributeName", NSStrokeWidthAttributeName);
    EDO_EXPORT_CONST(@"UIUnderlineColorAttributeName", NSUnderlineColorAttributeName);
    EDO_EXPORT_CONST(@"UIStrikethroughColorAttributeName", NSStrikethroughColorAttributeName);
}

- (NSMutableAttributedString *)edo_mutable {
    return [self mutableCopy];
}

@end
