//
//  NSIndexPath+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by 崔明辉 on 2018/6/27.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "NSIndexPath+Kimi.h"
#import <Endo/EDOExporter.h>

@implementation NSIndexPath (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UIIndexPath", nil);
    EDO_EXPORT_READONLY_PROPERTY(@"row");
    EDO_EXPORT_READONLY_PROPERTY(@"section");
    [[EDOExporter sharedExporter] exportInitializer:[self class] initializer:^id(NSArray *arguments) {
        if ([arguments count] == 2 && [arguments[0] isKindOfClass:[NSNumber class]] && [arguments[1] isKindOfClass:[NSNumber class]]) {
            return [NSIndexPath indexPathForRow:[arguments[0] integerValue]
                                      inSection:[arguments[0] integerValue]];
        }
        return [NSIndexPath indexPathForRow:0 inSection:0];
    }];
}

@end
