//
//  NSURLResponse+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/10.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "NSURLResponse+Kimi.h"
#import "EDOExporter.h"

@implementation NSURLResponse (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"URLResponse", nil);
    EDO_EXPORT_READONLY_PROPERTY(@"URL");
    EDO_EXPORT_READONLY_PROPERTY(@"expectedContentLength");
    EDO_EXPORT_READONLY_PROPERTY(@"MIMEType");
    EDO_EXPORT_READONLY_PROPERTY(@"textEncodingName");
    EDO_EXPORT_READONLY_PROPERTY(@"statusCode");
    EDO_EXPORT_READONLY_PROPERTY(@"allHeaderFields");
}

@end
