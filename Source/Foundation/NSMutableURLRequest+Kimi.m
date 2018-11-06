//
//  NSMutableURLRequest+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/10.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "NSMutableURLRequest+Kimi.h"
#import <xt-engine/EDOExporter.h>

@implementation NSMutableURLRequest (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"MutableURLRequest", @"URLRequest");
    EDO_EXPORT_PROPERTY(@"HTTPMethod");
    EDO_EXPORT_PROPERTY(@"allHTTPHeaderFields");
    EDO_EXPORT_METHOD(setValue:forHTTPHeaderField:);
    EDO_EXPORT_PROPERTY(@"HTTPBody");
    EDO_EXPORT_METHOD(edo_immutable);
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
        return [NSMutableURLRequest requestWithURL:aURL
                                       cachePolicy:cachePolicy
                                   timeoutInterval:timeoutInterval];
    }];
}

- (NSURLRequest *)edo_immutable {
    return [self copy];
}

@end
