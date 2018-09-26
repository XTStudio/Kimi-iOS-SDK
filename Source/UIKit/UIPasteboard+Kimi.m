//
//  UIPasteboard+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/9/26.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "UIPasteboard+Kimi.h"
#import <Endo/EDOExporter.h>

@implementation UIPasteboard (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIPasteboard", nil);
    EDO_EXPORT_STATIC_READONLY_PROPERTY(@"edo_shared");
    EDO_EXPORT_PROPERTY(@"string");
}

+ (UIPasteboard *)edo_shared {
    return [UIPasteboard generalPasteboard];
}

@end
