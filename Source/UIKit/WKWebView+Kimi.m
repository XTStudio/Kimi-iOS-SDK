//
//  WKWebView+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by 崔明辉 on 2018/6/29.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "WKWebView+Kimi.h"
#import <Endo/EDOExporter.h>

@implementation WKWebView (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"WKWebView", @"UIView");
    EDO_EXPORT_READONLY_PROPERTY(@"title");
    EDO_EXPORT_READONLY_PROPERTY(@"URL");
    EDO_EXPORT_READONLY_PROPERTY(@"loading");
}

@end
