//
//  KIMICore.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/8/13.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "KIMICore.h"
#import <Endo/EDOExporter.h>

@implementation KIMICore

+ (void)load {
    EDO_EXPORT_CLASS(@"KMCore", nil);
    EDO_EXPORT_STATIC_READONLY_PROPERTY(@"edo_version");
}

+ (NSString *)edo_version {
    return @"0.1.0";
}

@end
