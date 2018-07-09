//
//  NSMutableData+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/9.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "NSMutableData+Kimi.h"
#import <Endo/EDOExporter.h>

@implementation NSMutableData (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"MutableData", @"Data");
    [[EDOExporter sharedExporter] exportInitializer:[self class] initializer:^id(NSArray *arguments) {
        if (0 < arguments.count && [arguments[0] isKindOfClass:[NSMutableData class]]) {
            return [[NSMutableData alloc] initWithData:arguments[0]];
        }
        else if (0 < arguments.count && [arguments[0] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *params = arguments[0];
            if ([params[@"utf8String"] isKindOfClass:[NSString class]]) {
                return [[params[@"utf8String"] dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
            }
            if ([params[@"base64EncodedData"] isKindOfClass:[NSData class]]) {
                return [[NSMutableData alloc] initWithBase64EncodedData:params[@"base64EncodedData"] options:kNilOptions];
            }
            if ([params[@"base64EncodedString"] isKindOfClass:[NSString class]]) {
                return [[NSMutableData alloc] initWithBase64EncodedString:params[@"base64EncodedString"] options:kNilOptions];
            }
        }
        return [[NSMutableData alloc] init];
    }];
    EDO_EXPORT_METHOD(appendData:);
    EDO_EXPORT_SCRIPT(@"Initializer.prototype.appendArrayBuffer = Initializer.prototype.appendData;");
    EDO_EXPORT_METHOD(setData:);
    EDO_EXPORT_METHOD(edo_immutable);
}

- (NSData *)edo_immutable {
    return [self copy];
}

@end
