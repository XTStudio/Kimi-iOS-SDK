//
//  NSData+Kimi.m
//  Kimi-iOS-SDKTests
//
//  Created by PonyCui on 2018/7/9.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "NSData+Kimi.h"
#import <xt-engine/EDOExporter.h>

@implementation NSData (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"Data", nil);
    [[EDOExporter sharedExporter] exportInitializer:[self class] initializer:^id(NSArray *arguments) {
        if (0 < arguments.count && [arguments[0] isKindOfClass:[NSData class]]) {
            return arguments[0];
        }
        else if (0 < arguments.count && [arguments[0] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *params = arguments[0];
            if ([params[@"utf8String"] isKindOfClass:[NSString class]]) {
                return [params[@"utf8String"] dataUsingEncoding:NSUTF8StringEncoding];
            }
            if ([params[@"base64EncodedData"] isKindOfClass:[NSData class]]) {
                return [[NSData alloc] initWithBase64EncodedData:params[@"base64EncodedData"] options:kNilOptions];
            }
            if ([params[@"base64EncodedString"] isKindOfClass:[NSString class]]) {
                return [[NSData alloc] initWithBase64EncodedString:params[@"base64EncodedString"] options:kNilOptions];
            }
        }
        return [[NSData alloc] init];
    }];
    EDO_EXPORT_METHOD(edo_arrayBuffer);
    EDO_EXPORT_METHOD(edo_utf8String);
    EDO_EXPORT_METHOD(edo_base64EncodedData);
    EDO_EXPORT_METHOD(edo_base64EncodedString);
    EDO_EXPORT_METHOD(edo_mutable);
}

- (JSValue *)edo_arrayBuffer {
    NSMutableArray *bytes = [NSMutableArray array];
    for (int i = 0; i < self.length; i++) {
        unsigned int byte;
        [self getBytes:&byte range:NSMakeRange(i, 1)];
        [bytes addObject:[NSString stringWithFormat:@"%u", byte]];
    }
    JSValue *arrayBufferValue = [[JSContext currentContext] evaluateScript:[NSString stringWithFormat:@"new Uint8Array([%@]).buffer",
                                                                            [bytes componentsJoinedByString:@","]]];
    return arrayBufferValue;
}

- (NSString *)edo_utf8String {
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

- (NSData *)edo_base64EncodedData {
    return [self base64EncodedDataWithOptions:kNilOptions];
}

- (NSString *)edo_base64EncodedString {
    return [self base64EncodedStringWithOptions:kNilOptions];
}

- (NSMutableData *)edo_mutable {
    return [self mutableCopy];
}

@end
