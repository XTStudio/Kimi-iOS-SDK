//
//  NSBundle+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/10.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "NSBundle+Kimi.h"
#import <xt_engine/EDOExporter.h>

@implementation KIMIJSBundle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _resources = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)addResource:(NSString *)path base64String:(NSString *)base64String {
    if (base64String != nil && path != nil) {
        [self.resources setObject:base64String forKey:path];
    }
}

- (NSString *)edo_resourcePath:(NSString *)name type:(NSString *)type inDirectory:(NSString *)inDirectory {
    NSString *keyPath;
    if ([type isKindOfClass:[NSString class]]) {
        keyPath = [NSString stringWithFormat:@"%@.%@", name, type];
    }
    else {
        keyPath = name;
    }
    if ([inDirectory isKindOfClass:[NSString class]]) {
        keyPath = [NSString stringWithFormat:@"%@/%@", inDirectory, keyPath];
    }
    if (keyPath != nil && self.resources[keyPath] != nil) {
        return [NSString stringWithFormat:@"/com.xt.bundle.js/%@", keyPath];
    }
    return nil;
}

- (NSURL *)edo_resourceURL:(NSString *)name type:(NSString *)type inDirectory:(NSString *)inDirectory {
    return [NSURL fileURLWithPath:[self edo_resourcePath:name type:type inDirectory:inDirectory]];
}

@end

@implementation NSBundle (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"Bundle", nil);
    EDO_EXPORT_SCRIPT(@"Initializer.native = new Initializer('__native__')");
    EDO_EXPORT_SCRIPT(@"Initializer.js = new Initializer('__js__')");
    EDO_EXPORT_METHOD_ALIAS(edo_resourcePath:type:inDirectory:, @"resourcePath");
    EDO_EXPORT_METHOD_ALIAS(edo_resourceURL:type:inDirectory:, @"resourceURL");
    EDO_EXPORT_METHOD_ALIAS(addResource:base64String:, @"addResource");
    [[EDOExporter sharedExporter] exportInitializer:[self class] initializer:^id(NSArray *arguments) {
        if (0 < arguments.count && [arguments[0] isKindOfClass:[NSString class]]) {
            if ([arguments[0] isEqualToString:@"__native__"]) {
                return [NSBundle mainBundle];
            }
            else {
                return [[KIMIJSBundle alloc] init];
            }
        }
        return nil;
    }];
}

- (NSString *)edo_resourcePath:(NSString *)name type:(NSString *)type inDirectory:(NSString *)inDirectory {
    return [self pathForResource:name ofType:type inDirectory:inDirectory];
}

- (NSURL *)edo_resourceURL:(NSString *)name type:(NSString *)type inDirectory:(NSString *)inDirectory {
    return [NSURL fileURLWithPath:[self pathForResource:name ofType:type inDirectory:inDirectory]];
}

@end
