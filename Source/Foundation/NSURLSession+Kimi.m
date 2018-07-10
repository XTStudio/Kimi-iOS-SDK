//
//  NSURLSession+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/10.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "NSURLSession+Kimi.h"
#import <Endo/EDOExporter.h>

@implementation NSURLSession (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"URLSession", nil);
    EDO_EXPORT_SCRIPT(@";Initializer.shared = new Initializer('__shared__');");
    [[EDOExporter sharedExporter] exportInitializer:[self class] initializer:^id(NSArray *arguments) {
        if (0 < arguments.count && [arguments[0] isKindOfClass:[NSString class]]) {
            if ([arguments[0] isEqualToString:@"__shared__"]) {
                return [NSURLSession sharedSession];
            }
        }
        return [[NSURLSession alloc] init];
    }];
}

- (NSURLSessionTask *)edo_dataTask:(id)obj completion:(void (^)(NSArray *))completion {
    NSURLRequest *request;
    if ([obj isKindOfClass:[NSString class]]) {
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:obj]];
    }
    else if ([obj isKindOfClass:[NSURL class]]) {
        request = [NSURLRequest requestWithURL:obj];
    }
    else if ([obj isKindOfClass:[NSURLRequest class]]) {
        request = obj;
    }
    if (request != nil) {
        return [self dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (completion != nil) {
                completion(@[data ?: [NSNull null], response ?: [NSNull null], error ?: [NSNull null]]);
            }
        }];
    }
    return nil;
}

@end
