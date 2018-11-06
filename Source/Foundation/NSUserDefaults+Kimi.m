//
//  NSUserDefaults+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/9.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "NSUserDefaults+Kimi.h"
#import <xt_engine/EDOExporter.h>

@implementation NSUserDefaults (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UserDefaults", nil);
    EDO_EXPORT_SCRIPT(@"Initializer.standard = new Initializer('__standard__');");
    EDO_EXPORT_INITIALIZER({
        if (0 < arguments.count && [arguments[0] isKindOfClass:[NSString class]]) {
            if ([arguments[0] isEqualToString:@"__standard__"]) {
                return [NSUserDefaults standardUserDefaults];
            }
            else {
                return [[NSUserDefaults alloc] initWithSuiteName:arguments[0]];
            }
        }
        return [[NSUserDefaults alloc] init];
    });
    EDO_EXPORT_METHOD(edo_valueForKey:);
    EDO_EXPORT_METHOD_ALIAS(edo_setValue:forKey:, @"setValue");
    EDO_EXPORT_METHOD(edo_reset);
}

- (id)edo_valueForKey:(NSString *)forKey {
    return [self valueForKey:forKey];
}

- (void)edo_setValue:(id)value forKey:(NSString *)forKey {
    if (value == nil) {
        [self removeObjectForKey:forKey];
    }
    else {
        [self setObject:value forKey:forKey];
    }
}

- (void)edo_reset {
    NSDictionary *dictionaryRepresentation = [self dictionaryRepresentation];
    for (NSString *aKey in dictionaryRepresentation) {
        [self removeObjectForKey:aKey];
    }
}

@end
