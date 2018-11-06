//
//  NSURL+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/9.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "NSURL+Kimi.h"
#import <xt_engine/EDOExporter.h>

@implementation NSURL (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"URL", nil);
    [[EDOExporter sharedExporter] exportInitializer:[self class] initializer:^id(NSArray *arguments) {
        if (0 < arguments.count && [arguments[0] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *params = arguments[0];
            if ([params[@"URLString"] isKindOfClass:[NSString class]]) {
                return [NSURL URLWithString:params[@"URLString"]
                              relativeToURL:[params[@"baseURL"] isKindOfClass:[NSURL class]] ? params[@"baseURL"] : nil];
            }
            else if ([params[@"filePath"] isKindOfClass:[NSString class]]) {
                return [NSURL fileURLWithPath:params[@"filePath"]];
            }
        }
        return nil;
    }];
    EDO_EXPORT_SCRIPT(@";Initializer.URLWithString = function(URLString, baseURL){ return new URL({URLString: URLString, baseURL: baseURL}) }");
    EDO_EXPORT_SCRIPT(@";Initializer.fileURLWithPath = function(filePath){ return new URL({filePath: filePath}) }");
    EDO_EXPORT_READONLY_PROPERTY(@"absoluteString");
}

@end
