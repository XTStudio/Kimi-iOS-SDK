//
//  UIImage+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by 崔明辉 on 2018/6/21.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIImage+Kimi.h"
#import <Endo/EDOExporter.h>

@implementation UIImage (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIImage", nil)
    EDO_EXPORT_INITIALIZER({
        NSDictionary *params = 0 < arguments.count && [arguments[0] isKindOfClass:[NSDictionary class]] ? arguments[0] : @{};
        UIImageRenderingMode renderingMode = [params[@"renderingMode"] isKindOfClass:[NSNumber class]] ? [params[@"renderingMode"] integerValue] : UIImageRenderingModeAutomatic;
        if ([params[@"name"] isKindOfClass:[NSString class]]) {
            return [[UIImage imageNamed:params[@"name"]] imageWithRenderingMode:renderingMode];
        }
        else if ([params[@"base64"] isKindOfClass:[NSString class]]) {
            NSData *data = [[NSData alloc] initWithBase64EncodedString:params[@"base64"] options:kNilOptions];
            if (data != nil) {
                return [[UIImage imageWithData:data] imageWithRenderingMode:renderingMode];
            }
        }
        return nil;
    });
    EDO_EXPORT_PROPERTY(@"size");
    EDO_EXPORT_PROPERTY(@"scale");
    [[EDOExporter sharedExporter] exportEnum:@"UIImageRenderingMode"
                                      values:@{
                                               @"automatic": @(UIImageRenderingModeAutomatic),
                                               @"alwaysOriginal": @(UIImageRenderingModeAlwaysOriginal),
                                               @"alwaysTemplate": @(UIImageRenderingModeAlwaysTemplate),
                                               }];
}

@end
