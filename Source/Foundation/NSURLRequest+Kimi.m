//
//  NSURLRequest+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/10.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "NSURLRequest+Kimi.h"
#import <Endo/EDOExporter.h>

@implementation NSURLRequest (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"URLRequest", nil);
    EDO_EXPORT_READONLY_PROPERTY(@"HTTPMethod");
    EDO_EXPORT_READONLY_PROPERTY(@"URL");
    EDO_EXPORT_READONLY_PROPERTY(@"allHTTPHeaderFields");
    EDO_EXPORT_METHOD(valueForHTTPHeaderField:);
    EDO_EXPORT_READONLY_PROPERTY(@"HTTPBody");
    EDO_EXPORT_METHOD(edo_mutable);
    [[EDOExporter sharedExporter] exportInitializer:[self class] initializer:^id(NSArray *arguments) {
        NSURL *aURL = 0 < arguments.count && [arguments[0] isKindOfClass:[NSURL class]] ? arguments[0] : nil;
        if (aURL == nil) {
            aURL = 0 < arguments.count && [arguments[0] isKindOfClass:[NSString class]] ? [NSURL URLWithString:arguments[0]] : nil;
        }
        NSURLRequestCachePolicy cachePolicy = 1 < arguments.count && [arguments[1] isKindOfClass:[NSNumber class]] ? [arguments[1] integerValue] : NSURLRequestUseProtocolCachePolicy;
        NSTimeInterval timeoutInterval = 2 < arguments.count && [arguments[2] isKindOfClass:[NSNumber class]] ? [arguments[2] floatValue] : 15.0;
        if (aURL == nil) {
            return nil;
        }
        return [NSURLRequest requestWithURL:aURL
                                cachePolicy:cachePolicy
                            timeoutInterval:timeoutInterval];
    }];
    [[EDOExporter sharedExporter] exportEnum:@"URLRequestCachePolicy"
                                      values:@{
                                               @"useProtocol": @(NSURLRequestUseProtocolCachePolicy),
                                               @"ignoringLocalCache": @(NSURLRequestReloadIgnoringLocalCacheData),
                                               @"returnCacheElseLoad": @(NSURLRequestReturnCacheDataElseLoad),
                                               @"returnCacheDontLoad": @(NSURLRequestReturnCacheDataDontLoad),
                                               }];
}

- (NSMutableURLRequest *)edo_mutable {
    return [self mutableCopy];
}

@end
