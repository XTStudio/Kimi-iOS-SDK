//
//  UIImage+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/6/21.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIImage+Kimi.h"
#import "EDOExporter.h"
#import "NSFileManager+Kimi.h"

@implementation UIImage (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIImage", nil)
    EDO_EXPORT_INITIALIZER({
        NSDictionary *params = 0 < arguments.count && [arguments[0] isKindOfClass:[NSDictionary class]] ? arguments[0] : @{};
        UIImageRenderingMode renderingMode = [params[@"renderingMode"] isKindOfClass:[NSNumber class]] ? [params[@"renderingMode"] integerValue] : UIImageRenderingModeAutomatic;
        if ([params[@"name"] isKindOfClass:[NSString class]]) {
            UIImage *bundleImageFromJS = [self edo_loadImageFromJSBundle:params[@"name"] renderingMode:renderingMode];
            if (bundleImageFromJS != nil) {
                return bundleImageFromJS;
            }
            return [[UIImage imageNamed:params[@"name"]] imageWithRenderingMode:renderingMode];
        }
        else if ([params[@"base64"] isKindOfClass:[NSString class]]) {
            NSData *data = [[NSData alloc] initWithBase64EncodedString:params[@"base64"] options:kNilOptions];
            if (data != nil) {
                return [[UIImage imageWithData:data] imageWithRenderingMode:renderingMode];
            }
        }
        else if ([params[@"data"] isKindOfClass:[NSData class]]) {
            NSData *data = params[@"data"];
            if (data != nil) {
                return [[UIImage imageWithData:data] imageWithRenderingMode:renderingMode];
            }
        }
        return nil;
    });
    EDO_EXPORT_READONLY_PROPERTY(@"size");
    EDO_EXPORT_READONLY_PROPERTY(@"scale");
    [[EDOExporter sharedExporter] exportEnum:@"UIImageRenderingMode"
                                      values:@{
                                               @"automatic": @(UIImageRenderingModeAutomatic),
                                               @"alwaysOriginal": @(UIImageRenderingModeAlwaysOriginal),
                                               @"alwaysTemplate": @(UIImageRenderingModeAlwaysTemplate),
                                               }];
}

+ (UIImage *)edo_loadImageFromJSBundle:(NSString *)name renderingMode:(UIImageRenderingMode)renderingMode {
    NSInteger currentScale = (NSInteger)[UIScreen mainScreen].scale;
    NSString *targetFile = nil;
    NSArray *files = [[NSFileManager defaultManager] edo_subpathsAtPath:@"/com.xt.bundle.js/images/" deepSearch:NO];
    if ([files containsObject:[self edo_imageFileName:name scale:currentScale]]) {
        targetFile = [NSString stringWithFormat:@"%@%@", @"/com.xt.bundle.js/images/", [self edo_imageFileName:name scale:currentScale]];
    }
    else {
        while (currentScale > 0) {
            NSString *fileName = [self edo_imageFileName:name scale:currentScale];
            if ([files containsObject:fileName]) {
                targetFile = [NSString stringWithFormat:@"%@%@", @"/com.xt.bundle.js/images/", fileName];
                break;
            }
            currentScale--;
        }
        if (targetFile == nil) {
            currentScale = (NSInteger)[UIScreen mainScreen].scale + 1;
            while (currentScale < 5) {
                NSString *fileName = [self edo_imageFileName:name scale:currentScale];
                if ([files containsObject:fileName]) {
                    targetFile = [NSString stringWithFormat:@"%@%@", @"/com.xt.bundle.js/images/", fileName];
                    break;
                }
                currentScale++;
            }
        }
    }
    if (targetFile != nil) {
        NSData *imageData = [[NSFileManager defaultManager] edo_readFile:targetFile];
        if (imageData != nil) {
            return [[UIImage imageWithData:imageData scale:(CGFloat)currentScale] imageWithRenderingMode:renderingMode];
        }
    }
    return nil;
}

+ (NSString *)edo_imageFileName:(NSString *)name scale:(NSInteger)scale {
    if (scale == 1) {
        return [NSString stringWithFormat:@"%@.png", name];
    }
    else {
        return [NSString stringWithFormat:@"%@@%ldx.png", name, (long)scale];
    }
}

@end
