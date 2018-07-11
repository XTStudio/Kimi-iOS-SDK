//
//  NSBundle+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/10.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "NSBundle+Kimi.h"
#import <Endo/EDOExporter.h>

@implementation NSBundle (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"Bundle", nil);
    EDO_EXPORT_SCRIPT(@";Initializer.native = new Initializer('__native__');");
    EDO_EXPORT_SCRIPT(@";Initializer.js = new Initializer('__js__');");
    EDO_EXPORT_METHOD_ALIAS(edo_resourcePath:type:inDirectory:, @"resourcePath");
    EDO_EXPORT_METHOD_ALIAS(edo_resourceURL:type:inDirectory:, @"resourceURL");
    EDO_EXPORT_INITIALIZER({
        if (0 < arguments.count && [arguments[0] isKindOfClass:[NSString class]]) {
            return [NSBundle mainBundle];
        }
        return [NSBundle mainBundle];
    });
}

- (NSString *)edo_resourcePath:(NSString *)name type:(NSString *)type inDirectory:(NSString *)inDirectory {
    return [self pathForResource:name ofType:type inDirectory:inDirectory];
}

- (NSURL *)edo_resourceURL:(NSString *)name type:(NSString *)type inDirectory:(NSString *)inDirectory {
    return [NSURL fileURLWithPath:[self pathForResource:name ofType:type inDirectory:inDirectory]];
}

@end
